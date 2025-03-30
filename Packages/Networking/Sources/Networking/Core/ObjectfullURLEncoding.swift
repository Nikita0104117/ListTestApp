//
//  ObjectfullURLEncoding.swift
//  Networking

import Foundation
import Alamofire
import Utility

public struct ObjectfullURLEncoding: ParameterEncoding {
    // MARK: Helper Types

    /// Defines whether the url-encoded query string is applied to the existing query string or HTTP body of the
    /// resulting URL request.
    public enum Destination: Sendable {
        /// Applies encoded query string result to existing query string for `GET`, `HEAD` and `DELETE` requests and
        /// sets as the HTTP body for requests with any other HTTP method.
        case methodDependent
        /// Sets or appends encoded query string result to existing query string.
        case queryString
        /// Sets encoded query string result as the HTTP body of the URL request.
        case httpBody

        func encodesParametersInURL(for method: HTTPMethod) -> Bool {
            switch self {
                case .methodDependent: return [.get, .head, .delete].contains(method)
                case .queryString: return true
                case .httpBody: return false
            }
        }
    }

    /// Configures how `Array` parameters are encoded.
    public enum ArrayEncoding: Sendable {
        /// An empty set of square brackets is appended to the key for every value. This is the default behavior.
        case brackets
        /// No brackets are appended. The key is encoded as is.
        case noBrackets
        /// Brackets containing the item index are appended. This matches the jQuery and Node.js behavior.
        case indexInBrackets
        /// Provide a custom array key encoding with the given closure.
        case custom(@Sendable (_ key: String, _ index: Int) -> String)

        func encode(key: String, atIndex index: Int) -> String {
            switch self {
                case .brackets:
                    return "\(key)[]"
                case .noBrackets:
                    return key
                case .indexInBrackets:
                    return "\(key)[\(index)]"
                case let .custom(encoding):
                    return encoding(key, index)
            }
        }
    }

    /// Configures how `Bool` parameters are encoded.
    public enum BoolEncoding: Sendable {
        /// Encode `true` as `1` and `false` as `0`. This is the default behavior.
        case numeric
        /// Encode `true` and `false` as string literals.
        case literal

        func encode(value: Bool) -> String {
            switch self {
                case .numeric:
                    return value ? "1" : "0"
                case .literal:
                    return value ? "true" : "false"
            }
        }
    }

    // MARK: Properties

    /// Returns a default `URLEncoding` instance with a `.methodDependent` destination.
    public static var `default`: ObjectfullURLEncoding { ObjectfullURLEncoding() }

    /// Returns a `URLEncoding` instance with a `.queryString` destination.
    public static var queryString: ObjectfullURLEncoding { ObjectfullURLEncoding(destination: .queryString) }

    /// Returns a `URLEncoding` instance with an `.httpBody` destination.
    public static var httpBody: ObjectfullURLEncoding { ObjectfullURLEncoding(destination: .httpBody) }

    /// The destination defining where the encoded query string is to be applied to the URL request.
    public let destination: Destination

    /// The encoding to use for `Array` parameters.
    public let arrayEncoding: ArrayEncoding

    /// The encoding to use for `Bool` parameters.
    public let boolEncoding: BoolEncoding

    // MARK: Initialization

    /// Creates an instance using the specified parameters.
    ///
    /// - Parameters:
    ///   - destination:   `Destination` defining where the encoded query string will be applied. `.methodDependent` by
    ///                    default.
    ///   - arrayEncoding: `ArrayEncoding` to use. `.brackets` by default.
    ///   - boolEncoding:  `BoolEncoding` to use. `.numeric` by default.
    public init(destination: Destination = .methodDependent,
                arrayEncoding: ArrayEncoding = .brackets,
                boolEncoding: BoolEncoding = .numeric) {
        self.destination = destination
        self.arrayEncoding = arrayEncoding
        self.boolEncoding = boolEncoding
    }

