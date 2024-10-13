//
//  ProfileSettingView.swift
//  CloudKitchen
//
//  Created by E5000745 on 14/10/24.
//

import SwiftUI

struct ProfileSettingView: View {
    @Environment(\.dismiss) private var dismiss
    @State var fullName: String = ""
    @State var email: String = ""
    var profileSettingViewModel = ProfileSettingViewModel()
    var body: some View {
        VStack {
            self.getNameFieldView()
            self.getEmailView()
            Spacer()
            CloudButton(title: "Change settings", isTextCaps: true) {
                profileSettingViewModel.setProfile(userName: fullName, email: email)
            }
        }
        .padding()
        .navigationBarBackButtonHidden()
        .toolbar {
            self.getToolbarView()
        }
    }
    @ToolbarContentBuilder
    private func getToolbarView() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button(action: { dismiss() }, label: {
                Label("", systemImage: Constants.chevron_left)
            })
            .tint(.black)
        }
    }
    @ViewBuilder
    private func getNameFieldView() -> some View {
        VStack(alignment: .leading) {
            CloudLabel(text: "Full Name", textColor: .gray)
            TextField(text: $fullName, label: { })
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(.gray)
        }
        .padding(.vertical, 40)
    }
    @ViewBuilder
    private func getEmailView() -> some View {
        VStack(alignment: .leading) {
            CloudLabel(text: "Email address", textColor: .gray)
            TextField(text: $email, label: { })
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(.gray)
        }
    }
}

#Preview {
    ProfileSettingView()
}
