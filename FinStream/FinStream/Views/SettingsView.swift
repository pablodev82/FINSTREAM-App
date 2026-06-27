//
//  SettingsView.swift
//  FinStream
//
//  Created by Admin on 16/06/2026.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: SettingsViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 0) {
            // BARRA SUPERIOR PERSONALIZADA
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                        Text("Atrás")
                    }
                    .font(.body)
                    .foregroundColor(.blue)
                }
                Spacer()
                Text("Mi Cuenta / Ajustes")
                    .font(.title2)
                    .bold()
                Spacer()
                Text("Atrás").opacity(0)
            }
            .padding()
            .background(Color(.systemBackground))
            
            Form {
                // SECCIÓN 1: SEGURIDAD Y PRIVACIDAD
                Section(header: Text("SEGURIDAD Y PRIVACIDAD")) {
                    
                    // Fila Keychain
                    HStack(spacing: 12) {
                        settingIcon(name: "key.fill", color: .gray)
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Keychain")
                                .font(.body)
                            Text("Automatizaciones y credenciales seguras de claves.")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 19)
                    
                    // Fila Biometrics (Toggle)
                    Toggle(isOn: $viewModel.isBiometricsEnabled) {
                        HStack(spacing: 12) {
                            settingIcon(name: "faceid", color: .green)
                            Text("Biometrics")
                                .font(.body)
                            
                        }
                    }
                    .toggleStyle(SwitchToggleStyle(tint: .green))
                    .padding(.vertical, 10)
                    
                    // Fila Segunda Biométrica (Toggle)
                    Toggle(isOn: $viewModel.isKeychainSyncEnabled) {
                        HStack(spacing: 12) {
                            settingIcon(name: "hand.raised.fill", color: .green)
                            Text("Segunda Biométrica")
                                .font(.body)
                        }
                    }
                    .toggleStyle(SwitchToggleStyle(tint: .green))
                    .padding(.vertical, 10)
                }
                
                
                // SECCIÓN 2: SOPORTE AI 24/7 (Como figura en tu boceto)
                Section(header: Text("SOPORTE AI 24/7")) {
                    HStack(spacing: 12) {
                        settingIcon(name: "headphones", color: .black)
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Soporte AI 24/7")
                                .font(.body)
                                .bold()
                            Text("Integración con soporte de IA continuo por chat.")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 14)
                }
            }
        }
        .navigationBarHidden(true)
    }
    
    // Helper para generar los íconos circulares idénticos al diseño
    private func settingIcon(name: String, color: Color) -> some View {
        Image(systemName: name)
            .font(.footnote)
            .foregroundColor(color)
            .frame(width: 38, height: 38)
            .background(color.opacity(0.1))
            .clipShape(Circle())
    }
}

// Preview
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(viewModel: SettingsViewModel(coordinator: nil))
    }
}
