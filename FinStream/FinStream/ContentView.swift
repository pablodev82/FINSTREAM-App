//
//  ContentView.swift
//  FinStream
//
//  Created by Admin on 10/06/2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



//# FinStream App - iOS Architecture Challenge
//
//Aplicación Fintech modular construida bajo la arquitectura **MVVM-C (Model-View-ViewModel-Coordinator)**, diseñada con un enfoque Spec-Driven y optimizada para entornos de alta compatibilidad en **Xcode 12 / iOS 14**.
//
//## 🛠️ Arquitectura y Tecnologías Aplicadas
//
//* **UIKit + SwiftUI Integration:** Uso de un flujo de navegación centralizado comandado por un `MainCoordinator` (UIKit) utilizando `UIHostingController` para renderizar las pantallas nativas en SwiftUI.
//* **Reactive Network Layer:** Capa de red desacoplada mediante protocolos (`APIServiceProtocol`) y procesamiento asincrónico utilizando el framework **Combine** con tipado estricto de errores (`NetworkError`).
//* **Security & Persistence:** * Autenticación biométrica local mediante **LocalAuthentication** (FaceID / TouchID).
//    * Almacenamiento encriptado de tokens de sesión utilizando la API de C de Apple a través de un `KeychainManager`.
//* **Multimedia:** Integración del framework **AVKit** para la reproducción fluida de contenido educativo por streaming (HLS / `.m3u8`).
//* **Quality Assurance (Unit Tests):** Cobertura de lógica de negocio en ViewModels usando **XCTest** combinados con técnicas de *Dependency Injection* y *Mocking* de servicios de red.
//
//## 🚀 Cómo ejecutar las pruebas
//1. Abrir el proyecto en Xcode.
//2. Seleccionar el esquema principal (`FinStream`).
//3. Presionar el comando `Cmd + U` para ejecutar la suite completa de pruebas unitarias.
