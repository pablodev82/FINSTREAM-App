//
//  Coordinator.swift
//  FinStream
//
//  Created by Admin on 10/06/2026.
//

import UIKit

/// Protocolo base para todos los coordinadores de la app.
/// Usamos ': AnyObject' para permitir referencias débiles (weak) y evitar fugas de memoria.
protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
