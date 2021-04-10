//
//  NetworkMonitor.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-04-08.
//

import Foundation
import Network

class NetworkMonitor: ObservableObject {
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Monitor")
    
    @Published var isConnected = true
    
    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied ? true : false
            }
        }
        monitor.start(queue: queue)
    }
    
    func cancelMonitor() {
        monitor.cancel()
    }
}
