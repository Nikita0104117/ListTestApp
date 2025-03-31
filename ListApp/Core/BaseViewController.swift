//
//  BaseViewController.swift
//  ListApp
//
//  Created by Nikita Omelchenko on 30.03.2025.
//

import UIKit

class BaseViewController: UIViewController {
    // MARK: - Inits
    init() { super.init(nibName: nil, bundle: nil) }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    func showError(_ title: String, message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        present(alertController, animated: true, completion: nil)
    }
}
