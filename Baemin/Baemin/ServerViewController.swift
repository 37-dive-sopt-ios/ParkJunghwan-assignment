//
//  LoginViewController_Network.swift
//  sopt-37th-03Seminar
//
//  Created by 박정환 on 11/21/25.
//

import UIKit
import SnapKit

final class ServerViewController: BaseViewController {
    
    // MARK: - UI Components
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "배민 서버"
        label.font = UIFont(name: "Pretendard-SemiBold", size: 18)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = .black
        return label
    }()
    
    private let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username (예: johndoe)"
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.addPadding()
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password (예: P@ssw0rd!)"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.addPadding()
        return textField
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "이름 (예: 홍길동)"
        textField.borderStyle = .roundedRect
        textField.addPadding()
        return textField
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email (예: hong@example.com)"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.addPadding()
        return textField
    }()
    
    private let ageTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "나이 (예: 25)"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.addPadding()
        return textField
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("회원가입", for: .normal)
        button.backgroundColor = .mint300
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 18)
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("로그인", for: .normal)
        button.backgroundColor = .mint500
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 18)
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Properties
    
    private let provider: NetworkProviding
    
    // MARK: - Init
    
    init(provider: NetworkProviding = NetworkProvider()) {
        self.provider = provider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setHierarchy()
        setLayout()
    }
    
    // MARK: - UI & Layout
    
    private func setHierarchy() {
        view.addSubviews(
            titleLabel,
            usernameTextField,
            passwordTextField,
            nameTextField,
            emailTextField,
            ageTextField,
            registerButton,
            loginButton
        )
    }
    
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(25)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        usernameTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(32)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(usernameTextField.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        
        ageTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        
        registerButton.snp.makeConstraints {
            $0.bottom.equalTo(loginButton.snp.top).offset(-12)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }
        
        loginButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(48)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }
    }
    
    // MARK: - Actions
    
    @objc private func registerButtonTapped() {
        guard let username = usernameTextField.text, !username.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let name = nameTextField.text, !name.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let ageText = ageTextField.text, let age = Int(ageText) else {
            showAlert(title: "입력 오류", message: "모든 필드를 올바르게 입력해주세요.")
            return
        }
        
        // Swift Concurrency를 사용한 네트워크 요청!
        Task {
            await performRegister(
                username: username,
                password: password,
                name: name,
                email: email,
                age: age
            )
        }
    }
    
    @objc private func loginButtonTapped() {
        guard let username = usernameTextField.text, !username.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(title: "입력 오류", message: "아이디와 비밀번호를 입력해주세요.")
            return
        }
        
        // Swift Concurrency를 사용한 네트워크 요청!
        Task {
            await performLogin(username: username, password: password)
        }
    }
    
    // MARK: - Network Methods (Swift Concurrency!)
    
    /// 회원가입 API 호출
    @MainActor
    private func performRegister(
        username: String,
        password: String,
        name: String,
        email: String,
        age: Int
    ) async {
        loadingIndicator.startAnimating()
        
        do {
            // UserAPI의 convenience method 사용
            let response = try await UserAPI.performRegister(
                username: username,
                password: password,
                name: name,
                email: email,
                age: age,
                provider: provider
            )
            
            // 성공 시 알림만 표시
            showAlert(title: "회원가입 성공", message: "회원가입이 완료되었습니다!") {
                // 단순히 알림만 닫음
            }
        } catch let error as NetworkError {
            // 콘솔에 상세 에러 로그 출력
            print("🚨 [Register Error] \(error.detailedDescription)")
            // 사용자에게는 친절한 메시지 표시
            showAlert(title: "회원가입 실패", message: error.localizedDescription)
        } catch {
            print("🚨 [Register Unknown Error] \(error)")
            showAlert(title: "회원가입 실패", message: error.localizedDescription)
        }
        
        loadingIndicator.stopAnimating()
    }
    
    /// 로그인 API 호출
    @MainActor
    private func performLogin(username: String, password: String) async {
        loadingIndicator.startAnimating()
        
        do {
            // UserAPI의 convenience method 사용
            let response = try await UserAPI.performLogin(
                username: username,
                password: password,
                provider: provider
            )
            
            // 성공 시 Welcome 화면으로 이동
            showAlert(title: "로그인 성공", message: response.message) { [weak self] in
                self?.navigateToWelcome(userId: response.userId, userName: username)
            }
        } catch let error as NetworkError {
            // 콘솔에 상세 에러 로그 출력
            print("🚨 [Login Error] \(error.detailedDescription)")
            // 사용자에게는 친절한 메시지 표시
            showAlert(title: "로그인 실패", message: error.localizedDescription)
        } catch {
            print("🚨 [Login Unknown Error] \(error)")
            showAlert(title: "로그인 실패", message: error.localizedDescription)
        }
        
        loadingIndicator.stopAnimating()
    }
    
    // MARK: - Navigation
    
    private func navigateToWelcome(userId: Int, userName: String) {
        let welcomeVC = ServerWelcomeViewController(id: userId)
        navigationController?.pushViewController(welcomeVC, animated: true)
    }
}

#Preview {
    ServerViewController()
}
