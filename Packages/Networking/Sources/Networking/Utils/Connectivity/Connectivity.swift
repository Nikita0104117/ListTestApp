//
//  Connectivity.swift
//

import Foundation
import Combine

public protocol Connectivity: AnyObject {
    var isReachable: AnyPublisher<ConnectivityImpl.Status, Never> { get }
    var isReachableValue: ConnectivityImpl.Status { get }
    var isReachableFlag: Bool { get }

    func startObserving()
    func stopObserving()
}
