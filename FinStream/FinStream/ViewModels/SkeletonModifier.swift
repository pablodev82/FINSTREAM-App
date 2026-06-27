//
//  SkeletonModifier.swift
//  FinStream
//
//  Created by Admin on 20/06/2026.
//

import SwiftUI

struct ShimmerModifier: ViewModifier {
    @State private var phase: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { geo in
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(.systemGray6),
                            Color(.systemGray4),
                            Color(.systemGray6)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .mask(
                        Rectangle()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [.clear, .white, .clear]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .scaleEffect(x: 2)
                            .offset(x: (phase - 0.5) * geo.size.width * 2)
                    )
                }
            )
            .onAppear {
                withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                    phase = 1.0
                }
            }
    }
}

// Extensión para que sea súper fácil de usar con un punto (.skeleton())
extension View {
    func skeleton(isActive: Bool) -> some View {
        Group {
            if isActive {
                self
                    .redacted(reason: .placeholder) // Ofusca el texto nativamente
                    .modifier(ShimmerModifier())
            } else {
                self
            }
        }
    }
}
