//
//  Log.swift
//  Utility

import Foundation
import OSLog

// MARK: - log
public var log: Log { Log.default } // swiftlint:disable:this identifier_name

// MARK: - Middleware
public protocol LoggerProtocol {
    func debug(
        _ message: String,
        file: StaticString,
        function: StaticString,
        line: Int
    )

    func error(
        _ message: String,
        file: StaticString,
        function: StaticString,
        line: Int
    )
}

// MARK: - LoggerWrapper
public struct Log: LoggerProtocol {
    fileprivate static let `default`: Log = .init(category: "default") // swiftlint:disable:this strict_fileprivate

    // MARK: - Private Properties
    private let logger: Logger
    private let dateFormatter: DateFormatter = build {
        $0.dateFormat = "yyyy-MM-dd HH:mm:ss"
    }

    // MARK: - Init
    public init(
        subsystem: String = Bundle.main.bundleIdentifier ?? "",
        category: String
    ) {
        self.logger = Logger(subsystem: subsystem, category: category)
    }

    // MARK: - LoggerProtocol
    public func log(
        level: OSLogType,
        file: StaticString = #file,
        function: StaticString = #function,
        line: Int = #line,
        _ message: String = "",
        _ separator: String = ""
    ) {
        let file: String = "\(file)"
        let shotFileName = (file as NSString).lastPathComponent
        let date: Date = .now
        let stringDate = dateFormatter.string(from: date)

        logger.log(level: level, "\(stringDate) \(shotFileName).\(function):\(line) | \(separator) | \(message)")
    }

    public func debug(
        _ message: String = "",
        file: StaticString = #file,
        function: StaticString = #function,
        line: Int = #line
    ) {
        log(level: .debug, file: file, function: function, line: line, message, "DEBUG")
    }

    public func error(
        _ message: String = "",
        file: StaticString = #file,
        function: StaticString = #function,
        line: Int = #line
    ) {
        log(level: .error, file: file, function: function, line: line, message, "ERROR")
    }
}
