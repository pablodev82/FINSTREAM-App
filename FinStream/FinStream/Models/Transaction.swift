//
//  Transaction.swift
//  FinStream
//
//  Created by Admin on 10/06/2026.
//

import Foundation

struct Transaction: Identifiable, Decodable {
    let id: String
    let title: String
    let amount: Double
    let currency: String
    let category: String
    let date: String
    
    // Propiedad calculada para formatear el texto en la interfaz gráfica
    var formattedAmount: String {
        let sign = amount >= 0 ? "+" : ""
        return "\(sign)$\(abs(amount)) \(currency)"
    }
}
