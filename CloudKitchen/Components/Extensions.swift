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
}
