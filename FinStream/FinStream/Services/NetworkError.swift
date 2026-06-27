//
//  NetworkError.swift
//  FinStream
//
//  Created by Admin on 10/06/2026.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case serverError(statusCode: Int)
    case decodingError
    case unknown(Error)
    
    var localizedDescription: String {
        switch self {
        case .badURL: return "La URL configurada es inválida."
        case .serverError(let code): return "Error del servidor. Código de estado: \(code)."
        case .decodingError: return "Hubo un problema al procesar los datos del servidor."
        case .unknown(let error): return error.localizedDescription
        }
    }
}
