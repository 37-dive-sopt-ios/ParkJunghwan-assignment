//
//  WelcomeViewController_Network.swift
//  sopt-37th-03Seminar
//
//  Created by 박정환 on 11/21/25.
//

import UIKit
import SnapKit

public final class ServerWelcomeViewController: UIViewController, Alertable, LoadingIndicatorable {

    // MARK: - UI Components

    public let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .systemBlue
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "환영합니다!\n반갑습니다!"
        label.font = UIFont(name: "Pretendard-SemiBold", size: 18)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()

    private let idTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "id"
        textField.borderStyle = .roundedRect
        textField.addPadding()
        textField.isEnabled = false
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

    private lazy var getUserButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("회원 조회", for: .normal)
        button.backgroundColor = .mint500
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 18)
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(getUserButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var updateUserInfoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("회원 정보 업데이트", for: .normal)
        button.backgroundColor = .mint500
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 18)
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(updateUserButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var deleteUserButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("회원 탈퇴", for: .normal)
        button.backgroundColor = .mint500
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 18)
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(deleteUserButtonTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - Properties

    private let currentId: Int
    private let provider: NetworkProviding

    // MARK: - Init

    public init(id: Int, provider: NetworkProviding = NetworkProvider()) {
        currentId = id
        idTextField.text = "\(currentId)"
        self.provider = provider
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // 하위 클래스에서 뷰를 추가한 후에도 항상 loadingIndicator가 최상위에 위치하게 하도록 함
        view.bringSubviewToFront(loadingIndicator)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        setHierarchy()
        setLayout()
    }

    // MARK: - UI Setup

    private func setHierarchy() {

        view.addSubviews(
            titleLabel,
            loadingIndicator,
            idTextField,
            nameTextField,
            emailTextField,
            ageTextField,
            getUserButton,
            updateUserInfoButton,
            deleteUserButton,
        )
    }

    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        loadingIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        idTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(32)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(55)
        }
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(55)
        }
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(55)
        }
        ageTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(55)
        }
        getUserButton.snp.makeConstraints {
            $0.bottom.equalTo(updateUserInfoButton.snp.top).offset(-12)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(55)
        }
        updateUserInfoButton.snp.makeConstraints {
            $0.bottom.equalTo(deleteUserButton.snp.top).offset(-12)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(55)
        }
        deleteUserButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(48)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(55)
        }
    }

    // MARK: - Actions

    @objc private func getUserButtonTapped() {
        guard let id = Int(idTextField.text ?? "") else {
            return
        }
        Task {
            await performGetUser(id: id)
        }
    }

    @objc private func updateUserButtonTapped() {
        guard let id = Int(idTextField.text ?? "") else {
            return
        }
        Task {
            await performUpdateUserInfo(
                id: id,
                name: nameTextField.text,
                email: emailTextField.text,
                age: Int(ageTextField.text ?? "")
            )
        }
    }

    @objc private func deleteUserButtonTapped() {
        guard let id = Int(idTextField.text ?? "") else {
            return
        }
        Task {
            await performDeleteUser(id: id)
        }
    }

    @MainActor
    private func performGetUser(id: Int) async {
        loadingIndicator.startAnimating()

        do {
            // UserAPI의 convenience method 사용
            let response = try await UserAPI.performGetUserInfo(id: id, provider: provider)

            // Update text fields with response data
            nameTextField.text = response.name
            emailTextField.text = response.email
            ageTextField.text = "\(response.age)"

            showAlert(title: "회원조회 성공", message: "\(response)")
        } catch let error as NetworkError {
            // 콘솔에 상세 에러 로그 출력
            print("🚨 [Get User Error] \(error.detailedDescription)")
            // 사용자에게는 친절한 메시지 표시
            showAlert(title: "회원조회 실패", message: error.localizedDescription)
        } catch {
            print("🚨 [Get User Unknown Error] \(error)")
            showAlert(title: "회원조회 실패", message: error.localizedDescription)
        }

        loadingIndicator.stopAnimating()
    }

    @MainActor
    private func performUpdateUserInfo(
        id: Int,
        name: String?,
        email: String?,
        age: Int?
    ) async {
        loadingIndicator.startAnimating()

        do {
            // UserAPI의 convenience method 사용
            let response = try await UserAPI.performUpdateUserInfo(
                id: id,
                name: name,
                email: email,
                age: age,
                provider: provider
            )

            // 성공 시 Welcome 화면으로 이동
            showAlert(title: "회원정보 업데이트 성공", message: "\(response)")
        } catch let error as NetworkError {
            // 콘솔에 상세 에러 로그 출력
            print("🚨 [Update User Info Error] \(error.detailedDescription)")
            // 사용자에게는 친절한 메시지 표시
            showAlert(title: "회원정보 업데이트 실패", message: error.localizedDescription)
        } catch {
            print("🚨 [Update User Info Unknown Error] \(error)")
            showAlert(title: "회원정보 업데이트 실패", message: error.localizedDescription)
        }

        loadingIndicator.stopAnimating()
    }

    @MainActor
    private func performDeleteUser(id: Int) async {
        loadingIndicator.startAnimating()

        do {
            // UserAPI의 convenience method 사용
            _ = try await UserAPI.performDeleteUser(id: id, provider: provider)

            // 성공 시 Welcome 화면으로 이동
            showAlert(title: "회원탈퇴 성공", message: "회원탈퇴가 완료되었습니다!") { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
        } catch let error as NetworkError {
            // 콘솔에 상세 에러 로그 출력
            print("🚨 [Delete User Error] \(error.detailedDescription)")
            // 사용자에게는 친절한 메시지 표시
            showAlert(title: "회원탈퇴 실패", message: error.localizedDescription)
        } catch {
            print("🚨 [Delete User Unknown Error] \(error)")
            showAlert(title: "회원탈퇴 실패", message: error.localizedDescription)
        }

        loadingIndicator.stopAnimating()
    }
}

#Preview {
    ServerWelcomeViewController(id: 1)
}
