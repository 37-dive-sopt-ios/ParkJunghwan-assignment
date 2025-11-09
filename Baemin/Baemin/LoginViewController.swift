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

    private var idTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "아이디"
        textField.font = UIFont(name: "Pretendard-Regualr", size:14)
        textField.layer.cornerRadius = 4
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray200.cgColor
        // 텍스트 필드 좌측 패딩 추가
        textField.addLeftPadding()
        textField.leftViewMode = .always
        return textField
    }()
    
    private var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호"
        textField.font = UIFont(name: "Pretendard-Regualr", size:14)
        textField.isSecureTextEntry = true
        textField.layer.cornerRadius = 4
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray200.cgColor
        // 텍스트 필드 좌측 패딩 추가
        textField.addLeftPadding()
        textField.leftViewMode = .always
        
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray200
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 18)
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var clearButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "btn_cancel"), for: .normal)
        button.addTarget(self, action: #selector(clearPasswordField), for: .touchUpInside)
        return button
    }()

    private lazy var eyeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "eye_slash"), for: .normal)
        button.addTarget(self, action: #selector(passwordVisibilityButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private let findAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "계정 찾기"
        label.font = UIFont(name: "Pretendard-Regular", size: 14)
        label.textColor = .black
        return label
    }()
    
    private let findAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "chevron_right"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(findAccountButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var findAccountStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 4
        return stackView
    }()
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
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

extension LoginViewController: WelcomeViewControllerDelegate {
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
