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
    var body: some View {
        TextField(self.placeholder, text: inputString)
            .padding()
            .background(.white)
            .tint(.secondary)
            .clipShape(.rect(cornerRadius: 16))
            .shadow(radius: 5)
            .keyboardType(keyboardType)
    }
}

#Preview {
    Group {
        @State var str: String = ""
        CloudTextField(placeholder: "Phone Number", inputString: $str)
    }
}
