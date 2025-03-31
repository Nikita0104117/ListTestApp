//
//  Assamblying+Extesions.swift
//  ListApp
//
//  Created by Nikita Omelchenko on 30.03.2025.
//

import UIKit

protocol ModuleAssemblying {
    func assemble() -> UIViewController
}

extension ModuleAssemblying {
    func assemble() -> UIViewController {
        .init()
    }
}
