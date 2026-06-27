//
//  ScannerOCRView.swift
//  FinStream
//
//  Created by Admin on 19/06/2026.
//

import SwiftUI

struct ScannerOCRView: View {
    @State private var isScanning = false
    @State private var scanCompleted = false
    @State private var detectedTotal = ""
    @State private var detectedMerchant = ""
    @State private var lineOffset: CGFloat = -100 // Para la animación de la línea láser
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    
                    // --- RECUADRO DEL VISOR DE LA CÁMARA SIMULADA ---
                    VStack(spacing: 16) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.black.opacity(0.85))
                                .frame(height: 240)
                            
                            if isScanning {
                                // Línea de escaneo láser animada
                                GeometryReader { geo in
                                    Rectangle()
                                        .fill(LinearGradient(
                                            gradient: Gradient(colors: [Color.purple, Color.purple.opacity(0.0)]),
                                            startPoint: .top,
                                            endPoint: .bottom
                                        ))
                                        .frame(height: 4)
                                        .shadow(color: .purple, radius: 4, x: 0, y: 0)
                                        .offset(y: lineOffset)
                                        .onAppear {
                                            withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: true)) {
                                                lineOffset = 230
                                            }
                                        }
                                }
                                .frame(height: 240)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                
                                VStack(spacing: 12) {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    Text("Leyendo datos con IA y OCR...")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(.white)
                                }
                            } else if scanCompleted {
                                VStack(spacing: 8) {
                                    Image(systemName: "doc.text.fill")
                                        .font(.system(size: 40))
                                        .foregroundColor(.purple)
                                    Text("¡Documento digitalizado con éxito!")
                                        .font(.system(size: 14, weight: .bold))
                                        .foregroundColor(.white)
                                }
                            } else {
                                VStack(spacing: 12) {
                                    Image(systemName: "viewfinder")
                                        .font(.system(size: 45))
                                        .foregroundColor(.purple)
                                    Text("Centrá el remito, factura o comprobante")
                                        .font(.system(size: 13))
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        
                        // Botón de acción principal
                        Button(action: {
                            simularEscaneo()
                        }) {
                            HStack {
                                Image(systemName: "doc.text.viewfinder")
                                Text(scanCompleted ? "Escanear Otro Comprobante" : "Iniciar Escáner Inteligente")
                            }
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.purple)
                            .cornerRadius(14)
                        }
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(24)
                    
                    // --- BLOQUE DE RESULTADOS EXTRAÍDOS ---
                    if scanCompleted {
                        VStack(alignment: .leading, spacing: 14) {
                            Text("DATOS EXTRAÍDOS POR RED NEURONAL")
                                .font(.system(size: 11, weight: .bold))
                                .foregroundColor(.secondary)
                                .padding(.leading, 4)
                            
                            VStack(spacing: 1) {
                                // Fila: Comercio
                                HStack {
                                    Text("Comercio / Proveedor")
                                        .font(.system(size: 14))
                                        .foregroundColor(.secondary)
                                    Spacer()
                                    Text(detectedMerchant)
                                        .font(.system(size: 14, weight: .bold))
                                }
                                .padding()
                                .background(Color(.systemBackground))
                                
                                Divider()
                                
                                // Fila: Monto
                                HStack {
                                    Text("Monto Total")
                                        .font(.system(size: 14))
                                        .foregroundColor(.secondary)
                                    Spacer()
                                    Text(detectedTotal)
                                        .font(.system(size: 15, weight: .bold))
                                        .foregroundColor(.purple)
                                }
                                .padding()
                                .background(Color(.systemBackground))
                            }
                            .cornerRadius(14)
                        }
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(24)
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Escáner Inteligente")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // --- LÓGICA SIMULADA DEL PROCESAMIENTO OCR ---
    private func simularEscaneo() {
        if scanCompleted {
            // Resetear estado para un nuevo escaneo
            scanCompleted = false
            isScanning = false
            lineOffset = -100
            detectedMerchant = ""
            detectedTotal = ""
            return
        }
        
        isScanning = true
        
        // Simulamos el delay de procesamiento de la IA (2 segundos)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            isScanning = false
            detectedMerchant = "Distribuidora Transnacional S.A."
            detectedTotal = "$32,800.00 ARS"
            scanCompleted = true
        }
    }
}

struct ScannerOCRView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerOCRView()
    }
}
