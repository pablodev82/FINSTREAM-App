//
//  SettingsViewModel.swift
//  FinStream
//
//  Created by Admin on 16/06/2026.
//

import SwiftUI
import Combine

class SettingsViewModel: ObservableObject {
    // Toggles conectados a la interfaz
    @Published var isBiometricsEnabled: Bool {
        didSet {
            // Guardamos la preferencia del usuario localmente
            UserDefaults.standard.set(isBiometricsEnabled, forKey: "useBiometrics")
        }
    }
    
    @Published var isKeychainSyncEnabled: Bool {
        didSet {
            UserDefaults.standard.set(isKeychainSyncEnabled, forKey: "syncKeychain")
        }
    }
    
    private weak var coordinator: MainCoordinator?
    
    init(coordinator: MainCoordinator?) {
        self.coordinator = coordinator
        // Leemos el estado guardado (si no existe, por defecto es true)
        self.isBiometricsEnabled = UserDefaults.standard.object(forKey: "useBiometrics") as? Bool ?? true
        self.isKeychainSyncEnabled = UserDefaults.standard.object(forKey: "syncKeychain") as? Bool ?? true
    }
}
