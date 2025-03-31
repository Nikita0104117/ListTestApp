//
//  UIView+Extesion.swift
//  Extensions
//
//  Created by Nikita Omelchenko on 30.03.2025.
//

import UIKit

public extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
}

public extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { self.addArrangedSubview($0) }
    }
}
