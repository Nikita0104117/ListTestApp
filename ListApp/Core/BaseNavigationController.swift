//
//  BaseNavigationController.swift
//  ListApp
//
//  Created by Nikita Omelchenko on 30.03.2025.
//

import UIKit

class BaseNavigationController: UINavigationController {
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)

        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        navigationBar.prefersLargeTitles = true
    }
}
