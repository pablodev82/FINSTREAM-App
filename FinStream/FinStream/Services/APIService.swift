//
//  APIService.swift
//  FinStream
//
//  Created by Admin on 10/06/2026.
//

import Foundation
import Combine

protocol APIServiceProtocol {
    func getTransactions() -> AnyPublisher<[Transaction], NetworkError>
}

final class APIService: APIServiceProtocol {
    
    func getTransactions() -> AnyPublisher<[Transaction], NetworkError> {
        // En un caso real usarías: URLSession.shared.dataTaskPublisher(for: url)
        // Vamos a simular un Mock con retraso de red para ver el estado de carga
        
        let mockJSON = """
        [
            {"id": "1", "title": "Suscripción Netflix", "amount": -14.99, "currency": "USD", "category": "Entretenimiento", "date": "2026-06-10"},
            {"id": "2", "title": "Supermercado Coto", "amount": -45000.0, "currency": "ARS", "category": "Alimentos", "date": "2026-06-10"},
            {"id": "3", "title": "Transferencia Recibida", "amount": 120000.0, "currency": "ARS", "category": "Finanzas", "date": "2026-06-09"}
        ]
        """.data(using: .utf8)!
        
        return Just(mockJSON)
            .delay(for: .seconds(1.5), scheduler: RunLoop.main) // Simula la latencia de internet
            .tryMap { data -> [Transaction] in
                let decoder = JSONDecoder()
                return try decoder.decode([Transaction].self, from: data)
            }
            .mapError { error in
                if error is DecodingError {
                    return NetworkError.decodingError
                }
                return NetworkError.unknown(error)
            }
            .eraseToAnyPublisher()
    }
}
