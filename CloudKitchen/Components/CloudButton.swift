//
//  CloudButton.swift
//  CloudKitchen
//
//  Created by E5000745 on 30/06/24.
//

import SwiftUI

struct CloudButton: View {
    private let button: Button<Text>
    init(title: String, isTextCaps: Bool = false, action: @escaping () -> Void = { }) {
        self.button = Button(isTextCaps ? title.uppercased() : title, action: action)
    }
    var body: some View {
        button
            .padding()
            .frame(maxWidth: .infinity)
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .background(.yellow)
            .clipShape(.rect(cornerRadius: 6))
    }
}

#Preview {
    CloudButton(title: "title", isTextCaps: true)
}
