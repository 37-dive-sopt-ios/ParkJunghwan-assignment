//
//  CategoryCollectionViewCell.swift
//  Baemin
//
//  Created by 박정환 on 11/13/25.
//

import UIKit
import SnapKit

final class CategoryGridCell: UICollectionViewCell {
    
    static let identifier = "CategoryGridCell"
    
    // MARK: - UI Components
    
    private let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 20
        iv.backgroundColor = .bgWhite
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Regular", size: 14)
        label.textColor = .baeminBlack
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - UI
    
    private func setUI() {
        contentView.backgroundColor = .clear
    }
    
    private func setHierarchy() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(nameLabel)
    }
    
    private func setLayout() {
        iconImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.size.equalTo(58)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(iconImageView.snp.bottom).offset(6)
            $0.left.right.equalToSuperview()
        }
    }
    
    
    // MARK: - Configuration
    
    func configure(model: CategoryGridItem) {
        nameLabel.text = model.name
        iconImageView.image = UIImage(named: model.iconName ?? "")
    }
}
