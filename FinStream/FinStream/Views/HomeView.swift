//
//  HomeView.swift
//  FinStream
//
//  Created by Admin on 10/06/2026.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue.opacity(0.5)]), startPoint: .topLeading, endPoint: .bottom).ignoresSafeArea()
                
                ScrollView(.vertical, showsIndicators: false) {
                    // Contenedor principal con separación entre los bloques modulares
                    VStack(spacing: 20) {
                        // Header (Componente de usuario)
                        headerView
                        
                        // 1. Bloque: Tarjeta de Balance General
                        balanceCard
                        
                        // 2. Bloque Contenedor: Transacciones
                        transactionsCard
                        
                        // 3. Bloque Contenedor: Educación Financiera
                        educationCard
                        
                        // 4. Bloque Contenedor: Herramientas y Logística
                        toolsCard
                    }
                    .padding(.vertical)
                }
                .onAppear {
                    viewModel.loadTransactions()
                }
                .alert(isPresented: $viewModel.showSecurityAlert) {
                    Alert(title: Text("Seguridad FinStream"),
                          message: Text(viewModel.securityStatusMessage),
                          dismissButton: .default(Text("Entendido"))
                    )
                }
            }
            .navigationBarHidden(true)
        }
    
    // MARK: - Subvistas Bas6
    
    private var headerView: some View {
        HStack {
            Button(action: {
                viewModel.didTapProfile()
            }) {
                Image("Eminen")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.gray, lineWidth:  1)
                    )
                    .shadow(radius: 4)
                    
                    
            }
            .buttonStyle(PlainButtonStyle())
            
            Text("FINSTREAM APP")
                .font(.title2)
                .bold()
        
            Spacer()
            
        // Biometric button profile
            
            Button(action: {
                viewModel.saveCredentialsSecurely()
            }) {
                Image(systemName: "lock.shield.fill")
                    .font(.title2)
                    .foregroundColor(.blue)
                    .padding(8)
                    .background(Color.blue.opacity(0.1))
                    .clipShape(Circle())
            }
            
            HStack {
                Image(systemName: "faceid")
                    .foregroundColor(.green)
                Text("FaceID Ok")
                    .font(.caption)
                    .foregroundColor(.green)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color.green.opacity(0.1))
            .cornerRadius(8)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
    }
 //
    // MARK: - Bloques Modulares Estilizados (Figma Look)
    
    // 1. Modulo Balance
    private var balanceCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Balance Total")
                .font(.subheadline)
                .foregroundColor(.gray)
            Text("$14,250.00 ARS      💸")
                .font(.largeTitle)
                .bold()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(24)
        .padding(.horizontal)
    }
    
    // 2. Modulo Transacciones
    private var transactionsCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("📊 TRANSACCIONES")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    
                
                Spacer()
                
                Button(action: {
                    viewModel.didTapAnalytics()
                }) {
                    Image(systemName: "ellipsis")
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .padding(14)
                        .background(Color(.systemBackground)) // Contraste blanco interno
                        .clipShape(Circle())
                }
            }
            
            VStack(spacing: 12) {
                Image(systemName: "tray.and.arrow.down")
                    .font(.largeTitle)
                    .foregroundColor(.blue)
                Text("No hay movimientos este mes")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            
            if viewModel.isLoading {
                VStack(spacing: 0) {
                        // Mostramos 3 filas falsas con brillo animado mientras descarga el JSON real
                    TransactionRowPlaceholder()
                    Divider()
                    TransactionRowPlaceholder()
                    Divider()
                    TransactionRowPlaceholder()
                }
            } else if let error = viewModel.errorMessage {
                VStack(spacing: 8) {
                    Text("⚠️ Error al cargar datos")
                        .font(.subheadline)
                        .bold()
                    Text(error)
                        .font(.caption)
                        .foregroundColor(.red)
                }
                .frame(maxWidth: .infinity)
                .padding()
            } else {
                VStack(spacing: 0) {
                    ForEach(viewModel.transactions) { transaction in
                        TransactionRow(transaction: transaction)
                        if transaction.id != viewModel.transactions.last?.id {
                            Divider()
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(24)
        .padding(.horizontal)
    }
    
    struct HerramientasView: View {
        // 🛠️ 1. Inyectamos la acción de descarte del sistema
        @Environment(\.presentationMode) var presentationMode
        
        var body: some View {
            VStack(alignment: .leading) {
                // 🛠️ 2. Tu propia barra superior personalizada
                HStack {
                    Button(action: {
                        // Cierra la pantalla actual y vuelve a la Home
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                                .font(.title2)
                                
                            Text("Atrás")
                        }
                        .foregroundColor(.blue) // O el color de tu app
                    }
                    
                    Spacer()
                    
                    Text("Herramientas")
                        .font(.headline)
                        .padding(.trailing, 40) // Para centrar el título compensando el botón
                    
                    Spacer()
                }
                .padding()
                
                // ... El resto de tu diseño actual ...
                Spacer()
            }
            // Ocultamos la barra nativa si hiciera falta para que no se duplique
            .navigationBarHidden(true)
        }
    }
    
    // 3. Modulo Educación Financiera (Videos Carrusel)
    private var educationCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("🎓 EDUCACIÓN FINANCIERA")
                .font(.system(size: 18, weight: .bold))
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    videoCard(
                        title: "Interés Compuesto",
                        duration: "12:45 mins",
                        timeLabel: "00:30",
                        imageName: "bg_interes_compuesto",
                        fallbackColor: Color.blue.opacity(0.15),
                        videoID: "YUQLs9oO1U0"
                    )
                    
                    videoCard(
                        title: "Manejo de Deudas",
                        duration: "12:45 mins",
                        timeLabel: "00:05",
                        imageName: "bg_manejo_deudas",
                        fallbackColor: Color.orange.opacity(0.15),
                        videoID: "7k1D4dCtkW0"
                    )
                    
                    videoCard(
                        title: "Presupuesto Mensual",
                        duration: "08:20 mins",
                        timeLabel: "08:20",
                        imageName: "bg_presupuesto",
                        fallbackColor: Color.purple.opacity(0.15),
                        videoID: "Rir3GoHwgVs"
                    )
                    
                    videoCard(
                        title: "Mentalidad Financiera",
                        duration: "15:10 mins",
                        timeLabel: "15:10",
                        imageName: "bg_mentalidad",
                        fallbackColor: Color.blue.opacity(0.15),
                        videoID: "OGdpckef9-E"
                    )
                }
                .padding(.horizontal)
                .padding(.bottom, 4)
            }
        }
        .padding(.vertical)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(24)
        .padding(.horizontal)
    }
    
    // 4. Modulo Herramientas (Filas organizadas con fondos independientes)
    private var toolsCard: some View {
            VStack(alignment: .leading, spacing: 16) {
                Text("⚙️ HERRAMIENTAS Y LOGÍSTICA")
                    .font(.system(size: 18, weight: .bold))
                    
                
                VStack(spacing: 10) {
                    // Ejemplo pasando Text() directo como pantalla de información rápida:
                    toolRow(
                        title: "Simulador IA",
                        subtitle: "Proyectá tus ahorros a largo plazo",
                        icon: "cpu",
                        backgroundColor: Color.blue.opacity(0.12),
                        iconColor: .blue,
                        destination: IASimulatorView() // <--- Reemplazado acá
                    )
                    
                    toolRow(
                        title: "Reglas de Gasto",
                        subtitle: "Límites inteligentes de presupuesto",
                        icon: "gearshape.2.fill",
                        backgroundColor: Color.green.opacity(0.12),
                        iconColor: .green,
                        destination: ExpenseRulesView() // <--- ¡Conectada la segunda!
                    )
                    
                    toolRow(
                        title: "Escáner Inteligente",
                        subtitle: "Subí tus comprobantes mediante OCR",
                        icon: "doc.text.viewfinder",
                        backgroundColor: Color.purple.opacity(0.12),
                        iconColor: .purple,
                        destination: ScannerOCRView() // <--- Pantalla destino
                    )
                    
                    toolRow(
                        title: "Exportar Datos",
                        subtitle: "Descargá tus reportes financieros",
                        icon: "arrow.down.doc.fill",
                        backgroundColor: Color.orange.opacity(0.12),
                        iconColor: .orange,
                        destination: ExportDataView() // <--- Pantalla destino
                    )
                }
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(24)
            .padding(.horizontal)
        }
    // MARK: - Builders de Componentes Hijos
    
    @ViewBuilder
    private func videoCard(title: String, duration: String, timeLabel: String, imageName: String, fallbackColor: Color, videoID: String) -> some View {
        Button(action: {
            viewModel.didSelectVideo(title: title, url: videoID)
        }) {
            VStack(alignment: .leading, spacing: 8) {
                ZStack(alignment: .bottomTrailing) {
                    Group {
                        if let uiImage = UIImage(named: imageName) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } else {
                            LinearGradient(
                                gradient: Gradient(colors: [fallbackColor, fallbackColor.opacity(0.6)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        }
                    }
                    .frame(width: 160, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    Image(systemName: "play.circle.fill")
                        .font(.system(size: 32))
                        .foregroundColor(.white)
                        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 1)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    
                    Text(timeLabel)
                        .font(.system(size: 9, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 5)
                        .padding(.vertical, 2)
                        .background(Color.black.opacity(0.6))
                        .cornerRadius(4)
                        .padding([.bottom, .trailing], 6)
                }
                .frame(width: 160, height: 100)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(.primary)
                        .lineLimit(1)
                    
                    Text(duration)
                        .font(.system(size: 11))
                        .foregroundColor(.gray)
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    @ViewBuilder
        private func toolRow<Destination: View>(title: String, subtitle: String, icon: String, backgroundColor: Color, iconColor: Color, destination: Destination) -> some View {
            
            // Reemplazamos el Button por un NavigationLink nativo
            NavigationLink(destination: destination) {
                HStack(spacing: 14) {
                    Image(systemName: icon)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(iconColor)
                        .frame(width: 38, height: 38)
                        .background(backgroundColor)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(title)
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.leading)
                        Text(subtitle)
                            .font(.system(size: 11))
                            .foregroundColor(.gray)
                            .lineLimit(1)
                            .multilineTextAlignment(.leading)
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(Color(.lightGray))
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 12)
                .background(Color(.systemBackground))
                .cornerRadius(14)
            }
            .buttonStyle(ScaleButtonStyle()) // Mantiene tus colores e impide que todo se pinte de azul
        }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        // Creamos un coordinador dummy/ficticio solo para la vista previa
        let dummyCoordinator = MainCoordinator(navigationController: UINavigationController())
        // Le inyectamos el ViewModel real que pide la vista
        let dummyViewModel = HomeViewModel(coordinator: dummyCoordinator, apiService: APIService())
        
        return HomeView(viewModel: dummyViewModel)
            .preferredColorScheme(.light) // O .dark si querés probar cómo se ve en modo oscuro
    }
}

