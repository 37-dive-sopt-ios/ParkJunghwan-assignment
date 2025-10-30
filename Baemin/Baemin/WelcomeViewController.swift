//
//  WelcomeViewController.swift
//  sopt-37th-01Junior
//
//  Created by 박정환 on 10/11/25.
//

import Foundation
import UIKit
import SnapKit

protocol WelcomeViewControllerDelegate: AnyObject {
    func didTapBackButton()
}

final class WelcomeViewController: UIViewController {
    
    var name: String?
    
    weak var delegate: WelcomeViewControllerDelegate?
    
    // MARK: - UI Components

    private let navigationBar = CustomNavigationBar(title: "대체 뼈짐 누가 시켰어??")
    
    private let welcomeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "welcomeImg")	
        return imageView
    }()
    
    private let welcomeTitle: UILabel = {
        let label = UILabel()
        label.text = "환영합니다"
        label.font = UIFont(name: "Pretendard-Bold", size: 24)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "???님 반가워요!"
        label.font = UIFont(name: "Pretendard-Semibold", size: 18)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var backToLoginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .mint500
        button.setTitle("뒤로가기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 18)
        button.addTarget(self, action: #selector(backToLoginButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        self.view.backgroundColor = .white
        setLayout()
        
        bindID()
    }
    
    // MARK: - Layout

    private func setLayout() {
        [navigationBar, welcomeImageView, welcomeTitle, welcomeLabel, backToLoginButton].forEach {
            self.view.addSubview($0)
        }
        
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(42)
        }
        
        welcomeImageView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        welcomeTitle.snp.makeConstraints {
            $0.top.equalTo(welcomeImageView.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
        }
        
        welcomeLabel.snp.makeConstraints {
            $0.top.equalTo(welcomeTitle.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        
        backToLoginButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(48)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(52)
            $0.width.equalTo(343)
        }
    }
    
    private func bindID() {
        guard let username = name else { return }
        self.welcomeLabel.text = "\(username)님 반가워요!"
    }
    
    @objc
    private func backToLoginButtonDidTap() {
        delegate?.didTapBackButton()
        
        if self.navigationController == nil {
            self.dismiss(animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

#Preview() {
    WelcomeViewController()
}
