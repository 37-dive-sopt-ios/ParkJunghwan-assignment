//
//  BrandCell.swift
//  Baemin
//
//  Created by 박정환 on 11/13/25.
//

import UIKit
import SnapKit
import Then

final class BrandCell: UICollectionViewCell {
    
    static let identifier = "BrandCell"
    
    private let brandImageView = UIImageView().then {
        $0.backgroundColor = .bgWhite
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
    }
    
    private let brandLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Regular", size: 14)
        $0.textColor = .baeminBlack
        $0.textAlignment = .center
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: BrandModel) {
        brandImageView.image = model.image
        brandLabel.text = model.title
    }
}

private extension BrandCell {
    func setupHierarchy() {
        contentView.addSubviews(brandImageView, brandLabel)
    }
    
    func setupLayout() {
        brandImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.height.equalTo(54)
            $0.centerX.equalToSuperview()
        }
        
        brandLabel.snp.makeConstraints {
            $0.top.equalTo(brandImageView.snp.bottom).offset(6)
            $0.centerX.equalTo(brandImageView)
        }
    }
}
