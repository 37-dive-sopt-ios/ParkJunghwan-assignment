//
//  CustomNavigationBar.swift
//  Baemin
//
//  Created by 박정환 on 10/30/25.
//

import UIKit

import SnapKit

final class CustomNavigationBar: UIView {
    
    // MARK: - Properties
    var onBackButtonTapped: (() -> Void)?
    
    // MARK: - UI Components
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "arrow_left"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-SemiBold", size:18)
        label.textColor = .black
        return label
    }()
    
    // MARK: - Initializer
    
    init(title: String) {
        super.init(frame: .zero)
        titleLabel.text = title
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Setup
    private func setUI() {
        self.backgroundColor = .white
        
        addSubviews(backButton, titleLabel)
    }
    
    private func setLayout() {
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(8)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(36)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
    @objc private func backButtonTapped() {
        onBackButtonTapped?()
    }
}

#Preview() {
    CustomNavigationBar(title: "우씨")
}
