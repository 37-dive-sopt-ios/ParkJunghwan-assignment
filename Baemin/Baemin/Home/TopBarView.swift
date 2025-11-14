//
//  TopBarView.swift
//  Baemin
//
//  Created by 박정환 on 11/13/25.
//

import UIKit
import SnapKit
import Then

final class TopBarView: UIView {
    
    // MARK: - UI Components
    
    private let locationButton = UIButton().then {
        $0.setTitle("우리집 ▼", for: .normal)
        $0.setTitleColor(.baeminBlack, for: .normal)
        $0.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 16)
        $0.contentHorizontalAlignment = .left
    }
    
    private let benefitButton = UIButton().then {
        $0.setImage(UIImage(named: "ic_sale"), for: .normal)
    }
    
    private let alarmButton = UIButton().then {
        $0.setImage(UIImage(named: "ic_alarm"), for: .normal)
    }
    
    private let cartButton = UIButton().then {
        $0.setImage(UIImage(named: "ic_cart"), for: .normal)
    }
    
    private lazy var rightStackView = UIStackView(arrangedSubviews: [
        benefitButton, alarmButton, cartButton
    ]).then {
        $0.axis = .horizontal
        $0.spacing = 16
        $0.alignment = .center
        $0.distribution = .equalSpacing
    }

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
    }
    
    private func setHierarchy() {
        addSubview(locationButton)
        addSubview(rightStackView)
    }
    
    private func setLayout() {
        locationButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        rightStackView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
    }
}
