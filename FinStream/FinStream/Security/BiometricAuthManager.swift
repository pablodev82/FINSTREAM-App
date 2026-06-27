//
//  BiometricAuthManager.swift
//  FinStream
//
//  Created by Admin on 12/06/2026.
//

import Foundation
import LocalAuthentication

final class BiometricAuthManager {
    
    static let shared = BiometricAuthManager()
    private init() {}
    
    func authenticateUser(completion: @escaping (Result<Bool, Error>) -> Void) {
        let context = LAContext()
        var error: NSError?
        
        // 1. Verificamos si el dispositivo cuenta con hardware biométrico disponible y configurado
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identificate para acceder de forma segura a tus fondos de FinStream."
            
            // 2. Lanzamos el pop-up del sistema operativo
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        completion(.success(true))
                    } else if let error = authenticationError {
                        completion(.failure(error))
                    }
                }
            }
        } else {
            // Si el simulador no tiene activado el FaceID entra por acá
            DispatchQueue.main.async {
                let noHardwareError = NSError(domain: "BiometricAuth", code: 404, userInfo: [NSLocalizedDescriptionKey: "Biometría no disponible o denegada."])
                completion(.failure(noHardwareError))
            }
        }
    }
}
