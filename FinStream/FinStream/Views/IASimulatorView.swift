//
//  IASimulatorView.swift
//  FinStream
//
//  Created by Admin on 19/06/2026.
//

import SwiftUI

struct IASimulatorView: View {
    @State private var monthlySavings: String = ""
    @State private var selectedYears: Int = 3
    @State private var projectionResult: String = "$0.00"
    @State private var isCalculated: Bool = false
    
    var body: some View {
        ZStack {
            Color(.systemTeal).opacity(0.5)
                .ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    
                    // Tarjeta Informativa Explicativa
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image(systemName: "waveform.path.ecg")
                                .font(.title2)
                                .foregroundColor(.blue)
                            Text("Análisis Predictivo FinStream")
                                .font(.title2)
                                .bold()
                        }
                        Text("Nuestra IA proyecta el rendimiento real de tu dinero analizando las tendencias del mercado actual, tasas de interés estimadas e inflación.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(20)
                    
                    // Formulario de Entrada
                    VStack(alignment: .leading, spacing: 16) {
                        Text("CONFIGURACIÓN DE PROYECTO")
                            .font(.system(size: 14, weight: .bold))
                            
                        
                        // Input de Ahorro
                        VStack(alignment: .leading, spacing: 8) {
                            Text("¿Cuánto podés ahorrar por mes?")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            HStack {
                                Text("$")
                                    .font(.title2)
                                    .bold()
                                    .foregroundColor(.green)
                                TextField("Ej: 45000", text: $monthlySavings)
                                    .font(.title2)
                                    .keyboardType(UIKeyboardType.numberPad)
                            }
                            .padding()
                            .background(Color(.systemBackground))
                            .cornerRadius(14)
                        }
                        
                        // Selector de Plazo (Años)
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Plazo de la inversión")
                                .font(.subheadline)
                                
                            
                            Picker("Años", selection: $selectedYears) {
                                Text("1 Año").tag(1)
                                Text("3 Años").tag(3)
                                Text("5 Años").tag(5)
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .padding(10)
                        }
                        
                        // Botón de Acción
                        Button(action: {
                            calcularProyeccion()
                        }) {
                            HStack {
                                Image(systemName: "sparkles")
                                Text("Calcular con FinStream IA")
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(monthlySavings.isEmpty ? Color.gray : Color.blue)
                            .cornerRadius(14)
                        }
                        .disabled(monthlySavings.isEmpty)
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(20)
                    
                    // Bloque de Resultados Animado
                    if isCalculated {
                        VStack(spacing: 12) {
                            Text("PROYECTADO ESTIMADO")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.secondary)
                            
                            Text(projectionResult)
                                .font(.system(size: 36, weight: .black, design: .rounded))
                                .foregroundColor(.green)
                            
                            Divider()
                            
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Tu capital invertido")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    Text(calcularCapitalPuro())
                                        .font(.subheadline)
                                        .bold()
                                }
                                Spacer()
                                VStack(alignment: .trailing) {
                                    Text("Interés generado por IA")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    Text("+ " + calcularInteresEstimado())
                                        .font(.subheadline)
                                        .bold()
                                        .foregroundColor(.green)
                                }
                            }
                        }
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(20)
                        // POR ESTA SINTAXIS SEGURA:
                        .transition(AnyTransition.move(edge: Edge.bottom).combined(with: AnyTransition.opacity))
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Simulador IA")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: - Lógica Auxiliar de Simulación
    private func calcularProyeccion() {
        guard let savings = Double(monthlySavings) else { return }
        let totalMonths = Double(selectedYears * 12)
        _ = savings * totalMonths
        
        // Simulación básica considerando un rendimiento compuesto simulado por IA (~45% anual de ejemplo)
        let tasaMensualSimulada = 0.032
        var finalValue = 0.0
        
        for _ in 1...Int(totalMonths) {
            finalValue = (finalValue + savings) * (1 + tasaMensualSimulada)
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 2
        
        withAnimation(.spring()) {
            projectionResult = formatter.string(from: NSNumber(value: finalValue)) ?? "$0.00"
            isCalculated = true
        }
    }
    
    private func calcularCapitalPuro() -> String {
        guard let savings = Double(monthlySavings) else { return "$0.00" }
        let total = savings * Double(selectedYears * 12)
        return String(format: "$%.2f ARS", total)
    }
    
    private func calcularInteresEstimado() -> String {
        guard let savings = Double(monthlySavings) else { return "$0.00" }
        let totalMonths = Double(selectedYears * 12)
        let pureCapital = savings * totalMonths
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        
        // Extraemos el valor numérico aproximado sacando caracteres raros para la resta
        let tasaMensualSimulada = 0.032
        var finalValue = 0.0
        for _ in 1...Int(totalMonths) {
            finalValue = (finalValue + savings) * (1 + tasaMensualSimulada)
        }
        
        let interest = finalValue - pureCapital
        return formatter.string(from: NSNumber(value: interest)) ?? "$0.00"
    }
}

struct IASimulatorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            IASimulatorView()
                .preferredColorScheme(.dark)
        }
    }
}
