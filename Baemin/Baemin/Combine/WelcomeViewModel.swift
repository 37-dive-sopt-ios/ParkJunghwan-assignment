//
//  WelcomeViewModel.swift
//  Baemin
//
//  Created by 박정환 on 12/3/25.
//

import Foundation
import Combine

final class WelcomeViewModel {
    @Published var username: String

    init(username: String) {
        self.username = username
    }
}
