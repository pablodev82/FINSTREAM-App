//
//  AnalyticsView.swift
//  FinStream
//
//  Created by Admin on 16/06/2026.
//

import SwiftUI

struct AnalyticsView: View {
    @ObservedObject var viewModel: AnalyticsViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 0) {
            // BARRA SUPERIOR DE NAVEGACIÓN
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                        Text("Volver")
                    }
                    .font(.body)
                    .foregroundColor(.blue)
                }
                Spacer()
                Text("Análisis de Gastos")
                    .font(.title2)
                    .bold()
                Spacer()
                Text("Volver").opacity(0).font(.body)
            }
            .padding(25)
            .background(Color(.systemBackground))
            
            // SELECTOR DE PESTAÑAS (Dispara el cambio reactivo)
            Picker("Categoría", selection: $viewModel.selectedTab) {
                Text("Gráficos").tag(0)
                Text("Contratos").tag(1)
                Text("Utilitarias").tag(2)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            .padding(.bottom, 10)
            
            
            // CONTENIDO DINÁMICO SEGÚN LA PESTAÑA
            ScrollView {
                VStack(spacing: 20) {
                    
                    switch viewModel.selectedTab {
                    case 0:
                        // --- VISTA DE GRÁFICOS (Tu pantalla original) ---
                        VStack(spacing: 25) {
                            VStack(alignment: .leading, spacing: 12) {
                                LineChartView(points: viewModel.lineChartPoints, labels: viewModel.months)
                                    .frame(height: 160)
                            }
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(16)
                            
                            VStack(alignment: .leading, spacing: 15) {
                                Text("Distribución por Categorías")
                                    .font(.headline)
                                    .bold()
                                
                                HStack(spacing: 20) {
                                    ZStack {
                                        Circle()
                                            .stroke(Color.gray.opacity(0.1), lineWidth: 20)
                                        Circle()
                                            .trim(from: 0.0, to: 0.65)
                                            .stroke(Color.orange, style: StrokeStyle(lineWidth: 20, lineCap: .round))
                                            .rotationEffect(Angle(degrees: -90))
                                        Circle()
                                            .trim(from: 0.65, to: 0.90)
                                            .stroke(Color.red, style: StrokeStyle(lineWidth: 20, lineCap: .round))
                                            .rotationEffect(Angle(degrees: -90))
                                        
                                        VStack {
                                            Text("Total")
                                                .font(.caption2)
                                                .foregroundColor(.gray)
                                            Text("$\(Int(viewModel.totalExpenses))")
                                                .font(.system(size: 16, weight: .bold))
                                        }
                                    }
                                    .frame(width: 110, height: 160)
                                    
                                    VStack(alignment: .leading, spacing: 8) {
                                        ForEach(viewModel.expenseCategories) { category in
                                            HStack(spacing: 8) {
                                                Circle()
                                                    .fill(category.color)
                                                    .frame(width: 10, height: 10)
                                                Text(category.name)
                                                    .font(.caption)
                                                Spacer()
                                                Text("$\(Int(category.amount))")
                                                    .font(.caption).bold()
                                            }
                                        }
                                    }
                                }
                            }
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(16)
                            
                        }
                        .padding(.horizontal)
                        
                    case 1:
                        // --- VISTA DE CONTRATOS ---
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Contratos Activos")
                                .font(.headline)
                                .bold()
                            
                            ForEach(viewModel.contratosMock, id: \.title) { contrato in
                                rowItem(title: contrato.title, detail: contrato.price, icon: contrato.icon, color: contrato.color)
                            }
                        }
                        .padding(.horizontal)
                        
                    case 2:
                        // --- VISTA DE UTILITARIAS ---
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Servicios e Impuestos")
                                .font(.headline)
                                .bold()
                            
                            ForEach(viewModel.utilitariasMock, id: \.title) { util in
                                rowItem(title: util.title, detail: util.price, icon: util.icon, color: util.color)
                            }
                        }
                        .padding(.horizontal)
                        
                    default:
                        EmptyView()
                    }
                }
                .padding(.vertical)
            }
        }
        .navigationBarHidden(true)
        // Agregamos una animación sutil para que el cambio de contenido no sea brusco
        .animation(.easeInOut(duration: 0.25), value: viewModel.selectedTab)
    }
    
    // Componente reutilizable para las filas de Contratos y Utilitarias
    private func rowItem(title: String, detail: String, icon: String, color: Color) -> some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
                .frame(width: 40, height: 40)
                .background(color.opacity(0.1))
                .cornerRadius(10)
            
            Text(title)
                .font(.body)
                .bold()
            
            Spacer()
            
            Text(detail)
                .font(.subheadline)
                .bold()
                
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
    }
}

// Preview para desarrollo local
struct AnalyticsView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsView(viewModel: AnalyticsViewModel())
    }
}
