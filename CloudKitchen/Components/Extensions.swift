//
//  Extensions.swift
//  CloudKitchen
//
//  Created by E5000745 on 05/07/24.
//

import SwiftUI
import AlertToast

extension View {
    func showToast(isPresenting: Binding<Bool>, title: String? = nil, duration: Double = 3) -> some View {
        self
            .toast(isPresenting: isPresenting, duration: 3, alert: {
                AlertToast(type: .regular, title: title)
            })
    }
    func roundCorners(_ radius: Float = 16) -> some View {
        self
            .clipShape(RoundedRectangle(cornerRadius: CGFloat(radius)))
    }
    func addBorder(cornerRadius: CGFloat = 16, borderColor: Color = .yellow, width: CGFloat = 2) -> some View {
        self
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: width)
            )
    }
}
