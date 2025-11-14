//
//  BrandHorizontalCollectionView.swift
//  Baemin
//
//  Created by 박정환 on 11/13/25.
//

import UIKit
import SnapKit
import Then

final class BrandCollectionView: UIView {
    
    // MARK: - Data
    private var brands: [BrandModel] = []
    
    // MARK: - UI Components
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 9
        layout.minimumLineSpacing = 9
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return layout
    }()).then {
        $0.showsHorizontalScrollIndicator = false
        $0.register(BrandCell.self, forCellWithReuseIdentifier: BrandCell.identifier)
        $0.dataSource = self
        $0.delegate = self
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public
    func configure(with brands: [BrandModel]) {
        self.brands = brands
        collectionView.reloadData()
    }
}

// MARK: - UI Setup
private extension BrandCollectionView {
    
    func setupView() {
        addSubview(collectionView)

        backgroundColor = .white

        let topDivider = UIView().then {
            $0.backgroundColor = UIColor.bgWhite
        }
        let bottomDivider = UIView().then {
            $0.backgroundColor = UIColor.bgWhite
        }

        addSubviews(topDivider, bottomDivider)

        topDivider.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(10)
        }

        bottomDivider.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(10)
        }
    }
    
    func setupLayout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - UICollectionView DataSource
extension BrandCollectionView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return brands.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BrandCell.identifier,
            for: indexPath
        ) as? BrandCell else { return UICollectionViewCell() }

        cell.configure(with: brands[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionView Delegate
extension BrandCollectionView: UICollectionViewDelegate {}

extension BrandCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 58, height: 74)
    }
}
