//
//  CategoryTabBarCell.swift
//  Baemin
//
//  Created by 박정환 on 11/13/25.
//

import UIKit
import SnapKit
import Then

final class CategoryTabBarCell: UICollectionViewCell {
    
    static let identifier = "CategoryTabBarCell"
    
    // MARK: - UI
    
    private let titleLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Bold", size: 16)
        $0.textColor = UIColor.lightGray
        $0.textAlignment = .center
    }
    
    private let underlineView = UIView().then {
        $0.backgroundColor = UIColor.black
        $0.isHidden = true
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
    
    // MARK: - Setup
    
    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(underlineView)
        contentView.backgroundColor = .white
    }
    
    private func setupLayout() {
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        underlineView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(9)
            $0.centerX.equalTo(titleLabel.snp.centerX)
            $0.height.equalTo(3)
            $0.width.equalTo(titleLabel.snp.width)
        }
    }
    
    // MARK: - Configuration
    
    func configure(item: CategoryTabItem, isSelected: Bool) {
        titleLabel.text = item.title
        titleLabel.textColor = isSelected ? .black : .lightGray
        titleLabel.font = isSelected
            ? .systemFont(ofSize: 18, weight: .bold)
            : .systemFont(ofSize: 18, weight: .semibold)
        underlineView.isHidden = !isSelected
    }
    
    // MARK: - Label Frame Accessor
    func labelFrame() -> CGRect {
        return titleLabel.frame
    }
}
