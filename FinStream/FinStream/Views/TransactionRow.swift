//
//  TransactionRow.swift
//  FinStream
//
//  Created by Admin on 10/06/2026.
//

import SwiftUI

struct TransactionRow: View {
    let transaction: Transaction
    
    var body: some View {
        HStack(spacing: 15) {
            // Icono dinámico según la categoría o el signo del monto
            Image(systemName: transaction.amount >= 0 ? "arrow.down.circle.fill" : "arrow.up.circle.fill")
                .resizable()
                .frame(width: 35, height: 35)
                .foregroundColor(transaction.amount >= 0 ? .green : .red)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.title)
                    .font(.body)
                    .fontWeight(.semibold)
                Text(transaction.category)
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Text(transaction.formattedAmount)
                .font(.body)
                .fontWeight(.bold)
                .foregroundColor(transaction.amount >= 0 ? .green : .primary)
        }
        .padding(.vertical, 8)
    }
}

func triggerHapticFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle = .medium) {
    let generator = UIImpactFeedbackGenerator(style: style)
    generator.prepare()
    generator.impactOccurred()
}

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.easeInOut(duration: 0.15), value: configuration.isPressed)
    }
}

struct TransactionRow_Previews: PreviewProvider {
    static var previews: some View {
        let mockTransaction =  Transaction (id: "preview_1",
                                           title: "Suscripción Netflix",
                                           amount: -14.99,
                                           currency: "USD",
                                           category: "Entretenimiento",
                                           date:  "2025-06-10"
        )
        
        return TransactionRow(transaction: mockTransaction)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
