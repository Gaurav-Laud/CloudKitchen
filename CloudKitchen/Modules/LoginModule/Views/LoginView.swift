//
//  LoginView.swift
//  CloudKitchen
//
//  Created by E5000745 on 02/07/24.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var loginViewModel = LoginViewModel()
    @State var showOTPVerificationView: Bool = false
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                Image(Constants.login_screen_image, bundle: Bundle.main)
                    .resizable()
                    .frame(height: geometry.size.height/2)
                    .clipShape(UnevenRoundedRectangle(cornerRadii: RectangleCornerRadii(bottomLeading: 44, bottomTrailing: 44)))
                VStack(alignment: .leading) {
                    CloudLabel(text: Constants.login, font: .title, textColor: .red, fontWeight: .bold)
                    Text(Constants.enter_your_phone_number_to_proceed)
                        .font(.footnote)
                    self.getNumberView()
                    Spacer()
                    self.getBottomView()
                }
                .padding()
            }
        }
    }
    
    @ViewBuilder
    private func getNumberView() -> some View {
        HStack {
            Image(Constants.india_flag, bundle: Bundle.main)
            Text(Constants.country_code)
                .font(.title2)
                .bold()
            CloudTextField(placeholder: Constants.phone_number, inputString: $loginViewModel.mobileNumber, keyboardType: .numberPad)
        }
        .padding(.top, 40)
        CloudButton(title: Constants.authenticate) {
            self.loginViewModel.requestOTP(for: loginViewModel.mobileNumber)
            showOTPVerificationView = true
        }
        .navigationDestination(isPresented: $showOTPVerificationView, destination: { OTPVerificationScreen() })
    }
    
    @ViewBuilder
    private func getBottomView() -> some View {
        VStack(alignment: .center) {
            Text(Constants.trouble_login)
                .font(.subheadline)
                .padding(.bottom, 40)
            HStack {
                Text(Constants.terms_conditions)
                    .font(.footnote)
                    .underline()
                Spacer()
                Text(Constants.privacy_policy)
                    .font(.footnote)
                    .underline()
            }
        }
    }
}

#Preview {
    LoginView()
}
