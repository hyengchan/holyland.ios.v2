//
//  NetworkStatus.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/14.
//

import Foundation
import Network

class NetworkStatus {
   
    // MARK: - Properties
    
    static let shared = NetworkStatus()
    
    var monitor: NWPathMonitor?
    
    var isMonitoring = false
    
    var didStartMonitoringHandler: (() -> Void)?
    var didStopMonitoringHandler: (() -> Void)?
    var netStatusChangeHandler: (() -> Void)?
    var isConnected: Bool {
        guard let monitor = monitor else { return false }
        return monitor.currentPath.status == .satisfied
    }
    
    var interfaceType: NWInterface.InterfaceType? {
        guard let monitor = monitor else { return nil }
        return
            monitor.currentPath.availableInterfaces.first(where: {
                monitor.currentPath.usesInterfaceType($0.type)
            })?.type
    }
    
    var isExpensive: Bool {
        return monitor?.currentPath.isExpensive ?? false
    }
    
    // MARK: - Init & Deinit
    
    private init() { }
    deinit { stopMonitoring() }
    
    // MARK: - Method Implementation
    
    func startMonitoring() {
        let queue = DispatchQueue(label: "NetStatus_Monitor")
        
        guard !isMonitoring else { return }
        
        monitor = NWPathMonitor()
        monitor?.start(queue: queue)
        monitor?.pathUpdateHandler = { _ in
            self.netStatusChangeHandler?()
        }
        
        isMonitoring = true
        didStartMonitoringHandler?()
    }
    
    func stopMonitoring() {
        guard isMonitoring, let monitor = monitor else { return }
        
        monitor.cancel()
        self.monitor = nil
        isMonitoring = false
        didStopMonitoringHandler?()
    }
}
