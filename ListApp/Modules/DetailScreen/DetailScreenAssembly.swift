//
//  DetailScreenAssembly.swift
//  DetailApp
//
//  Created by Nikita Omelchenko on 31.03.2025.
//

import UIKit

private typealias Module = DetailScreenModule

struct DetailScreenModule { }

// MARK: - Assembly
protocol DetailAssemblyProtocol: ModuleAssemblying {
    func assemble(with item: ResponseModels.CharacterModels.ResultModel) -> UIViewController
}

// MARK: - DetailScreenDisplayLogic
protocol DetailScreenDisplayLogic: AnyObject {
    func displaySomething(with item: DetailScreenModule.Models.ViewModel)
}

// MARK: - DetailScreenPresentationLogic
protocol DetailScreenPresentationLogic {
    func presentSomething(item: ResponseModels.CharacterModels.ResultModel)
}

// MARK: - DetailScreenBusinessLogic
protocol DetailScreenBusinessLogic {
    func fetchData()
}

// MARK: - DetailScreenRoutingLogic
protocol DetailScreenRoutingLogic {
}

// MARK: - DetailScreenDataPassing
protocol DetailScreenDataPassing {
    var dataStore: DetailScreenDataStore? { get }
}

// MARK: - DetailScreenDataStore
protocol DetailScreenDataStore { }

// MARK: - Module Extesion
extension Module {
    final class DetailScreenAssembly: DetailAssemblyProtocol {
        // MARK: - Assemble
        func assemble(with item: ResponseModels.CharacterModels.ResultModel) -> UIViewController {
            let viewController = Module.ViewController()

            let interactor = Module.Interactor(item: item)
            let presenter = Module.Presenter()
            let router = Module.Router()

            viewController.interactor = interactor
            viewController.router = router

            interactor.presenter = presenter

            presenter.viewController = viewController

            router.viewController = viewController
            router.dataStore = interactor

            return viewController
        }
    }
}
