//
//  Logger-Additions.swift
//  
//
//  Created by Tami Black on 3/2/21.
//

import Foundation
import os

// MARK: - Print Function Override
#if !DEBUG
/// Overwriting print() so it doesn't show up in production
func print(_ items: Any..., separator: String = " ", terminator: String = "\n") { }
#else
func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    items.forEach {
        Log.debug("\($0)\(separator)\(terminator)")
    }
}
#endif
// MARK:  - OSLog Private Parameters
public extension OSLog {
    private static var subsystem: String {
        guard let subsystem = Bundle.main.bundleIdentifier else {
            fatalError("Failed to fetch bundleIdentifier")
        }
        return subsystem
    }

    /// Logs the view cycles like viewDidLoad.
    static let debug = OSLog(subsystem: subsystem, category: "debug")
}


// MARK:  - Logger Typealias
fileprivate typealias Log = Logger
fileprivate typealias MNLog = Log.Category

// MARK: - Error Handling: LoggerError
private enum LoggerError: Error {
    case bundleIdentifierNotFound
}

extension LoggerError: LocalizedError {
    private enum LoggerConstants {
        static let bundleIdNotFoundRErrorMsg = "The Application's bundleIdentifier was not found. This should not happen. A re-install is necessary."
        static let bundleIdNotFoundReasonMsg = bundleIdNotFoundRErrorMsg
    }

    var errorDescription: String? {
        switch self {
        case .bundleIdentifierNotFound:
            return NSLocalizedString(LoggerConstants.bundleIdNotFoundRErrorMsg,  comment: "")
        }
    }

    var failureReason: String? {
        switch self {
        case .bundleIdentifierNotFound:
            return NSLocalizedString(LoggerConstants.bundleIdNotFoundReasonMsg, comment: "")
        }
    }
}

// MARK: - Enums
public extension Logger {

    /// MissingNoodleKit Logger Categories, curently they are:  [app, coreData, debug, mnKit, networking, ui]
    enum Category: String {
        case app
        case coreData
        case debug // The default Category
        case mnKit
        case networking
        case ui

        private static let appLogger = Logger(subsystem: subsystem, category: MNLog.app.logCategory)
        private static let coreDataLogger = Logger(subsystem: subsystem, category: MNLog.coreData.logCategory)
        private static let debugLogger = Logger(subsystem: subsystem, category: MNLog.debug.logCategory)
        private static let mnKitLogger = Logger(subsystem: subsystem, category: MNLog.mnKit.logCategory)
        private static let networkingLogger = Logger(subsystem: subsystem, category: MNLog.networking.logCategory)
        private static let uiLogger = Logger(subsystem: subsystem, category: MNLog.ui.logCategory)

        /// The MissingNoodleKit Logger.Category Looggers to use.
        var logger: Logger {
            switch self {
            case .app: return MNLog.appLogger
            case .coreData: return MNLog.coreDataLogger
            case .debug: return MNLog.debugLogger
            case .mnKit: return MNLog.mnKitLogger
            case .networking: return MNLog.networkingLogger
            case .ui: return MNLog.uiLogger
            }
        }

        private var logCategory: String {
            self.rawValue
        }
    }
}

// MARK: - Functions
public extension Logger {
    private static var component = "[\(#file):\(#function)]"
    /// Logs a `message` conforming to the `CustomStringConvertible`, for a given `Category` at the `Logger.debug` level.
    /// - Parameters:
    ///   - category: The given `Logger.Category` for this log. If none is given, the default `Logger.Category` is `Logger.Category.debug`.
    ///   - message: The `CustomStringConvertible `conforming string to be logged at the `Logger.debug` log level. This will not produce a log in a `Release Configuration` build.
    static func debug<T: CustomStringConvertible>(category: Category = .debug, _ message: T) {
        switch category {
        case .app:
            MNLog.app.logger.debug("\(component) \(message, privacy: .auto(mask: .hash))")
        case .coreData:
            MNLog.coreData.logger.debug("\(component) \(message, privacy: .auto(mask: .hash))")
        case .debug:
            MNLog.debug.logger.debug("\(component) \(message, privacy: .auto(mask: .hash))")
        case .mnKit:
            MNLog.mnKit.logger.debug("\(component) \(message, privacy: .auto(mask: .hash))")
        case .networking:
            MNLog.networking.logger.debug("\(component) \(message, privacy: .auto(mask: .hash))")
        case .ui:
            MNLog.ui.logger.debug("\(component) \(message, privacy: .auto(mask: .hash))")
        }
    }

