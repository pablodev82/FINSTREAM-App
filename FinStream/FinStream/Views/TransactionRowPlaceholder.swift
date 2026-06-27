//
//  TransactionRowPlaceholder.swift
//  FinStream
//
//  Created by Admin on 20/06/2026.
//

import SwiftUI

struct TransactionRowPlaceholder: View {
    var body: some View {
        HStack(spacing: 12) {
            // Círculo del ícono
            Circle()
                .fill(Color(.systemGray5))
                .frame(width: 40, height: 40)
            
            // Textos de título y categoría
            VStack(alignment: .leading, spacing: 6) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color(.systemGray5))
                    .frame(width: 120, height: 14)
                
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color(.systemGray5))
                    .frame(width: 70, height: 10)
            }
            
            Spacer()
            
            // Monto a la derecha
            RoundedRectangle(cornerRadius: 4)
                .fill(Color(.systemGray5))
                .frame(width: 60, height: 14)
        }
        .padding(.vertical, 10)
        // Aplicamos el esqueleto animado a toda la fila comodín
        .skeleton(isActive: true)
    }
}

struct TransactionRowPlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        TransactionRowPlaceholder()
    }
}
