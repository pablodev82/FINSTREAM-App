//
//  AnalyticsViewModel.swift
//  FinStream
//
//  Created by Admin on 16/06/2026.
//
import SwiftUI
import Combine

struct ExpenseCategory: Identifiable {
    let id = UUID()
    let name: String
    let amount: Double
    let color: Color
}

class AnalyticsViewModel: ObservableObject {
    // 0 = Gráficos, 1 = Contratos, 2 = Utilitarias
    @Published var selectedTab: Int = 0
    
    // --- DATOS PESTAÑA 0: GRÁFICOS ---
    let lineChartPoints: [CGFloat] = [20, 60, 45, 90, 75, 120, 100]
    let months = ["jan", "feb", "mar", "apr", "may", "jun", "jul"]
    
    let expenseCategories: [ExpenseCategory] = [
        ExpenseCategory(name: "Alimentos (Coto)", amount: 45000.0, color: .orange),
        ExpenseCategory(name: "Entretenimiento (Netflix)", amount: 14250.0, color: .red),
        ExpenseCategory(name: "Otros Gastos", amount: 10000.0, color: .blue)
    ]
    
    var totalExpenses: Double {
        expenseCategories.reduce(0) { $0 + $1.amount }
    }
    
    // --- DATOS PESTAÑA 1: CONTRATOS (Servicios fijos) ---
    let contratosMock = [
        (title: "Alquiler Depto", price: "$250.000 /mes", icon: "house.fill", color: Color.purple),
        (title: "Seguro Automotor", price: "$35.000 /mes", icon: "car.2.fill", color: Color.blue),
        (title: "Plan OSDE", price: "$72.000 /mes", icon: "heart.fill", color: Color.red)
    ]
    
    // --- DATOS PESTAÑA 2: UTILITARIAS (Impuestos / Servicios) ---
    let utilitariasMock = [
        (title: "Luz (Edesur)", price: "$38.500", icon: "bolt.fill", color: Color.yellow),
        (title: "Gas (Metrogas)", price: "$25.000", icon: "flame.fill", color: Color.orange),
        (title: "Internet (Fibertel)", price: "$54.000", icon: "wifi", color: Color.blue)
    ]
}
