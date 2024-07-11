//
//  CloudLabel.swift
//  CloudKitchen
//
//  Created by E5000745 on 04/07/24.
//

import SwiftUI

struct CloudLabel: View {
    var text: String
    var font: Font = .body
    var textColor: Color = .black
    var fontWeight: Font.Weight = .regular
    var textAlignment: TextAlignment = .leading
    var body: some View {
        Text(text)
            .font(font)
            .foregroundStyle(textColor)
            .fontWeight(fontWeight)
            .multilineTextAlignment(textAlignment)
    }
}

#Preview {
    CloudLabel(text: "Hello")
}
