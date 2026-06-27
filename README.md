# FinStream-iOS: Fintech Core Architecture with SwiftUI, Clean Architecture & Spec-Driven Development

FinStream es una aplicación financiera de alto rendimiento desarrollada de forma nativa para iOS. El core del proyecto radica en el diseño de una arquitectura robusta, modular y desacoplada que mitiga la complejidad técnica de los flujos fintech. La app fue concebida bajo estándares estrictos de Spec-Driven Development, garantizando total retrocompatibilidad desde iOS 14+ y optimizando el uso de recursos del dispositivo.

## 🚀 Arquitectura y Patrones de Diseño
* **Arquitectura:** MVVM (Model-View-ViewModel) + **Clean Architecture**. Inyección de dependencias estricta a través del constructor para desacoplamiento total y modularización.
* **Patrón de Navegación:** **Coordinator Pattern** encapsulado mediante `UINavigationController` (UIKit) integrado orgánicamente con SwiftUI, eliminando el acoplamiento duro entre vistas y centralizando el flujo de la app.
* **Estrategia de Testing:** **Unit Testing determinista (XCTest)** enfocado en el comportamiento de los ViewModels mediante el uso de *Mocks* customizados (`LAContextMock` y `APIServiceMock`), aislando por completo el hardware y las peticiones de red.

## 🛠️ Stack Tecnológico & Frameworks Nativos (Zero Third-Party Dependencies)
* **UI & UX Premium:** SwiftUI nativo. Implementación de un modificador de vista customizado (`ShimmerModifier`) para proveer *Skeleton Views* animados que reducen la carga cognitiva del usuario durante llamadas asincrónicas.
* **Networking Reactivo:** **URLSession** integrado con **Combine Framework** (`dataTaskPublisher`). Procesamiento en hilos secundarios, decodificación automática de JSON y despacho seguro en el hilo principal (`DispatchQueue.main`) sin bloquear la UI.
* **Incrustación Multimedia:** Core de **WebKit** (`WKWebView`) embebido mediante `UIViewRepresentable`, permitiendo la reproducción fluida de contenidos dinámicos (Educación Financiera) con control estricto del ciclo de vida y consumo de memoria.
* **Seguridad & Biometría:** Framework `LocalAuthentication` para autenticación avanzada (**Face ID / Touch ID**) integrado con almacenamiento seguro de tokens de sesión en el **Keychain**.

## | Pantalla Fantasma (Shimmer) | Autenticación Biométrica | Datos Consolidados |
### 📸 App Showcases & UI Flow
| :---: | :---: | :---: |

<img width="360" height="680" alt="Captura de Pantalla 2026-06-27 a la(s) 14 46 11" src="https://github.com/user-attachments/assets/19d583d5-b3f6-4310-9290-be4f8d38f25c" />
<img width="360" height="680" alt="Captura de Pantalla 2026-06-27 a la(s) 14 10 23" src="https://github.com/user-attachments/assets/6f12bbe0-60a6-4b43-a0ba-8d7e5b7f5041" />
<img width="360" height="680" alt="Captura de Pantalla 2026-06-27 a la(s) 14 07 32" src="https://github.com/user-attachments/assets/31709bcd-57cb-49c0-95ae-28d224f6f20d" />
<img width="360" height="680" alt="Captura de Pantalla 2026-06-27 a la(s) 14 07 16" src="https://github.com/user-attachments/assets/1ad17731-ffe1-4686-b6c7-5fda7c8d2b28" />
<img width="360" height="680" alt="Captura de Pantalla 2026-06-27 a la(s) 14 08 59" src="https://github.com/user-attachments/assets/fabb6dfb-529c-46b6-bb9c-d615ab211f2f" />
<img width="360" height="680" alt="Captura de Pantalla 2026-06-27 a la(s) 14 09 14" src="https://github.com/user-attachments/assets/2647f18c-4d22-4ae3-9b3b-9cd45a65b666" />
<img width="360" height="680" alt="Captura de Pantalla 2026-06-27 a la(s) 14 09 59" src="https://github.com/user-attachments/assets/0c56b4ee-ec50-474e-b3ed-c731e46f85ec" />
<img width="360" height="680" alt="Captura de Pantalla 2026-06-27 a la(s) 14 09 33" src="https://github.com/user-attachments/assets/47419c62-25bd-4514-af9a-591d594a8d9d" />





