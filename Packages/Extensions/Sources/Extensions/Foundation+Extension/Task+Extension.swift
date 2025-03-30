//
//  Task+Extension.swift
//  Extensions

import Foundation

extension Task where Failure == Never, Success == Void {
    @discardableResult
    /// Usage example:
    /// ```
    /// Task {
    ///     let requestModel: RequestModels.SignUpModel = .init(userName: phoneNumber, password: password)
    ///     let resultModel = try await self.authService.signUp(requestModel)
    ///     self.saveUser(model: resultModel)
    /// } catch: { error in
    ///     AppLog.error(error.localizedDescription)
    /// }
    /// ```
    public init(
        priority: TaskPriority? = nil,
        operation: @escaping () async throws -> Void,
        `catch`: @escaping (Error) -> Void
    ) {
        self.init(priority: priority) {
            do {
                _ = try await operation()
            } catch {
                `catch`(error)
            }
        }
    }

    @discardableResult
    public init(
        priority: TaskPriority? = nil,
        operation: @escaping () async throws -> Void,
        `catchInMain`: @escaping (Error) -> Void
    ) {
        self.init(priority: priority) {
            do {
                _ = try await operation()
            } catch {
                await MainActor.run {
                    `catchInMain`(error)
                }
            }
        }
    }
}

@available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
extension Task where Success == Never, Failure == Never {
    /// Suspends the current task for at least the given duration
    /// in seconds.
    ///
    /// If the task is canceled before the time ends,
    /// this function throws `CancellationError`.
    ///
    /// This function doesn't block the underlying thread.
    public static func sleep(seconds duration: UInt64) async throws {
        try await Task.sleep(nanoseconds: duration * NSEC_PER_SEC)
    }
}
