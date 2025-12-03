//
//  LoginViewController.swift
//  sopt-37th-01Junior
//
//  Created by 박정환 on 10/11/25.
//

import UIKit

import SnapKit
import Then
import Combine

final class LoginViewController_Combine: UIViewController, BackButtonDelegate {

    private let viewModel = LoginViewModel()
    private var cancellables = Set<AnyCancellable>()

    // UI Components
    private let navigationBar = CustomNavigationBar(title: "이메일 또는 아이디로 계속")
    private let idTextField = UITextField()
    private let passwordTextField = UITextField()
    private let loginButton = UIButton()
    private let clearButton = UIButton()
    private let eyeButton = UIButton()
    private let findAccountLabel = UILabel()
    private let findAccountButton = UIButton(type: .system)
    private let findAccountStackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)

        setUI()
        setStyle()
        setLayout()
        bind()
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

    // MARK: - Bindings
    
    private func bind() {
        // 텍스트 변화 -> ViewModel로 전달
        idTextField.textPublisher
            .compactMap { $0 }
            .assign(to: \.value, on: viewModel.id)
            .store(in: &cancellables)

        passwordTextField.textPublisher
            .compactMap { $0 }
            .assign(to: \.value, on: viewModel.password)
            .store(in: &cancellables)

        passwordTextField.textPublisher
            .compactMap { $0 }
            .sink { [weak self] text in
                guard let self = self else { return }
                let hasText = !(text?.isEmpty ?? true)
                self.clearButton.isHidden = !hasText
                self.eyeButton.isHidden = !hasText
            }
            .store(in: &cancellables)

        // 로그인 버튼 활성화 상태 바인딩
        viewModel.isLoginEnabled
            .receive(on: RunLoop.main)
            .sink { [weak self] isEnabled in
                self?.loginButton.isEnabled = isEnabled
                self?.loginButton.backgroundColor = isEnabled ? .mint500 : .gray200
            }
            .store(in: &cancellables)

        NotificationCenter.default.publisher(for: UITextField.textDidBeginEditingNotification, object: passwordTextField)
            .sink { [weak self] _ in
                self?.passwordTextField.layer.borderColor = UIColor.baeminBlack.cgColor
                self?.passwordTextField.layer.borderWidth = 2
                self?.clearButton.isHidden = false
                self?.eyeButton.isHidden = false
            }
            .store(in: &cancellables)

        NotificationCenter.default.publisher(for: UITextField.textDidEndEditingNotification, object: passwordTextField)
            .sink { [weak self] _ in
                self?.passwordTextField.layer.borderColor = UIColor.gray200.cgColor
                self?.clearButton.isHidden = true
                self?.eyeButton.isHidden = true
            }
            .store(in: &cancellables)

        // 로그인 성공 → Welcome 이동
        viewModel.loginSuccess
            .receive(on: RunLoop.main)
            .sink { [weak self] username in
                let vc = WelcomeViewController_Combine()
                vc.viewModel = WelcomeViewModel(username: username)
                vc.delegate = self
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            .store(in: &cancellables)
    }

    // MARK: - Actions
    
    @objc
    private func loginButtonDidTap() {
        viewModel.loginButtonTapped()
    }

    @objc
    private func clearPasswordField() {
        passwordTextField.text = ""
    }

    @objc
    private func passwordVisibilityButtonDidTap() {
        passwordTextField.isSecureTextEntry.toggle()
    }

    @objc
    private func findAccountButtonTapped() {
        // TODO: 계정 찾기 화면으로 이동 로직 추가
        print("계정 찾기 버튼 탭")
    }

    func didTapBackButton() {
        view.endEditing(true)

        idTextField.text = ""
        passwordTextField.text = ""

        loginButton.isEnabled = false
        loginButton.backgroundColor = .gray200

        idTextField.layer.borderColor = UIColor.gray200.cgColor
        passwordTextField.layer.borderColor = UIColor.gray200.cgColor
        idTextField.layer.borderWidth = 1
        passwordTextField.layer.borderWidth = 1

        clearButton.isHidden = true
        eyeButton.isHidden = true
    }
}

#Preview() {
    LoginViewController_Combine()
}
