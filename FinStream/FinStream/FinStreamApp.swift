//
//  FinStreamApp.swift
//  FinStream
//
//  Created by Admin on 10/06/2026.
//

import SwiftUI

@main
struct FinStreamApp: App {
    // Creamos un contenedor de NavigationController que persista en el ciclo de vida de la App
    @State private var navigationController = UINavigationController()
    @State private var coordinator: MainCoordinator?

    var body: some Scene {
        WindowGroup {
            // Usamos un componente intermedio para inicializar UIKit al arrancar
            NavigationControllerRepresentable(navController: navigationController) {
                if coordinator == nil {
                    let mainCoordinator = MainCoordinator(navigationController: navigationController)
                    self.coordinator = mainCoordinator
                    mainCoordinator.start()
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

// Representable para poder embutir el flujo de UIKit dentro de SwiftUI en Xcode 12
struct NavigationControllerRepresentable: UIViewControllerRepresentable {
    let navController: UINavigationController
    let onAppear: () -> Void

    func makeUIViewController(context: Context) -> UINavigationController {
        onAppear()
        return navController
    }

    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}
}
