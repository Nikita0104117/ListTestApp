//
//  ListScreenAssembly.swift
//  ListApp
//
//  Created by Nikita Omelchenko on 30.03.2025.
//

import UIKit

private typealias Module = ListScreenModule

struct ListScreenModule { }

// MARK: - ListScreenDisplayLogic
protocol ListScreenDisplayLogic: AnyObject {
    func displaySomething(with difference: CollectionDifference<ListScreenModule.Models.ViewModel>)
}

// MARK: - ListScreenPresentationLogic
protocol ListScreenPresentationLogic {
    func presentSomething(response: [ResponseModels.CharacterModels.ResultModel])
    func getDataSourceItemInfo(by index: Int) -> ListScreenModule.Models.ViewModel?
}

// MARK: - ListScreenBusinessLogic
protocol ListScreenBusinessLogic {
    var dataSourceCount: Int { get }

    func fetchData(_ isRefresh: Bool)
    func getDataSourceItemInfo(for indexPath: IndexPath) -> ListScreenModule.Models.ViewModel?
}

// MARK: - ListScreenWorkerLogic
protocol ListScreenWorkerLogic {
    func fetchData(_ isRefresh: Bool) async -> [ResponseModels.CharacterModels.ResultModel]
}

// MARK: - ListScreenRoutingLogic
protocol ListScreenRoutingLogic {
    func pushDetailScreen(with row: Int)
}

// MARK: - ListScreenDataStoreLogic
protocol ListScreenDataStoreLogic {
    var dataSource: [ResponseModels.CharacterModels.ResultModel] { get }
}

// MARK: - Module Extesion
extension Module {
    final class ListScreenAssembly: ModuleAssemblying {
        // MARK: - Injected Assemblies
        @Inject(\.characterTarget) private var characterTarget
        @Inject(\.detailScreenAssembly) private var detailScreenAssembly

        // MARK: - Assemble
        func assemble() -> UIViewController {
            let viewController = Module.ViewController()

            let interactor = Module.Interactor()
            let worker = Module.Worker(characterTarget: characterTarget)
            let presenter = Module.Presenter()
            let router = Module.Router(detailScreenAssembly: detailScreenAssembly)

            viewController.interactor = interactor
            viewController.router = router
            interactor.presenter = presenter
            interactor.worker = worker

            presenter.viewController = viewController

            router.viewController = viewController
            router.dataStore = interactor

            return viewController
        }
    }
}
