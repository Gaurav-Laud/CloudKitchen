//
//  OTPVerificationScreen.swift
//  CloudKitchen
//
//  Created by E5000745 on 04/07/24.
//

import SwiftUI

struct OTPVerificationScreen: View {
    @ObservedObject var loginViewModel = LoginViewModel()
    @State var otp: String = ""
    @State var otp2: Int = 0
    var body: some View {
            VStack(alignment: .leading) {
                CloudLabel(text: Constants.login, font: .title, textColor: .red, fontWeight: .bold)
                getNumberView()
                Spacer()
            }
            .padding()
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
        .padding(.top, 25)
        getOTPView()
            .padding(.leading, 30)
        CloudButton(title: Constants.authenticate)
    }
    @ViewBuilder
    private func getOTPView() -> some View {
        HStack {
            CloudLabel(text: "OTP", font: .title3, textColor: .red, fontWeight: .heavy)
            OTPView(numberOfDigits: 4)
        }
    }
}

struct OTPView: View {
    var numberOfDigits: Int
    @State private var digits: [String]
    private var selectedIndex: Int
    var otpValue: String {
        digits.reduce("", { $0 + $1 })
    }
    init(numberOfDigits: Int) {
        self.numberOfDigits = numberOfDigits
        self.digits = Array(repeating: "", count: numberOfDigits)
    }
    var body: some View {
        HStack {
            ForEach(0..<numberOfDigits, id: \.self) { index in
                getOTPTextField(text: $digits[index], valueChangedCallback: {
                    if index == numberOfDigits - 1 {
                        
                    }
                })
            }
        }
    }
    @ViewBuilder
    private func getOTPTextField(text: Binding<String>, valueChangedCallback: @escaping () -> Void = { }) -> some View {
        VStack(alignment: .leading) {
            TextField("", text: text)
                .frame(width: 31)
                .keyboardType(.numberPad)
                .font(.title)
                .onChange(of: text.wrappedValue, { valueChangedCallback() })
            Rectangle()
                .foregroundStyle(.red)
                .frame(width: 31, height: 3)
        }
    }
}

#Preview {
    OTPVerificationScreen()
}
