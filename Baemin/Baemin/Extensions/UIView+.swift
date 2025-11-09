//
//  UIView+.swift
//  Baemin
//
//  Created by 박정환 on 11/8/25.
//

import UIKit

public extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
}
