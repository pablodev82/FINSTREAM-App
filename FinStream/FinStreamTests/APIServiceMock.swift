//
//  APIServiceMock.swift
//  FinStreamTests
//
//  Created by Admin on 12/06/2026.
//

import Foundation
import Combine
@testable import FinStream

final class APIServiceMock: APIServiceProtocol {
    // Estas propiedades nos dejan controlar qué va a devolver el Mock desde el Test
    var resultToBeReturned: Result<[Transaction], NetworkError>?

    func getTransactions() -> AnyPublisher<[Transaction], NetworkError> {
        guard let result = resultToBeReturned else {
            return Fail(error: NetworkError.badURL).eraseToAnyPublisher()
        }
        
        switch result {
        case .success(let transactions):
            return Just(transactions)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        case .failure(let error):
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}
