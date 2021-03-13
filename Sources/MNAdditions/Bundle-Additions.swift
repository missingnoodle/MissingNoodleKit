//
//  Bundle-Additions.swift
//  
//
//  Created by Tami Black on 2/28/21.
//

import Foundation

// MARK: - Protocols
public protocol BundleBuildVersion {
    static var buildVersion: String { get }
}

extension Bundle: BundleBuildVersion {
    public static var buildVersion: String { "undefined" }
}

// MARK: - Error Handling: LoggerError
private enum BundleError: Error {
    case bundleIdentifierNotFound
}

extension BundleError: LocalizedError {
    private enum BundleConstants {
        static let bundleIdNotFoundRErrorMsg = "The Application's bundleIdentifier was not found. This should not happen. A re-install is necessary."
        static let bundleIdNotFoundReasonMsg = bundleIdNotFoundRErrorMsg
    }

    var errorDescription: String? {
        switch self {
        case .bundleIdentifierNotFound:
            return NSLocalizedString(BundleConstants.bundleIdNotFoundRErrorMsg,  comment: "")
        }
    }

    var failureReason: String? {
        switch self {
        case .bundleIdentifierNotFound:
            return NSLocalizedString(BundleConstants.bundleIdNotFoundReasonMsg, comment: "")
        }
    }
}

// MARK: - Enums
extension Bundle {
    /// Info.plist properties
    private enum Key {
        static let bundleName = "CFBundleName"
        static let executableName = "CFBundleExecutable"
        static let bundleShortVersion = "CFBundleShortVersionString"
        static let bundleVersion = "CFBundleVersion"
        static let bundleExecutable = "CFBundleExecutable"
        static let bundleId = "CFBundleIdentifier"
        static let bundleURLSchemes = "CFBundleURLSchemes"
        static let bundleURLTypes = "CFBundleURLTypes"
        static let configuration = "Configuration"
    }

    /// Non-Default Info.plist property used for identifying a project's Configuration Scheme
    private enum Configuration: String {
        case debug = "Debug"
        case adHoc = "AdHoc"
        case staging = "Staging"
        case release = "Release"

        var level: String {
            switch self {
            case .debug:
                return self.rawValue
            case .adHoc:
                return self.rawValue
            case .staging:
                return self.rawValue
            case .release:
                return self.rawValue
            }
        }
    }
}

// MARK: - Properties
extension Bundle {
    static var appBuild: String {
        "\(infoPlistValue(forKey: Key.bundleShortVersion))_(\(Bundle.buildVersion))"
    }

    static var appName: String {
        infoPlistValue(forKey: Key.bundleName)
    }

    static var appVersion: String {
        infoPlistValue(forKey: Key.bundleShortVersion)
    }

    static var bundleId: String {
        guard let bundleId = Bundle.main.bundleIdentifier else {
            fatalError(BundleError.bundleIdentifierNotFound.localizedDescription)
        }
        return bundleId
    }

    static var configuration: String {
        infoPlistValue(forKey: Key.configuration)
    }

    static var executableName: String {
        infoPlistValue(forKey: Key.executableName)
    }

    /// Checks wether the app has been installed in TestFlight
    static var inTestFlight: Bool {
        return main.appStoreReceiptURL != nil ? true : false
    }

    /// A String array containing all thecustom URL schemes used for deep linking to content within the application.
    static var customURLSchemes: [String] {
        guard let infoDictionary = main.infoDictionary,
              let urlTypes = infoDictionary[Key.bundleURLTypes] as? [AnyObject],
              let urlType = urlTypes.first as? [String: AnyObject],
              let urlSchemes = urlType[Key.bundleURLSchemes] as? [String] else { return [] }

        return urlSchemes
    }

    /// The primary custom URL scheme used for deep linking to content within the application.
    static var mainURLScheme: String? {
        customURLSchemes.first
    }
}

// MARK: - Functions
extension Bundle {

    /// The contents of a file as `Data` found in the given `Bundle`
    /// - Parameters:
    ///   - filename: The name of the file whose data will be returned encoded as `Data`
    ///   - ext: The extension of the file, The default is `nil`
    ///   - aClass: A class within the `Bundle`, used to identify which `Bundle` to find the file in
    /// - Returns: A `Data` encoded representation of the file with the given `filename`
    static func contentsOfFile(_ filename: String,
                               extension ext: String? = nil,
                               fromBundleWithClass aClass: AnyClass) -> Data {
        let bundle = Bundle(for: aClass)
        guard let url = bundle.url(forResource: filename, withExtension: ext) ?? bundle.url(forResource: filename, withExtension: nil) else {
                fatalError("Failed to locate \(filename) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(filename) from bundle.")
        }
        return data
    }

    /// Transforms a JSON file into data of the passed in type (e.g. `Bundle.main.decode([Award].self, from: "Awards.json")`)
    /// - Parameters:
    ///   - type: The data type the JSON file will be decoded into (e.g. [Award].self)
    ///   - file: The JSON file located in the Bundle
    ///   - dateDecodingStrategy: The JSON Date Decoding strategy to use, the default is .deferredToDate
    ///   - keyDecodingStrategy: The JSON Key Decoding strategy to use, the default is .useDefaultKeys
    /// - Returns: The JSON file data decoded into the given Type T
    public func decode<T: Decodable>(_ type: T.Type,
                                     from filename: String,
                                     fromBundleWithClass aClass: AnyClass,
                                     dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                                     keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T {
        
        let data = Self.contentsOfFile(filename, fromBundleWithClass: aClass)

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy

        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Failed to decode \(filename) from bundle due to missing key '\(key.stringValue)' - \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("Failed to decode \(filename) from bundle due to type mismatch - \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("Failed to decode \(filename) from bundle due to missing \(type) value - \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            fatalError("Failed to decode \(filename) from bundle because it appears to be invalid JSON.")
        } catch {
            fatalError("Failed to decode \(filename) from bundle: \(error.localizedDescription)")
        }
    }
}

// MARK: - Private Functions
extension Bundle {
    /// The value of the given Info.plist dictionary key
    /// - Parameters:
    ///   - key: The Info.plist Key of the Info.plist value to find
    ///   - bundle: The bundle of containing the Info.plist Key/Value, The default Bundle is `Bundle.main`
    /// - Returns: The Value of the given Info.plist Key
    private static func infoPlistValue(forKey key: String, in bundle: Bundle = Bundle.main) -> String {
        guard let infoDictionary = bundle.infoDictionary, let value = infoDictionary[key] as? String else {
            fatalError("The info.plist is missing a required key/value pair.  The a value for the expected info.plist entry: [\(key)] was not found.")
        }
        return value
    }
}
