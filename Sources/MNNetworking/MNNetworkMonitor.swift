//
//  MNNetworkMonitor.swift.swift
//  
//
//  Created by Tami Black on 2/7/21.
//

import Foundation
import Network

public typealias ConnectionType = NWInterface.InterfaceType
public class MNNetworkMonitor: ObservableObject {
    private let monitor: NWPathMonitor
    private let queue = DispatchQueue(label: "\(MNNetworkMonitor.self)", target: .global(qos: .background))
    private var connectionTypes = ConnectionType.connectionTypes

    /// Do we have access to the network?
    public var isActive = false
    /// Is the connection a cellular or WiFi connection, via a cellular hotspot?
    public var isExpensive = false
    /// Is the connection restricted by low data mode?
    public var isConstrained = false
    /// The exact connection type we have, WiFi, cellular, etc.
    public var connectionType = ConnectionType.other


    public init(for connectionType: ConnectionType? = nil) {
        if let connectionType = connectionType {
            monitor = NWPathMonitor(requiredInterfaceType: connectionType)
        } else {
            monitor = NWPathMonitor()
        }

        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { fatalError() }
            self.isActive = path.status == .satisfied
            self.isExpensive = path.isExpensive
            self.isConstrained = path.isConstrained
            self.connectionType = self.connectionTypes.first(where: path.usesInterfaceType) ?? .other

            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }

        monitor.start(queue: queue)
    }
    public func stop() {
        self.monitor.cancel()
    }
}

extension ConnectionType {
    fileprivate static var connectionTypes: [NWInterface.InterfaceType] {
        var allConnectionTypes: [NWInterface.InterfaceType] = []
        switch (NWInterface.InterfaceType.cellular) {
        case .cellular:
            allConnectionTypes.append(.cellular)
            fallthrough
        case .wifi:
            allConnectionTypes.append(.wifi)
            fallthrough
        case .wiredEthernet:
            allConnectionTypes.append(.wiredEthernet)
            fallthrough
        case .loopback:
            allConnectionTypes.append(.loopback)
            fallthrough
        case .other:
            allConnectionTypes.append(.other)
        @unknown default:
            fatalError("New NWInterface.InterfaceType introduced and not handled.")
        }
        return allConnectionTypes
    }
}
