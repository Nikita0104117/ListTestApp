//
//  AppRestContainer.swift
//  ListApp
//
//  Created by Nikita Omelchenko on 30.03.2025.
//

import Foundation
import Factory
import Networking
import UIKit

typealias AppContainer = Container
typealias Inject = Injected

#if DEBUG || RELEASE
extension Container {
    // MARK: - Networking
    var restClient: Factory<RestClient> {
        self { RestClient(baseURL: ApiURLsPath.baseUrl, connectivity: self.connectivity.resolve()) }
    }

    // MARK: - Services
    var connectivity: Factory<Connectivity> {
        self { ConnectivityImpl() }
    }

    var database: Factory<DatabaseProtocol> {
        self { Database(persistanceManager: self.persistanceManager.resolve()) }
    }

    var persistanceManager: Factory<PersistenceManagerProtocol> {
        self { PersistenceManager() }
    }

    // MARK: - Targets
    var characterTarget: Factory<CharacterService> {
        self { RestCharacterService(restClient: self.restClient.resolve()) }
    }

    // MARK: - Modules
    var listScreenAssembly: Factory<ModuleAssemblying> { self { MainActor.assumeIsolated { ListScreenModule.ListScreenAssembly() } } }
    var detailScreenAssembly: Factory<DetailAssemblyProtocol> { self { MainActor.assumeIsolated { DetailScreenModule.DetailScreenAssembly() } } }
}
#endif
