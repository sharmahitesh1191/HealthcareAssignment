//
//  WebView.swift
//  HealthcareAssignment
//
//  Created by Hitesh Sharma on 07/12/23.
//


import WebKit
import Foundation
import SwiftUI

struct WebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView  {
        let wkwebView = WKWebView()
        let request = URLRequest(url: url)
        wkwebView.load(request)
        return wkwebView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}

