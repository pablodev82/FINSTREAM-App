//
//  ExpenseRulesView.swift
//  FinStream
//
//  Created by Admin on 19/06/2026.
//

import SwiftUI

struct ExpenseRule: Identifiable {
    let id = UUID()
    let category: String
    let currentExpense: Double
    let limitExpense: Double
    let icon: String
    let color: Color
}

struct ExpenseRulesView: View {
    @State private var rules: [ExpenseRule] = [
        ExpenseRule(category: "Gastos Fijos", currentExpense: 85000, limitExpense: 120000, icon: "house.fill", color: .blue),
        ExpenseRule(category: "Delivery y Salidas", currentExpense: 42000, limitExpense: 50000, icon: "cart.fill", color: .orange),
        ExpenseRule(category: "Suscripciones", currentExpense: 12500, limitExpense: 15000, icon: "creditcard.fill", color: .purple)
    ]
    
    @State private var newCategory: String = ""
    @State private var newLimit: String = ""
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    
                    // Explicación de la herramienta
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Reglas de Gasto Inteligentes")
                            .font(.title2)
                            .bold()
                        
                        Text("Configurá topes mensuales por categoría. FinStream te notificará de forma predictiva si tu ritmo de gasto amenaza con superar el límite.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(20)
                    
                    // Lista de Reglas Existentes
                    VStack(alignment: .leading, spacing: 16) {
                        Text("MIS LÍMITES ACTUALES")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.secondary)
                        
                        ForEach(rules) { rule in
                            VStack(spacing: 8) {
                                HStack {
                                    Image(systemName: rule.icon)
                                        .foregroundColor(rule.color)
                                    Text(rule.category)
                                        .font(.system(size: 15, weight: .bold))
                                    Spacer()
                                    Text(String(format: "$%.0f / $%.0f", rule.currentExpense, rule.limitExpense))
                                        .font(.system(size: 13, weight: .semibold))
                                        .foregroundColor(.secondary)
                                }
                                
                                // Barra de Progreso Nátiva compatible
                                GeometryReader { geo in
                                    ZStack(alignment: .leading) {
                                        RoundedRectangle(cornerRadius: 4)
                                            .fill(Color(.systemGray5))
                                            .frame(height: 8)
                                        
                                        RoundedRectangle(cornerRadius: 4)
                                            .fill(rule.currentExpense > rule.limitExpense ? Color.red : rule.color)
                                            .frame(width: min(CGFloat(rule.currentExpense / rule.limitExpense) * geo.size.width, geo.size.width), height: 8)
                                    }
                                }
                                .frame(height: 8)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(20)
                    
                    // Formulario simplificado para añadir nuevas reglas sin romper tipos
                    VStack(alignment: .leading, spacing: 12) {
                        Text("NUEVA REGLA")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.secondary)
                        
                        TextField("Categoría (Ej: Gimnasio)", text: $newCategory)
                            .padding()
                            .background(Color(.systemBackground))
                            .cornerRadius(12)
                        
                        HStack {
                            Text("$").foregroundColor(.secondary)
                            // FIX: Quitamos .bold() del TextField para evitar errores
                            TextField("Límite mensual", text: $newLimit)
                                .keyboardType(UIKeyboardType.numberPad) // FIX: Referencia explícita completa
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        
                        Button(action: {
                            if let limitValue = Double(newLimit), !newCategory.isEmpty {
                                let newRule = ExpenseRule(category: newCategory, currentExpense: 0, limitExpense: limitValue, icon: "star.fill", color: .green)
                                rules.append(newRule)
                                newCategory = ""
                                newLimit = ""
                            }
                        }) {
                            Text("Crear Límite")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(newCategory.isEmpty || newLimit.isEmpty ? Color.gray : Color.green)
                                .cornerRadius(12)
                        }
                        .disabled(newCategory.isEmpty || newLimit.isEmpty)
                        .padding(.top, 20)
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(20)
                }
                .padding()
            }
        }
        .navigationTitle("Reglas de Gasto")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ExpenseRulesView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseRulesView()
    }
}
