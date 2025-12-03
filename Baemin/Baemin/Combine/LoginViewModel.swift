//
//  LoginViewModel.swift
//  Baemin
//
//  Created by 박정환 on 12/3/25.
//

import Combine
import Foundation

final class LoginViewModel {

    // MARK: - Input
    let id = CurrentValueSubject<String, Never>("")
    let password = CurrentValueSubject<String, Never>("")

    // MARK: - Output
    lazy var isLoginEnabled: AnyPublisher<Bool, Never> = {
        Publishers.CombineLatest(id, password)
            .map { !$0.isEmpty && !$1.isEmpty }
            .eraseToAnyPublisher()
    }()

    // 로그인 성공 이벤트 (Welcome으로 이동)
    let loginSuccess = PassthroughSubject<String, Never>()

    // MARK: - Actions
    
    func loginButtonTapped() {
        loginSuccess.send(id.value)
    }
}
