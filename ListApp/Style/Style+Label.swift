//
//  Style+Label.swift
//  ListApp
//
//  Created by Nikita Omelchenko on 30.03.2025.
//

import UIKit

extension Style.Label {
    // MARK: - (textColor)(FontType)(FontSize)
    static let commonBold24: ColoredLabel = .init(titleColor: AppColors.Text.black.color, font: Style.Font.bold24)
    static let commonRegular12: ColoredLabel = .init(titleColor: AppColors.Text.black.color, font: Style.Font.regular12)
}

// MARK: - Label Applicable
extension Style.Label {
    public struct ColoredLabel: Applicable {
        var titleColor: UIColor
        var font: UIFont

        public init(titleColor: UIColor, font: UIFont) {
            self.titleColor = titleColor
            self.font = font
        }

        public func apply(_ object: UILabel) {
            object.textColor = titleColor
            object.font = font
            object.numberOfLines = 0
        }
    }
}
