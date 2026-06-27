//
//  HomeViewModel.swift
//  FinStream
//
//  Created by Admin on 10/06/2026.
//

import Foundation
import Combine
import LocalAuthentication

final class HomeViewModel: ObservableObject {
    
    // Propiedades reactivas que observará la vista de SwiftUI
    @Published var transactions: [Transaction] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var securityStatusMessage: String = ""
    @Published var showSecurityAlert: Bool = false
    
    private weak var coordinator: MainCoordinator?
    private let apiService: APIServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    private let authContext: LAContext
    
    // Inyección de dependencias a través del constructor (Criterio Clean Architecture)
    // Inyección de dependencias a través del constructor (Criterio Clean Architecture)
        init(
            coordinator: MainCoordinator,
            apiService: APIServiceProtocol, // 🛠️ AGREGADO: Recibimos el servicio necesario
            authContext: LAContext = LAContext()
        ) {
            self.coordinator = coordinator
            self.apiService = apiService   // 🛠️ FIX CLAVE: Inicializamos la propiedad obligatoria
            self.authContext = authContext // Guardamos el contexto
        }
    
    func loadTransactions() {
        isLoading = true
        errorMessage = nil
        
        apiService.getTransactions()
            .receive(on: DispatchQueue.main) // Aseguramos que la UI se actualice en el hilo principal
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] McCachedTransactions in
                self?.transactions = McCachedTransactions
            })
            .store(in: &cancellables) // Evitamos fugas reteniendo la suscripción de Combine
    }
    
    func didSelectVideo(title: String, url: String) {
        coordinator?.navigateToVideoPlayer(videoTitle: title, videoID: url)
    }
    
    func saveCredentialsSecurely() {
        // 1. Primero disparamos la autenticación biométrica de FaceID
        BiometricAuthManager.shared.authenticateUser { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success:
                // 2. Si la biometría es exitosa, simulamos el guardado del token de sesión en el Keychain
                let tokenDummyData = "session_token_finstream_xyz123".data(using: .utf8)!
                
                let didSave = KeychainManager.shared.save(
                    tokenDummyData,
                    service: "com.finstream.app",
                    account: "usuario_test"
                )
                
                if didSave {
                    print("[SEC] FinStream :: Credentials saved securely to Keychain for account: usuario_test")
                    self.securityStatusMessage = "¡Credenciales guardadas con éxito en el Keychain seguro!"
                } else {
                    self.securityStatusMessage = "Error al intentar escribir en la bóveda del Keychain."
                }
                
            case .failure(let error):
                // Manejo del error si el usuario cancela o el FaceID falla
                self.securityStatusMessage = "Fallo de autenticación: \(error.localizedDescription)"
            }
            
            // Activamos la alerta visual para avisarle al usuario qué pasó
            self.showSecurityAlert = true
        }
    }
    
    func didTapProfile() {
        coordinator?.navigateToSettings()
    }
    
    func didTapAnalytics() {
        // Como el coordinator es weak, viaja seguro con un unwrap
        coordinator?.navigateToAnalytics()
    }
    
    func authenticateUser() {
            // 🛠️ Cambiá 'let context = LAContext()' por la variable de la clase:
            let context = self.authContext
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Desbloqueá las funciones de FinStream"
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    DispatchQueue.main.async {
                        if success {
                            print("📱 Face ID / Touch ID verificado con éxito.")
                            // (Opcional) Si tenés una variable tipo @Published var isUnlocked = false, ponela acá en true
                        } else {
                            print("❌ El usuario canceló o falló la autenticación.")
                        }
                    }
                }
            }
    }
//
//    // Dentro de tu HomeViewModel.swift
//    func authenticateUser() { // <--- O el nombre que prefieras
//        // Acá va la lógica con LAContext que maneja el FaceID
//        print("Iniciando autenticación biométrica...")
//    }
}
