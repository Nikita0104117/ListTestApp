//
//  Style+Label.swift
//  ListApp
//
//  Created by Nikita Omelchenko on 30.03.2025.
//

import UIKit

extension Style.Label {
    // MARK: - (textColor)(FontType)(FontSize)
    static let commonExtraBold24: ColoredLabel = .init(titleColor: AppColors.Text.blackText.color, font: Style.Font.extraBold24)
    static let commonRegular16: ColoredLabel = .init(titleColor: AppColors.Text.blackText.color, font: Style.Font.regular16)
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
