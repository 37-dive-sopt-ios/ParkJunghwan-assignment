//
//  CategoryGridView.swift
//  Baemin
//
//  Created by 박정환 on 11/13/25.
//

import UIKit
import SnapKit
import Then

final class CategoryGridView: UIView {

    // MARK: - Properties

    private var pages: [[CategoryGridItem]] = []
    private var flatItems: [CategoryGridItem] = []
    var onPageChanged: ((Int) -> Void)?                // 페이지 변경 콜백

    // MARK: - UI Components

    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: CategoryGridView.createLayout()
    ).then {
        $0.backgroundColor = .white
        $0.showsHorizontalScrollIndicator = false
        $0.isPagingEnabled = true
        $0.register(CategoryGridCell.self,
                    forCellWithReuseIdentifier: CategoryGridCell.identifier)
        $0.dataSource = self
        $0.delegate = self
    }

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup

private extension CategoryGridView {
    func setupUI() {
        addSubview(collectionView)
    }

    func setupLayout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - Public

extension CategoryGridView {

    /// 상위 뷰에서 pages(페이지별 10개) 넘겨줌
    func configure(pages: [[CategoryGridItem]]) {
        self.pages = pages
        self.flatItems = pages.flatMap { $0 }
        collectionView.reloadData()
    }

    /// 탭 클릭 시 해당 페이지로 이동
    func scrollToPage(_ page: Int) {
        let offsetX = CGFloat(page) * collectionView.bounds.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension CategoryGridView: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1 // 단일 섹션
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flatItems.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoryGridCell.identifier,
            for: indexPath
        ) as? CategoryGridCell else { return UICollectionViewCell() }

        cell.configure(model: flatItems[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension CategoryGridView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        let page = indexPath.item / 10
        onPageChanged?(page)
    }
}

// MARK: - Scroll page detection

extension CategoryGridView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(round(scrollView.contentOffset.x / scrollView.bounds.width))
        onPageChanged?(page)
    }
}

// MARK: - Compositional Layout

extension CategoryGridView {
    static func createLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(62),
            heightDimension: .absolute(78)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(180)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: 5
        )
        group.interItemSpacing = .fixed(9)

        let group2 = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitem: group,
            count: 2
        )
        group2.interItemSpacing = .fixed(12)

        let section = NSCollectionLayoutSection(group: group2)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 16, bottom: 0, trailing: 16)

        return UICollectionViewCompositionalLayout(section: section)
    }
}
