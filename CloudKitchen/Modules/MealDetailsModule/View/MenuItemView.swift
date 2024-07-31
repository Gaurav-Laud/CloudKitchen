//
//  MenuItemView.swift
//  CloudKitchen
//
//  Created by E5000745 on 30/07/24.
//

import SwiftUI

struct MenuItemView: View {
    @State var menuItem: MenuItemModel
    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: URL(string: menuItem.image), content: { image in
                image.resizable()
            }, placeholder: { ProgressView() })
            .frame(width: 100, height: 75)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            VStack(alignment: .leading) {
                CloudLabel(text: "Day-\(menuItem.dayCount)", font: .title3, fontWeight: .bold, textAlignment: .leading)
                CloudLabel(text: menuItem.items.joined(separator: ","), font: .caption, textAlignment: .leading)
            }
        }
        .background(.clear)
    }
}

//#Preview {
//    MenuItemView()
//}
