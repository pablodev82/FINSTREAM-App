//
//  MainCoordinator.swift
//  FinStream
//
//  Created by Admin on 10/06/2026.
//

import UIKit
import SwiftUI

final class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        // Inicializamos el ViewModel pasando 'self' (el coordinador) de manera segura
        let viewModel = HomeViewModel(coordinator: self, apiService: APIService())
        
        
        
        // En Xcode 12 inyectamos la vista de SwiftUI dentro del contenedor de UIKit
        let homeView = HomeView(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: homeView)
        
        navigationController.setNavigationBarHidden(false, animated: false)
        navigationController.setViewControllers([hostingController], animated: false)
    }
    
    func navigateToVideoPlayer(videoTitle: String, videoID: String) {
        // Instanciamos el reproductor de YouTube pasándole el ID
        let playerView = YouTubePlayerView(videoID: videoID)
        
        // Lo empaquetamos en el Hosting Controller nativo
        let hostingController = UIHostingController(rootView: playerView)
        hostingController.title = videoTitle
        
        // Lo presentamos de forma modal (de abajo hacia arriba) como en tu boceto
        navigationController.present(hostingController, animated: true, completion: nil)
    }
    
    func navigateToAnalytics() {
        // Inicializamos el ViewModel y la Vista nueva de SwiftUI
        let analyticsVM = AnalyticsViewModel()
        let analyticsView = AnalyticsView(viewModel: analyticsVM)
        
        // Lo empaquetamos en el hosting controller de UIKit
        let hostingController = UIHostingController(rootView: analyticsView)
        
        // Hacemos un push clásico en el navigation controller para que entre de costado
        navigationController.pushViewController(hostingController, animated: true)
    }
    
    func navigateToSettings() {
        let settingsVM = SettingsViewModel(coordinator: self)
        let settingsView = SettingsView(viewModel: settingsVM)
        let hostingController = UIHostingController(rootView: settingsView)
        
        navigationController.pushViewController(hostingController, animated: true)
    }
}
