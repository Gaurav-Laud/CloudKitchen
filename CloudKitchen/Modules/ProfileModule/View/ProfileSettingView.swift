//
//  ProfileSettingView.swift
//  CloudKitchen
//
//  Created by E5000745 on 14/10/24.
//

import SwiftUI

struct ProfileSettingView: View {
    @Environment(\.dismiss) private var dismiss
    @State var fullName: String = UserDefaultsUtility.getUser()?.name ?? ""
    @State var email: String = UserDefaultsUtility.getUser()?.email ?? ""
    var profileSettingViewModel = ProfileSettingViewModel()
    var body: some View {
        VStack {
            self.getNameFieldView()
            self.getEmailView()
            Spacer()
            self.getBottomView()
        }
        .padding()
        .navigationBarBackButtonHidden()
        .toolbar {
            self.getToolbarView()
        }
        .onAppear {
            fullName = UserDefaultsUtility.getUser()?.name ?? ""
            email = UserDefaultsUtility.getUser()?.email ?? ""
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
        ToolbarItem(placement: .topBarLeading) {
            CloudLabel(text: "Profile Settings", font: .title2)
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
    @ViewBuilder
    private func getBottomView() -> some View {
        VStack {
            CloudButton(title: "Change settings", isTextCaps: true) {
                profileSettingViewModel.setProfile(userName: fullName, email: email)
                dismiss()
            }
            CloudButton(title: "Logout", isTextCaps: true) {
                profileSettingViewModel.signOut()
            }
        }
    }
}

#Preview {
    ProfileSettingView()
}
