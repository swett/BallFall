//
//  PopUpView.swift
//  BallFall
//
//  Created by Mykyta Kurochka on 23.06.2024.
//

import Foundation
import SwiftUI
import UIKit
import WebKit

//struct WebView: UIViewRepresentable {
//    let url: URL
//    
//    
//    
//    
//    func makeUIView(context: Context) -> WKWebView {
//        let webView = WKWebView()
//        webView.allowsBackForwardNavigationGestures = true
//        let request = URLRequest(url: url)
//        webView.load(request)
//        return webView
//    }
//    
//    func updateUIView(_ uiView: WKWebView, context: Context) {
////        let request = URLRequest(url: url)
////        uiView.load(request)
//    }
//}

struct WebView: UIViewRepresentable {
    let url: URL
    @Binding var gameState: GameState

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.allowsBackForwardNavigationGestures = false
        let request = URLRequest(url: url)
        webView.load(request)

        let swipeGesture = UIPanGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handleSwipe(_:)))
        webView.addGestureRecognizer(swipeGesture)

        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            // Handle navigation completion if needed
        }

        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            // Handle navigation failure if needed
        }

        @objc func handleSwipe(_ gesture: UIPanGestureRecognizer) {
            guard let webView = gesture.view as? WKWebView else { return }
            let translation = gesture.translation(in: webView)

            if gesture.state == .ended {
                if translation.x > 100 { // Customize the threshold for swipe detection
                    if webView.canGoBack {
                        webView.goBack()
                    } else {
                        DispatchQueue.main.async {
                            self.parent.gameState = .notStarted
                        }
                    }
                }
            }
        }
    }
}
