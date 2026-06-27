//
//  YouTubePlayerView.swift
//  FinStream
//
//  Created by Admin on 17/06/2026.
//


import SwiftUI
import WebKit

struct YouTubePlayerView: UIViewRepresentable {
    let videoID: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        // Permitimos la reproducción de video inline (sin forzar pantalla completa nativa)
        webView.configuration.allowsInlineMediaPlayback = true
        webView.configuration.mediaTypesRequiringUserActionForPlayback = []
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        // Usamos el formato alternativo de reproducción directa que no exige el handshake estricto del iframe
        let urlString = "https://www.youtube.com/watch?v=\(videoID)"
        
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        // Le seteamos un Header para decirle a YouTube que somos un Safari móvil real y corriente
        request.setValue("Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.0 Mobile/15E148 Safari/604.1", forHTTPHeaderField: "User-Agent")
        
        uiView.load(request)
    } 
}
