//
//  String-Additions.swift
//  
//
//  Created by Tami Black on 2/28/21.
//

import Foundation

// MARK: - Subscript
public extension String {
    /// A subscript to get the character at a specified index.
    /// - Parameter integerIndex: The index of the character that we search for.
    /// - Returns: The character found at the specified index.
    subscript(integerIndex: Int) -> Character {
        self[index(startIndex, offsetBy: integerIndex)]
    }

    /// A subscript to get a substring at a specified range.
    /// - Parameter integerRange: The range that will be used to find the substring.
    /// - Returns: The substring corresponding to the specified range.
    subscript(integerRange: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: integerRange.lowerBound)
        let end = index(startIndex, offsetBy: integerRange.upperBound)
        return String(self[start..<end])
    }
}

// MARK: - Prooperties
public extension String {
    /// Checks if the given `String` is formatted as a valid  email address
    var isEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }

    /// Checks if the given `String` is a vaild ip4 address string
    var isIP4Address: Bool {
        confirmIP4isValid(ip4: self)
    }

    /// Checks if the given `String` is a vaild ip6 address string
    var isIP6Address: Bool {
        confirmIP6isValid(ip6: self)
    }

    /// Checks if the given `String` is a vaild ip4 or ip6 address string
    var isIPAddress: Bool {
        confirmIP4isValid(ip4: self) || confirmIP6isValid(ip6: self)
    }

    /// The number of `words` found in the given `String`
    var wordCount: Int {
        let regex = try? NSRegularExpression(pattern: "\\w+")
        return regex?.numberOfMatches(in: self, range: NSRange(location: 0, length: self.utf16.count)) ?? 0
    }
}

// MARK: - Functions
public extension String {

    /// Returns a `String` with the given prefix added.
    /// - Parameter prefix: The `prefix` to be added appended to the front of the `String`.
    /// - Returns: A string with the given prefix.
    func withPrefix(_ prefix: String) -> String {
        self.hasPrefix(prefix) ? self : "\(prefix)\(self)"
    }

    /// Replaces the given `String's given search` substrings with the given `replacement` substring, the given number of `maxReplacements` times  it is found.
    /// - Parameters:
    ///   - search: The substring to be replaced
    ///   - replacement: The replacement substring
    ///   - maxReplacements: The maximum number of times to replace the `search` substring with the `replacement` substring
    /// - Returns: A copy of the given `String` with the replaced substring.
    func replacingOccurances(of search: String, with replacement: String, count maxReplacements: Int) -> String {
        var count = 0
        var returnValue = self

        while let range = returnValue.range(of: search) {
            returnValue = returnValue.replacingCharacters(in: range, with: replacement)
            count += 1

            // Exit as soon as we've made all number of count replacements
            if count == maxReplacements {
                return returnValue
            }
        }

        return returnValue
    }

    /// Returns a copy of the given `String` with white space and newlines removed.
    /// - Returns: A copy of the given `String` with white space and newlines removed.
    func trimmed() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    /// Truncate the given `String` if it's `number of Characters' are greater  than the specific `length`, adding an ellipsis '...' if the `addEllipsis` is set to 'true`
    /// - Parameters:
    ///   - length: The max number of `Characters` the given `String` should be  truncated too  in size.
    ///   - addEllipsis: Add an ellipsis '...' to the given String if the length of the given `String` is longer than the given 'length`
    /// - Returns: A copy of the given `String` truncated, with an `ellipsis` added if `addEllipsis == true`
    func truncated(to length: Int, addEllipsis: Bool = false) -> String {
        if length > count { return self }

        let endPosition = self.index(self.startIndex, offsetBy: length)
        let trimmed = self[..<endPosition]

        return addEllipsis ? "\(trimmed)..." : String(trimmed)
    }
}

// MARK: - Private functions
private extension String {
    // MARK - Private helper functions
    /// Uses the low-leve C API available in `#include <arpa/inet.h>` to determine if a given `String` is a valid ip4 `String`.
    /// - Parameter ip4: The given  `String` to be validated for `ip4` format correctnes
    /// - Returns: `true` if the given `String` is successfully converted from a cString variant of the given String to binary form via inet_pton(AF_INET, cstring, &sin6.sin6_addr)
    private func confirmIP4isValid(ip4: String) -> Bool {
        var sin = sockaddr_in()
        return ip4.withCString { cstring in inet_pton(AF_INET, cstring, &sin.sin_addr) } == 1
    }

    /// Uses the low-leve C API available in `#include <arpa/inet.h>` to determine if a given `String` is a valid ip6 `String`.
    /// - Parameter ip6: The given  `String` to be validated for `ip6` format correctnes
    /// - Returns: `true` if the given `String` is successfully converted from a cString variant of the given String to binary form via inet_pton(AF_INET6, cstring, &sin6.sin6_addr)
    private func confirmIP6isValid(ip6: String) -> Bool {
        var sin6 = sockaddr_in6()
        return ip6.withCString { cstring in inet_pton(AF_INET6, cstring, &sin6.sin6_addr) } == 1
    }
}
