//
//  CloudTextField.swift
//  CloudKitchen
//
//  Created by E5000745 on 02/07/24.
//

import SwiftUI

struct CloudTextField: View {
    var placeholder: String = ""
    var inputString: Binding<String>
    var keyboardType: UIKeyboardType = .default
    var image: String?
    var onTextChange: ((String, String) -> Void) = { _, _ in }
    var body: some View {
        HStack {
            TextField(self.placeholder, text: inputString)
                .keyboardType(keyboardType)
                .onChange(of: inputString.wrappedValue, onTextChange)
            if let image = image {
                Image(systemName: image)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .background(.white)
        .tint(.secondary)
        .clipShape(.rect(cornerRadius: 16))
        .shadow(radius: 5)
    }
}

#Preview {
    Group {
        @State var str: String = ""
        CloudTextField(placeholder: "Phone Number", inputString: $str, image: "magnifyingglass")
    }
}
