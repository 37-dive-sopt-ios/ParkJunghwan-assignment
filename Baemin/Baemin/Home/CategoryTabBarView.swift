//
//  CategoryTabBarView.swift
//  Baemin
//
//  Created by 박정환 on 11/13/25.
//

import UIKit
import SnapKit
import Then

protocol CategoryTabBarViewDelegate: AnyObject {
    func categoryTabBarView(_ view: CategoryTabBarView, didSelect index: Int)
}

final class CategoryTabBarView: UIView {
    
    // MARK: - Callbacks
    var onSelectIndex: ((Int) -> Void)?
    
    // MARK: - Properties
    weak var delegate: CategoryTabBarViewDelegate?
    
    private var items: [CategoryTabItem] = []
    private var selectedIndex: Int = 0
    
    // MARK: - UI Components
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 24
        layout.minimumLineSpacing = 24
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        $0.collectionViewLayout = layout
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .white
    }
    
    private let bottomDivider = UIView().then {
        $0.backgroundColor = .bgWhite
    }

    private let roundedBackgroundView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.clipsToBounds = true
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupLayout()
        setupDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        addSubview(roundedBackgroundView)
        roundedBackgroundView.addSubview(collectionView)
        addSubview(bottomDivider)
        
        collectionView.register(CategoryTabBarCell.self, forCellWithReuseIdentifier: CategoryTabBarCell.identifier)
    }
    
    private func setupLayout() {
        roundedBackgroundView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }

        collectionView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }

        bottomDivider.snp.makeConstraints {
            $0.top.equalTo(roundedBackgroundView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    private func setupDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // MARK: - Public
    
    func configure(items: [CategoryTabItem]) {
        self.items = items
        collectionView.reloadData()
    }
    
    func updateSelectedIndex(_ index: Int) {
        selectedIndex = index
        collectionView.reloadData()
        scrollToItem(at: index)
    }

    private func scrollToItem(at index: Int) {
        collectionView.scrollToItem(
            at: IndexPath(item: index, section: 0),
            at: .centeredHorizontally,
            animated: true
        )
    }
    
    func moveToIndex(_ index: Int) {
        selectedIndex = index
        collectionView.selectItem(at: IndexPath(item: index, section: 0), animated: true, scrollPosition: .centeredHorizontally)
    }
}

extension CategoryTabBarView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoryTabBarCell.identifier,
            for: indexPath
        ) as? CategoryTabBarCell else { return UICollectionViewCell() }
        
        let isSelected = indexPath.item == selectedIndex
        cell.configure(item: items[indexPath.item], isSelected: isSelected)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        updateSelectedIndex(indexPath.item)
        onSelectIndex?(indexPath.item)
    }
    
    // 자동 사이즈
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = items[indexPath.item].title as NSString
        let width = text.size(withAttributes: [.font: UIFont(name: "Pretendard-Bold", size: 16)!]).width + 3
        return CGSize(width: width, height: 48)
    }
}