    // MARK: Encoding

    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()

        guard let parameters else { return urlRequest }

        if let method = urlRequest.method, destination.encodesParametersInURL(for: method) {
            guard let url = urlRequest.url else {
                throw AFError.parameterEncodingFailed(reason: .missingURL)
            }

            if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
                let percentEncodedQuery = (urlComponents.percentEncodedQuery.map { $0 + "&" } ?? "") + query(parameters)
                urlComponents.percentEncodedQuery = percentEncodedQuery
                urlRequest.url = urlComponents.url
            }
        } else {
            if urlRequest.headers["Content-Type"] == nil {
                urlRequest.headers.update(.contentType("application/x-www-form-urlencoded; charset=utf-8"))
            }

            urlRequest.httpBody = Data(query(parameters).utf8)
        }

        return urlRequest
    }

    /// Creates a percent-escaped, URL encoded query string components from the given key-value pair recursively.
    ///
    /// - Parameters:
    ///   - key:   Key of the query component.
    ///   - value: Value of the query component.
    ///
    /// - Returns: The percent-escaped, URL encoded query string components.
    public func queryComponents(fromKey key: String, value: Any) -> [(String, String)] {
        var components: [(String, String)] = []
        switch value {
            case let dictionary as [String: Any]:
                components += dictionaryQueryComponents(fromKey: key, dictionary: dictionary)
            case let array as [Any]:
                for (index, value) in array.enumerated() {
                    components += queryComponents(fromKey: arrayEncoding.encode(key: key, atIndex: index), value: value)
                }
            case let number as NSNumber:
                if number.isBool {
                    components.append((escape(key), escape(boolEncoding.encode(value: number.boolValue))))
                } else {
                    components.append((escape(key), escape("\(number)")))
                }
            case let bool as Bool:
                components.append((escape(key), escape(boolEncoding.encode(value: bool))))
            default:
                components.append((escape(key), escape("\(value)")))
        }
        if components.isEmpty {
            components.append((escape(key), escape("{}")))
        }
        return components
    }

    public func dictionaryQueryComponents(fromKey key: String, dictionary: [String: Any]) -> [(String, String)] {
        var components: [(String, String)] = []

        if let dictionary: [String: String] = dictionary as? [String: String] {
            let stringDictionary: String = dictionary.enumerated().reduce(into: "") { partialResult, tuple in
                let index = tuple.offset
                let pair = tuple.element

                partialResult += "\"\(pair.key)\":\"\(pair.value)\""
                if index < dictionary.count - 1 {
                    partialResult += ","
                }
            }
            let value = "{\(stringDictionary)}"
            components.append((escape(key), escape(value)))
            log.debug(stringDictionary)
        }

        return components
    }

    /// Creates a percent-escaped string following RFC 3986 for a query string key or value.
    ///
    /// - Parameter string: `String` to be percent-escaped.
    ///
    /// - Returns:          The percent-escaped `String`.
    public func escape(_ string: String) -> String {
        string.addingPercentEncoding(withAllowedCharacters: .afURLQueryAllowed) ?? string
    }

    private func query(_ parameters: [String: Any]) -> String {
        var components: [(String, String)] = []

        for key in parameters.keys.sorted(by: <) {
            // swiftlint:disable:next force_unwrapping
            let value = parameters[key]!
            components += queryComponents(fromKey: key, value: value)
        }
        return components.map { "\($0)=\($1)" }.joined(separator: "&")
    }
}

extension NSNumber {
    // swiftlint:disable:next strict_fileprivate
    fileprivate var isBool: Bool {
        // Use Obj-C type encoding to check whether the underlying type is a `Bool`, as it's guaranteed as part of
        // swift-corelibs-foundation, per [this discussion on the Swift forums]
        // (https://forums.swift.org/t/alamofire-on-linux-possible-but-not-release-ready/34553/22).
        String(cString: objCType) == "c"
    }
}
