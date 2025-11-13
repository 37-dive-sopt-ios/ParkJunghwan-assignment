//
//  BannerView.swift
//  Baemin
//
//  Created by 박정환 on 11/13/25.
//

import UIKit
import SnapKit
import Then

final class BannerView: UIView {

    private var banners: [BannerModel] = []
    
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: createLayout()
    ).then {
        $0.isPagingEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .clear
        $0.delegate = self
        $0.dataSource = self
        $0.register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.identifier)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) { fatalError() }
    
    // MARK: - Public
    func configure(with banners: [BannerModel]) {
        self.banners = banners
        collectionView.reloadData()
    }
}

extension BannerView {
    private func setupLayout() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
        self.snp.makeConstraints { $0.height.equalTo(219) }
    }
    
    private func createLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(
            width: UIScreen.main.bounds.width,
            height: 219
        )
        return layout
    }
}

extension BannerView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        banners.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BannerCell.identifier,
            for: indexPath
        ) as? BannerCell else { return UICollectionViewCell() }

        cell.configure(with: banners[indexPath.item])
        return cell
    }
}

extension BannerView: UICollectionViewDelegate {}
