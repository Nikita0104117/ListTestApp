//
//  Style+Stack.swift
//  ListApp
//
//  Created by Nikita Omelchenko on 31.03.2025.
//

import UIKit

extension Style.Stack {
    public static let defaultHorizontalStack0 = DefaulStack(spacing: 0, axis: .horizontal)
    public static let defaultVerticalStack0 = DefaulStack(spacing: 0, axis: .vertical)
}

extension Style.Stack {
    public struct DefaulStack: Applicable {
        let spacing: CGFloat
        let axis: NSLayoutConstraint.Axis
        var alignment: UIStackView.Alignment = .fill
        var distribution: UIStackView.Distribution = .fill

        public init(
            spacing: CGFloat,
            axis: NSLayoutConstraint.Axis,
            alignment: UIStackView.Alignment = .fill,
            distribution: UIStackView.Distribution = .fill
        ) {
            self.spacing = spacing
            self.axis = axis
            self.alignment = alignment
            self.distribution = distribution
        }

        public func apply(_ object: UIStackView) {
            object.spacing = spacing
            object.alignment = alignment
            object.distribution = distribution
            object.axis = axis
        }
    }
}