    /// Logs a `message` conforming to the `CustomStringConvertible`, for a given `Category` at the `Logger.debug` level.
    /// - Parameters:
    ///   - category: The given `Logger.Category` for this log. If none is given, the default `Logger.Category` is `Logger.Category.debug`.
    ///   - message: The `CustomStringConvertible `conforming string to be logged at the `Logger.debug` log level. This will not produce a log in a `Release Configuration` build.
    static func debugSensative<T: CustomStringConvertible>(category: Category = .debug, _ message: T) throws {
        switch category {
        case .app:
            MNLog.app.logger.debug("\(component) \(message, privacy: .sensitive(mask: .hash))")
        case .coreData:
            MNLog.coreData.logger.debug("\(component) \(message, privacy: .sensitive(mask: .hash))")
        case .debug:
            MNLog.debug.logger.debug("\(component) \(message, privacy: .sensitive(mask: .hash))")
        case .mnKit:
            MNLog.mnKit.logger.debug("\(component) \(message, privacy: .sensitive(mask: .hash))")
        case .networking:
            MNLog.networking.logger.debug("\(component) \(message, privacy: .sensitive(mask: .hash))")
        case .ui:
            MNLog.ui.logger.debug("\(component) \(message, privacy: .sensitive(mask: .hash))")
        }
    }

    /// Logs a `message` conforming to the `CustomStringConvertible`, for a given `Category` at the `Logger.trace` log level.
    /// - Parameters:
    ///   - category: The given `Logger.Category` for this log. If none is given, the default `Logger.Category` is `Logger.Category.debug`.
    ///   - message: The `CustomStringConvertible `conforming string to be logged at the `Logger.trace` log level. This will not produce a log in a `Release Configuration` build.
    static func trace<T: CustomStringConvertible>(category: Category = .debug, _ message: T) throws {
        switch category {
        case .app:
            MNLog.app.logger.trace("\(component) \(message, privacy: .auto(mask: .hash))")
        case .coreData:
            MNLog.coreData.logger.trace("\(component) \(message, privacy: .auto(mask: .hash))")
        case .debug:
            MNLog.debug.logger.debug("\(component) \(message, privacy: .auto(mask: .hash))")
        case .mnKit:
            MNLog.mnKit.logger.trace("\(component) \(message, privacy: .auto(mask: .hash))")
        case .networking:
            MNLog.networking.logger.trace("\(component) \(message, privacy: .auto(mask: .hash))")
        case .ui:
            MNLog.ui.logger.trace("\(component) \(message, privacy: .auto(mask: .hash))")
        }
    }

    /// Logs a `message` conforming to the `CustomStringConvertible`, for a given `Category` at the `Logger.info` log level.
    /// - Parameters:
    ///   - category: The given `Logger.Category` for this log. If none is given, the default `Logger.Category` is `Logger.Category.debug`.
    ///   - message: The `CustomStringConvertible `conforming string to be logged at the `Logger.info` log level. This will  produce a log in a `Release Configuration` build.
    static func info<T: CustomStringConvertible>(category: Category = .debug, _ message: T) throws {
        switch category {
        case .app:
            MNLog.app.logger.info("\(component) \(message, privacy: .auto(mask: .hash))")
        case .coreData:
            MNLog.coreData.logger.info("\(component) \(message, privacy: .auto(mask: .hash))")
        case .debug:
            MNLog.debug.logger.debug("\(component) \(message, privacy: .auto(mask: .hash))")
        case .mnKit:
            MNLog.mnKit.logger.info("\(component) \(message, privacy: .auto(mask: .hash))")
        case .networking:
            MNLog.networking.logger.info("\(component) \(message, privacy: .auto(mask: .hash))")
        case .ui:
            MNLog.ui.logger.info("\(component) \(message, privacy: .auto(mask: .hash))")
        }
    }

    /// Logs a `message` conforming to the `CustomStringConvertible`, for a given `Category` at the `Logger.notice` log level.
    /// - Parameters:
    ///   - category: The given `Logger.Category` for this log. If none is given, the default `Logger.Category` is `Logger.Category.debug`.
    ///   - message: The `CustomStringConvertible `conforming string to be logged at the `Logger.notice` log level. This will  produce a log in a `Release Configuration` build.
    static func notice<T: CustomStringConvertible>(category: Category = .debug, _ message: T) throws {
        switch category {
        case .app:
            MNLog.app.logger.notice("\(component) \(message, privacy: .auto(mask: .hash))")
        case .coreData:
            MNLog.coreData.logger.notice("\(component) \(message, privacy: .auto(mask: .hash))")
        case .debug:
            MNLog.debug.logger.debug("\(component) \(message, privacy: .auto(mask: .hash))")
        case .mnKit:
            MNLog.mnKit.logger.notice("\(component) \(message, privacy: .auto(mask: .hash))")
        case .networking:
            MNLog.networking.logger.notice("\(component) \(message, privacy: .auto(mask: .hash))")
        case .ui:
            MNLog.ui.logger.notice("\(component) \(message, privacy: .auto(mask: .hash))")
        }
    }

