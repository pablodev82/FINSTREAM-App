//
//  HomeViewModelTests.swift
//  FinStreamTests
//
//  Created by Admin on 12/06/2026.
//

import XCTest
import LocalAuthentication
@testable import FinStream// <--- Reemplazá por el nombre exacto de tu proyecto

// 1. Creamos un "Doble de Riesgo" de LAContext para controlar el resultado del Face ID
class LAContextMock: LAContext {
    var shouldSucceed: Bool = true
    var canEvaluateReturns: Bool = true
    
    override func canEvaluatePolicy(_ policy: LAPolicy, error: NSErrorPointer) -> Bool {
        return canEvaluateReturns
    }
    
    override func evaluatePolicy(_ policy: LAPolicy, localizedReason: String, reply: @escaping (Bool, Error?) -> Void) {
        // Simulamos la respuesta inmediata sin tocar el hardware
        reply(shouldSucceed, shouldSucceed ? nil : NSError(domain: "LAError", code: -3, userInfo: nil))
    }
}

// 2. La clase de pruebas unitarias
class HomeViewModelTests: XCTestCase {
    
    var sut: HomeViewModel! // Subject Under Test
    var contextMock: LAContextMock!
    var dummyCoordinator: MainCoordinator!

    override func setUp() {
        super.setUp()
        // Inicializamos los mocks necesarios
        dummyCoordinator = MainCoordinator(navigationController: UINavigationController())
        contextMock = LAContextMock()
        sut = HomeViewModel(coordinator: dummyCoordinator, apiService: APIServiceMock(), authContext: contextMock)
    }

    override func tearDown() {
        sut = nil
        contextMock = nil
        dummyCoordinator = nil
        super.tearDown()
    }

    // TEST 1: Verificar comportamiento cuando Face ID es exitoso
    func testAuthenticateUser_WhenBiometricsSucceed_ShouldAuthenticate() {
        // Arrange (Preparar)
        contextMock.canEvaluateReturns = true
        contextMock.shouldSucceed = true
        
        // Act (Ejecutar)
        sut.authenticateUser()
        
        // Assert (Verificar)
        // Agregamos una pequeña espera por el DispatchQueue.main.async
        let expectation = XCTestExpectation(description: "Espera del hilo principal")
        DispatchQueue.main.async {
            // Acá verificás tus estados modificados por el éxito del login
            // Ejemplo: XCTAssertTrue(self.sut.isUnlocked)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }

    // TEST 2: Verificar comportamiento cuando el usuario cancela el Face ID
    func testAuthenticateUser_WhenBiometricsFail_ShouldNotAuthenticate() {
        // Arrange
        contextMock.canEvaluateReturns = true
        contextMock.shouldSucceed = false
        
        // Act
        sut.authenticateUser()
        
        // Assert
        let expectation = XCTestExpectation(description: "Espera del hilo principal")
        DispatchQueue.main.async {
            // Ejemplo: XCTAssertFalse(self.sut.isUnlocked)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
}
//
//import XCTest
//import Combine
//@testable import FinStream
//
//class HomeViewModelTests: XCTestCase {
//
//    private var sut: HomeViewModel! // Subject Under Test (El objeto que estamos testeando)
//    private var apiMock: APIServiceMock!
//    private var coordinator: MainCoordinator!
//    private var cancellables: Set<AnyCancellable>!
//
//    override func setUp() {
//        super.setUp()
//        apiMock = APIServiceMock()
//        coordinator = MainCoordinator(navigationController: UINavigationController())
//        // Inyectamos el Mock en el ViewModel (Clean Architecture en su máxima expresión)
//        sut = HomeViewModel(coordinator: coordinator, apiService: apiMock)
//        cancellables = []
//    }
//
//    override func tearDown() {
//        sut = nil
//        apiMock = nil
//        coordinator = nil
//        cancellables = nil
//        super.tearDown()
//    }
//
//    func testLoadTransactions_Success_UpdatesTransactionsArray() {
//        // 1. GIVEN: Preparamos el escenario con transacciones de prueba
//        let expectedTransaction = Transaction(id: "test_id", title: "Pago Test", amount: -100, currency: "ARS", category: "Servicios", date: "2026-06-12")
//        apiMock.resultToBeReturned = .success([expectedTransaction])
//
//        let expectation = XCTestExpectation(description: "Espera que Combine actualice el array")
//
//        // Escuchamos los cambios en la propiedad reactiva @Published
//        sut.$transactions
//            .dropFirst() // Ignoramos el estado inicial vacío
//            .sink { transactions in
//                // 3. ASSERT: Verificamos que los datos impactaron correctamente
//                XCTAssertEqual(transactions.count, 1)
//                XCTAssertEqual(transactions.first?.title, "Pago Test")
//                expectation.fulfill()
//            }
//            .store(in: &cancellables)
//
//        // 2. WHEN: Ejecutamos la acción
//        sut.loadTransactions()
//
//        wait(for: [expectation], timeout: 2.0)
//    }
//}
