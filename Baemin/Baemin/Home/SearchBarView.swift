//
//  SearchBarView.swift
//  Baemin
//
//  Created by 박정환 on 11/13/25.
//

import UIKit
import SnapKit
import Then

final class SearchBarView: UIView {
    
    // MARK: - UI Components
    
    private let containerView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 22
        $0.layer.borderColor = UIColor(named: "baeminBlack")?.cgColor
        $0.layer.borderWidth = 1
    }
    
    let searchTextField = UITextField().then {
        $0.placeholder = "찾아라! 맛있는 음식과 맛집"
        $0.font = UIFont(name: "Pretendard-Regular", size: 14)
        $0.textColor = .gray300
        $0.clearButtonMode = .whileEditing
    }
    
    private let searchIcon = UIImageView().then {
        $0.image = UIImage(systemName: "magnifyingglass")
        $0.tintColor = .gray700
        $0.contentMode = .scaleAspectFit
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupHierarchy() {
        addSubview(containerView)
        containerView.addSubview(searchTextField)
        containerView.addSubview(searchIcon)
    }
    
    private func setupLayout() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        searchIcon.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(17)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }
        
        searchTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(17)
            $0.trailing.equalTo(searchIcon.snp.leading).offset(-8)
            $0.centerY.equalToSuperview()
        }
    }
}
