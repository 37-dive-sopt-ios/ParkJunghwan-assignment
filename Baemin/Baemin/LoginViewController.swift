//
//  LoginViewController.swift
//  sopt-37th-01Junior
//
//  Created by 박정환 on 10/11/25.
//

import UIKit

import SnapKit
import Then

final class LoginViewController: UIViewController {
    
    // MARK: - UI Components
        
    private let navigationBar = CustomNavigationBar(title: "이메일 또는 아이디로 계속")

    private let idTextField = UITextField()
    
    private let passwordTextField = UITextField()
    
    private let loginButton = UIButton()
    
    private let clearButton = UIButton()
    
    private let eyeButton = UIButton()
    
    private let findAccountLabel = UILabel()
    
    private let findAccountButton = UIButton(type: .system)
    
    private let findAccountStackView = UIStackView()
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setStyle()
        setLayout()

        // 텍스트필드 편집 이벤트 감지
        idTextField.addTarget(self, action: #selector(textFieldEditingDidBegin(_:)), for: .editingDidBegin)
        idTextField.addTarget(self, action: #selector(textFieldEditingDidEnd(_:)), for: .editingDidEnd)
        passwordTextField.addTarget(self, action: #selector(textFieldEditingDidBegin(_:)), for: .editingDidBegin)
        passwordTextField.addTarget(self, action: #selector(textFieldEditingDidEnd(_:)), for: .editingDidEnd)

        // 로그인 버튼 초기 상태 비활성화
        loginButton.isEnabled = false
        
        // 입력값 변경 시 로그인 버튼 상태 갱신
        idTextField.addTarget(self, action: #selector(updateLoginButtonState), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(updateLoginButtonState), for: .editingChanged)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
    }
    
    // MARK: - UI & Layout
    private func setUI() {
        self.view.backgroundColor = .white
    }
    
    private func setStyle() {
        idTextField.do {
            $0.placeholder = "아이디"
            $0.font = UIFont(name: "Pretendard-Regualr", size: 14)
            $0.layer.cornerRadius = 4
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.gray200.cgColor
            $0.addLeftPadding()
            $0.leftViewMode = .always
        }
        
        passwordTextField.do {
            $0.placeholder = "비밀번호"
            $0.font = UIFont(name: "Pretendard-Regualr", size: 14)
            $0.isSecureTextEntry = true
            $0.layer.cornerRadius = 4
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.gray200.cgColor
            $0.addLeftPadding()
            $0.leftViewMode = .always
        }
        
        loginButton.do {
            $0.backgroundColor = .gray200
            $0.setTitle("로그인", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 18)
            $0.layer.cornerRadius = 4
            $0.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
        }
        
        clearButton.do {
            $0.setImage(UIImage(named: "btn_cancel"), for: .normal)
            $0.addTarget(self, action: #selector(clearPasswordField), for: .touchUpInside)
        }
        
        eyeButton.do {
            $0.setImage(UIImage(named: "eye_slash"), for: .normal)
            $0.addTarget(self, action: #selector(passwordVisibilityButtonDidTap), for: .touchUpInside)
        }
        
        findAccountLabel.do {
            $0.text = "계정 찾기"
            $0.font = UIFont(name: "Pretendard-Regular", size: 14)
            $0.textColor = .black
        }
        
        findAccountButton.do {
            $0.setImage(UIImage(named: "chevron_right"), for: .normal)
            $0.tintColor = .black
            $0.addTarget(self, action: #selector(findAccountButtonTapped), for: .touchUpInside)
        }
        
        findAccountStackView.do {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.spacing = 4
        }
    }
    
    private func setLayout() {
        [navigationBar, idTextField, passwordTextField, loginButton, findAccountStackView, clearButton, eyeButton].forEach {
            self.view.addSubview($0)
        }
        
        findAccountStackView.addArrangedSubview(findAccountLabel)
        findAccountStackView.addArrangedSubview(findAccountButton)
        
        clearButton.isHidden = true
        eyeButton.isHidden = true
        
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        idTextField.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(44)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(12)
            $0.leading.trailing.equalTo(idTextField)
            $0.height.equalTo(44)
        }
        
        clearButton.snp.makeConstraints {
            $0.trailing.equalTo(passwordTextField.snp.trailing).inset(36)
            $0.centerY.equalTo(passwordTextField.snp.centerY)
            $0.size.equalTo(20)
        }

        eyeButton.snp.makeConstraints {
            $0.trailing.equalTo(passwordTextField.snp.trailing).inset(8)
            $0.centerY.equalTo(passwordTextField.snp.centerY)
            $0.size.equalTo(20)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(idTextField)
            $0.height.equalTo(48)
        }
        
        findAccountStackView.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Navigation
    
    private func pushToWelcomeVC() {
        let welcomeViewController = WelcomeViewController()
        welcomeViewController.name = idTextField.text
        welcomeViewController.delegate = self

        self.navigationController?.pushViewController(welcomeViewController, animated: true)
    }
    
    // MARK: - @objc
    
    @objc
    private func loginButtonDidTap() {
        pushToWelcomeVC()
    }
    
    // 텍스트가 활성화 되면 버튼 보이게
    @objc
    private func textFieldEditingDidBegin(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.baeminBlack.cgColor
        textField.layer.borderWidth = 2
        if textField == passwordTextField {
            clearButton.isHidden = false
            eyeButton.isHidden = false
        }
    }
    
    // 텍스트가 비활성화 되면 버튼 안 보이게
    @objc
    private func textFieldEditingDidEnd(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.gray200.cgColor
        if textField == passwordTextField {
            clearButton.isHidden = true
            eyeButton.isHidden = true
        }
    }
    
    // 눈 버튼 작동
    @objc
    private func passwordVisibilityButtonDidTap(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry.toggle()
        let imageName = passwordTextField.isSecureTextEntry ? "eye_slash" : "eye"
        sender.setImage(UIImage(named: imageName), for: .normal)
    }
    
    // 지우기 버튼 작동
    @objc
    private func clearPasswordField() {
        passwordTextField.text = ""
    }
    
    @objc
    private func findAccountButtonTapped() {
        print("계정 찾기 버튼 탭됨")
    }
    
    // 로그인 버튼 활성화
    @objc
    private func updateLoginButtonState() {
        let isIDFilled = !(idTextField.text?.isEmpty ?? true)
        let isPasswordFilled = !(passwordTextField.text?.isEmpty ?? true)
        
        loginButton.isEnabled = isIDFilled && isPasswordFilled
        loginButton.backgroundColor = loginButton.isEnabled ? .mint500 : .gray200
    }
}

 // MARK: - UI State Updates

extension LoginViewController: BackButtonDelegate {
    func didTapBackButton() {
        // 텍스트 초기화
        idTextField.text = ""
        passwordTextField.text = ""
        updateLoginButtonState()
    }
}

#Preview() {
    LoginViewController()
}
