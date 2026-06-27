//
//  ExportDataView.swift
//  FinStream
//
//  Created by Admin on 19/06/2026.
//

import SwiftUI

struct ExportDataView: View {
    @State private var selectedFormat = "PDF"
    @State private var isExporting = false
    @State private var exportMessage = ""
    
    let formats = ["PDF", "CSV (Excel)", "JSON"]
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    
                    // Tarjeta Explicativa
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image(systemName: "arrow.down.doc")
                                .font(.title2)
                                .foregroundColor(.orange)
                                
                            Text("Reportería y Auditoría")
                                .font(.title2)
                                .bold()
                        }
                        Text("Descargá todo tu historial de transacciones, balances de remitos y conciliaciones bancarias en formatos estructurados estándar.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(20)
                    
                    // Configuración del Reporte
                    VStack(alignment: .leading, spacing: 16) {
                        Text("FORMATO DE EXPORTACIÓN")
                            .font(.system(size: 18, weight: .bold))
                            
                        
                        // Selector de formato
                        Picker("Formato", selection: $selectedFormat) {
                            ForEach(formats, id: \.self) { format in
                                Text(format)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                        // Opciones adicionales informativas
                        VStack(spacing: 12) {
                            HStack {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(.green)
                                Text("Incluye metadatos OCR")
                                    .font(.subheadline)
                                    
                                    
                                Spacer()
                            }
                            HStack {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(.green)
                                Text("Compatible con sistemas contables")
                                    .font(.subheadline)
                
                                Spacer()
                            }
                        }
                        .padding(.vertical, 8)
                        
                        // Botón de exportación
                        Button(action: {
                            iniciarExportacion()
                        }) {
                            HStack {
                                if isExporting {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                        .padding(.trailing, 8)
                                } else {
                                    Image(systemName: "arrow.down.to.line")
                                        .font(.title2)
                                        
                                }
                                Text(isExporting ? "Generando archivo..." : "Exportar Reporte Contable")
                            }
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(isExporting ? Color.gray : Color.orange)
                            .cornerRadius(14)
                        }
                        .disabled(isExporting)
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(20)
                    
                    // Alerta de éxito controlada
                    if !exportMessage.isEmpty {
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.title2)
                                .foregroundColor(.green)
                                .padding()
                            Text(exportMessage)
                                .font(.system(size: 16, weight: .medium))
                            Spacer()
                        }
                        .padding()
                        .background(Color.green.opacity(0.12))
                        .cornerRadius(14)
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Exportar Datos")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func iniciarExportacion() {
        isExporting = true
        exportMessage = ""
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
            isExporting = false
            exportMessage = "¡Reporte .\(selectedFormat.lowercased()) guardado en descargas!"
        }
    }
}

struct ExportDataView_Previews: PreviewProvider {
    static var previews: some View {
        ExportDataView()
    }
}