    /// Logs a `message` conforming to the `CustomStringConvertible`, for a given `Category` at the `Logger.error` log level.
    /// - Parameters:
    ///   - category: The given `Logger.Category` for this log. If none is given, the default `Logger.Category` is `Logger.Category.debug`.
    ///   - message: The `CustomStringConvertible `conforming string to be logged at the `Logger.error` log level. This will  produce a log in a `Release Configuration` build.
    static func error<T: CustomStringConvertible>(category: Category = .debug, _ message: T) throws {
        switch category {
        case .app:
            MNLog.app.logger.error("\(component) \(message, privacy: .auto(mask: .hash))")
        case .coreData:
            MNLog.coreData.logger.error("\(component) \(message, privacy: .auto(mask: .hash))")
        case .debug:
            MNLog.debug.logger.debug("\(component) \(message, privacy: .auto(mask: .hash))")
        case .mnKit:
            MNLog.mnKit.logger.error("\(component) \(message, privacy: .auto(mask: .hash))")
        case .networking:
            MNLog.networking.logger.error("\(component) \(message, privacy: .auto(mask: .hash))")
        case .ui:
            MNLog.ui.logger.error("\(component) \(message, privacy: .auto(mask: .hash))")
        }
    }

    /// Logs a `message` conforming to the `CustomStringConvertible`, for a given `Category` at the `Logger.warning` log level.
    /// - Parameters:
    ///   - category: The given `Logger.Category` for this log. If none is given, the default `Logger.Category` is `Logger.Category.debug`.
    ///   - message: The `CustomStringConvertible `conforming string to be logged at the `Logger.warning` log level. This will  produce a log in a `Release Configuration` build.
    static func warning<T: CustomStringConvertible>(category: Category = .debug, _ message: T) throws {
        switch category {
        case .app:
            MNLog.app.logger.warning("\(component) \(message, privacy: .auto(mask: .hash))")
        case .coreData:
            MNLog.coreData.logger.warning("\(component) \(message, privacy: .auto(mask: .hash))")
        case .debug:
            MNLog.debug.logger.debug("\(component) \(message, privacy: .auto(mask: .hash))")
        case .mnKit:
            MNLog.mnKit.logger.warning("\(component) \(message, privacy: .auto(mask: .hash))")
        case .networking:
            MNLog.networking.logger.warning("\(component) \(message, privacy: .auto(mask: .hash))")
        case .ui:
            MNLog.ui.logger.warning("\(component) \(message, privacy: .auto(mask: .hash))")
        }
    }

    /// Logs a `message` conforming to the `CustomStringConvertible`, for a given `Category` at the `Category.critical` log level.
    /// - Parameters:
    ///   - category: The given `Logger.Category` for this log. If none is given, the default `Logger.Category` is `Logger.Category.debug`.
    ///   - message: The `CustomStringConvertible `conforming string to be logged at the `Category.critical` log level. This will  produce a log in a `Release Configuration` build.
    static func critical<T: CustomStringConvertible>(category: Category = .debug, _ message: T) throws {
        switch category {
        case .app:
            MNLog.app.logger.critical("\(component) \(message, privacy: .auto(mask: .hash))")
        case .coreData:
            MNLog.coreData.logger.critical("\(component) \(message, privacy: .auto(mask: .hash))")
        case .debug:
            MNLog.debug.logger.debug("\(component) \(message, privacy: .auto(mask: .hash))")
        case .mnKit:
            MNLog.mnKit.logger.critical("\(component) \(message, privacy: .auto(mask: .hash))")
        case .networking:
            MNLog.networking.logger.critical("\(component) \(message, privacy: .auto(mask: .hash))")
        case .ui:
            MNLog.ui.logger.warning("\(component) \(message, privacy: .auto(mask: .hash))")
        }
    }

    /// Logs a `message` conforming to the `CustomStringConvertible`, for a given `Category` at the `Logger.fault` log level.
    /// - Parameters:
    ///   - category: The given `Logger.Category` for this log. If none is given, the default `Logger.Category` is `Logger.Category.debug`.
    ///   - message: The `CustomStringConvertible `conforming string to be logged at the `Logger.fault` log level. This will  produce a log in a `Release Configuration` build.
    static func fault<T: CustomStringConvertible>(category: Category = .debug, _ message: T) throws {
        switch category {
        case .app:
            MNLog.app.logger.fault("\(component) \(message, privacy: .auto(mask: .hash))")
        case .coreData:
            MNLog.coreData.logger.fault("\(component) \(message, privacy: .auto(mask: .hash))")
        case .debug:
            MNLog.debug.logger.debug("\(component) \(message, privacy: .auto(mask: .hash))")
        case .mnKit:
            MNLog.mnKit.logger.fault("\(component) \(message, privacy: .auto(mask: .hash))")
        case .networking:
            MNLog.networking.logger.fault("\(component) \(message, privacy: .auto(mask: .hash))")
        case .ui:
            MNLog.ui.logger.fault("\(component) \(message, privacy: .auto(mask: .hash))")
        }
    }
}

// MARK: - Private Functions
private extension Logger {
    /// A non-optional version of the `'Bundle.main.bundleIdentifier' string`.
    private static var subsystem: String {
        guard let subsystem = Bundle.main.bundleIdentifier else {
            fatalError(LoggerError.bundleIdentifierNotFound.localizedDescription)
        }
        return subsystem
    }
}

// TODO: - Delete Me
struct HHH {
    func asdfas() {
        let msg = "SD"
        print("ss")
        MNLog.app.logger.log("\(msg, privacy: .private(mask: .hash))")
        Log.debug("afas")
    }
}
