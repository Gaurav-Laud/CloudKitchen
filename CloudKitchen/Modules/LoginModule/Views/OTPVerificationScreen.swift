//
//  OTPVerificationScreen.swift
//  CloudKitchen
//
//  Created by E5000745 on 04/07/24.
//

import SwiftUI
import OtpView_SwiftUI
struct OTPVerificationScreen: View {
    @ObservedObject private var loginViewModel = LoginViewModel()
    var body: some View {
            VStack(alignment: .leading) {
                CloudLabel(text: Constants.verify.capitalized, font: .title, textColor: .red, fontWeight: .bold)
                getNumberView()
                Spacer()
            }
            .padding()
            .onAppear(perform: { loginViewModel.setupTimer() })
    }
    @ViewBuilder
    private func getNumberView() -> some View {
        VStack(spacing: 30) {
            HStack {
                Image(Constants.india_flag, bundle: Bundle.main)
                Text(Constants.country_code)
                    .font(.title2)
                    .bold()
                CloudTextField(placeholder: Constants.phone_number, inputString: $loginViewModel.mobileNumber, keyboardType: .numberPad)
            }
            .padding(.top, 25)
            getOTPView()
                .padding(.leading, 30)
            HStack {
                Spacer()
                self.resendButton(isEnabled: $loginViewModel.timer.wrappedValue == nil, time: loginViewModel.minTimeLimit - $loginViewModel.time.wrappedValue)
            }
            CloudButton(title: Constants.verify, isTextCaps: true) {
                loginViewModel.verifyOTP(loginViewModel.otp) { isOTPVerified in
                    
                }
            }
        }
    }
    @ViewBuilder
    private func getOTPView() -> some View {
        HStack {
            CloudLabel(text: "OTP", font: .title3, textColor: .red, fontWeight: .heavy)
            OtpView_SwiftUI(otpCode: $loginViewModel.otp, otpCodeLength: 4, textColor: .red, textSize: 20)
                .frame(width: 250)
        }
    }
    @ViewBuilder
    private func resendButton(isEnabled: Bool, time: Int) -> some View {
        Text(isEnabled ? "Resend OTP?" : "Resend OTP in \(time)")
            .font(.body)
            .onTapGesture {
                if isEnabled {
                    self.loginViewModel.requestOTP(for: loginViewModel.mobileNumber)
                    self.loginViewModel.disableTimer()
                    self.loginViewModel.setupTimer()
                }
            }
    }
}

#Preview {
    OTPVerificationScreen()
}
