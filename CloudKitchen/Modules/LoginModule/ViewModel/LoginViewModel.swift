//
//  LoginViewModel.swift
//  CloudKitchen
//
//  Created by E5000745 on 02/07/24.
//

import Foundation
import SwiftUI
class LoginViewModel: ObservableObject {
    @Published var mobileNumber: String = ""
    func requestOTP(for mobileNumber: String) {
        let mobileNumber = "+91 \(mobileNumber)"
        Task {
            do {
                let result = try await APIHandler.shared.requestOTP(url: "https://whale-app-ct2dl.ondigitalocean.app/users/sendOtp", mobileNumber: mobileNumber)
                print("OTP: \(result?["data"] ?? "-1")")
            } catch {
                print("error in requesting OTP: \(error)")
            }
        }
    }
}
