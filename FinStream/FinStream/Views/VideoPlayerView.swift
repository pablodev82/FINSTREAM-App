//
//  VideoPlayerView.swift
//  FinStream
//
//  Created by Admin on 10/06/2026.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    let videoURL: URL
    
    // Inicializamos el reproductor nativo de AVKit
    private var player: AVPlayer {
        AVPlayer(url: videoURL)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // 1. REPRODUCTOR CON LOOK DE YOUTUBE
            ZStack {
                Color.black // Fondo negro sólido detrás del video
                
                VideoPlayer(player: player)
                    // Forzamos la relación de aspecto cinematográfica 16:9
                    .aspectRatio(16/9, contentMode: .fit)
            }
            // Limitamos la altura del contenedor para que ocupe solo la parte superior
            .frame(maxHeight: 250)
            .cornerRadius(12) // Un toque estético de bordes redondeados
            .padding(.horizontal)
            
            // 2. ESPACIO PARA DETALLES (Igual que en YouTube)
            VStack(alignment: .leading, spacing: 8) {
                Text("Clase Especial: Interes Compuesto")
                    .font(.title3)
                    .bold()
                    .padding(.top)
                
                Text("Academia FinStream • 1,240 vistas")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Divider()
                    .padding(.vertical, 8)
                
                Text("En esta sección vas a aprender:   💸💸💰💰 \n¿Como podemos aprovechar el interés compuesto en nuestras finanzas? Para aprender a dominarlo para hacer crecer de manera exponencial nuestro dinero; existen claves importantes que debemos tener en cuenta como el capital inicial que vamos a invertir, la tasa de rentabilidad y el tiempo que invertiremos; además de otros factores como los que en este video se presenta, como el ahorro, el riesgo, la reinversión de nuestras ganancias. La fortuna de las personas ricas no solo es por su mentalidad, su entorno, sino también por que supieron usar las herramientas como el interés compuesto a su favor, como por ejemplo el multimillonario Warren buffet, considerado uno de los hombres más ricos del planeta. Esta herramienta puede mejorar tus finanzas, desarrollar tu inteligencia financiera y crearte ingresos pasivos que te den liberta financiera. No te lo pierdas, nos vemos dentro del video...")
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal)
            
            Spacer() // Empuja todo el contenido hacia arriba
        }
        .background(Color(.systemBackground)) // Fondo adaptativo para modo claro/oscuro
        .navigationTitle("Reproductor")
        .navigationBarTitleDisplayMode(.inline)
    }
}
 
struct VideoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        // Le inyectamos una URL dummy para que el compilador no llore
        VideoPlayerView(videoURL: URL(string: "https://sandbox.vimeo.com/sample-video.mp4")!)
    }
}
