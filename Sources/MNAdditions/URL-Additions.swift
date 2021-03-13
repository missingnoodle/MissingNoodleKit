//
//  URL-Additions..swift
//  
//
//  Created by Tami Black on 2/28/21.
//

import Foundation

// MARK: - Initializers
public extension URL {
    /// Takes a `StaticString` and returns a non-optional `URL`.  It will fail if the given `StaticString` cannot be initialized as an `URL`.
    /// - Parameter string: The `StaticString` (e.g. "https://www.apple.com") to create a non-optional to an `URL`.
    init(_ string: StaticString) {
        if let url = URL(string: "\(string)") {
            self = url
        } else {
            fatalError("Illegal URL: \(string)")
        }
    }
}
// MARK: - Properties
public extension URL {
    // swiftlint:disable discouraged_optional_collection
    /// Extract the query items from an URL.
    /// - Returns: A dictionary containing all the query items found. If no items found then it will return nil.
    var queryParameters: [String: String]? {
        guard let components = URLComponents(url: self as URL, resolvingAgainstBaseURL: true),
              let queryItems = components.queryItems else {
            return nil
        }

        var parameters = [String: String]()
        queryItems.forEach {
            parameters[$0.name] = $0.value
        }
        return parameters
    }
}

// MARK: - Functions
public extension URL {
    /// Add the `URLResourceKey.isExcludedFromBackupKey` attribute to the URL.
    ///
    /// This key is used to determine whether the resource is excluded from all backups of app data.
    func addSkipBackupAttribute() throws {
        try (self as NSURL).setResourceValue(true, forKey: URLResourceKey.isExcludedFromBackupKey)
    }
}
