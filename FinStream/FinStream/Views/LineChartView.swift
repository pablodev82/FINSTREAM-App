//
//  LineChartView.swift
//  FinStream
//
//  Created by Admin on 16/06/2026.
//

import SwiftUI

struct LineChartView: View {
    let points: [CGFloat]
    let labels: [String]
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ZStack {
                    // 1. Líneas de guía horizontales de fondo
                    VStack {
                        ForEach(0..<4) { _ in
                            Divider()
                            Spacer()
                        }
                    }
                    
                    // 2. Dibujo de la línea del gráfico de gastos
                    Path { path in
                        guard points.count > 1 else { return }
                        
                        let widthStep = geometry.size.width / CGFloat(points.count - 1)
                        // Escalamos los puntos para que quepan estéticamente en la pantalla
                        let highestPoint = points.max() ?? 1
                        let scaleY = (geometry.size.height * 0.7) / highestPoint
                        
                        let startY = geometry.size.height - (points[0] * scaleY)
                        path.move(to: CGPoint(x: 0, y: startY))
                        
                        for index in 1..<points.count {
                            let xPosition = CGFloat(index) * widthStep
                            let yPosition = geometry.size.height - (points[index] * scaleY)
                            path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                        }
                    }
                    .stroke(
                        LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading, endPoint: .trailing),
                        style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round)
                    )
                    
                    // 3. Nodos circulares interactivos en cada punto de quiebre
                    ForEach(0..<points.count, id: \.self) { index in
                        let widthStep = geometry.size.width / CGFloat(points.count - 1)
                        let highestPoint = points.max() ?? 1
                        let scaleY = (geometry.size.height * 0.7) / highestPoint
                        
                        let xPos = widthStep * CGFloat(index)
                        let yPos = geometry.size.height - (points[index] * scaleY)
                        
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 8, height: 8)
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                            .position(x: xPos, y: yPos)
                    }
                }
            }
            .frame(height: 140)
            .padding(.horizontal, 5)
            
            // 4. Etiquetas de los meses abajo (Eje X)
            HStack {
                ForEach(0..<labels.count, id: \.self) { index in
                    Text(labels[index])
                        .font(.caption2)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.top, 4)
        }
    }
}

struct LineChartView_Previews: PreviewProvider {
    static var previews: some View {
        // Le pasamos valores numéricos reales (CGFloat) y los meses (String) para la simulación
        LineChartView(
            points: [20, 60, 45, 90, 75, 120, 100],
            labels: ["jan", "feb", "mar", "apr", "may", "jun", "jul"]
        )
        .padding()
        .previewLayout(.sizeThatFits) // Hace que la vista previa se adapte al tamaño del gráfico
    }
}
