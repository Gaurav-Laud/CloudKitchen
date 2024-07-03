//
//  CloudButton.swift
//  CloudKitchen
//
//  Created by E5000745 on 30/06/24.
//

import SwiftUI

struct CloudButton: View {
    var title: String
    var isTextCaps: Bool = false
    var action: () -> Void = { }
    var body: some View {
        Button(action: action, label: {
            Text(isTextCaps ? title.uppercased() : title)
                .padding()
                .frame(maxWidth: .infinity)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .background(.yellow)
                .clipShape(.rect(cornerRadius: 6))
        })
    }
}

#Preview {
    CloudButton(title: "title", isTextCaps: true)
}
