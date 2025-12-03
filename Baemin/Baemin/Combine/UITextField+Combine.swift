//
//  UITextField+Combine.swift
//  Baemin
//
//  Created by 박정환 on 12/3/25.
//

import UIKit

import Combine

extension UITextField {
    var textPublisher: AnyPublisher<String?, Never> {
        NotificationCenter.default.publisher(
            for: UITextField.textDidChangeNotification,
            object: self
        )
        .map { notification in
            (notification.object as? UITextField)?.text
        }
        .eraseToAnyPublisher()
    }
}
