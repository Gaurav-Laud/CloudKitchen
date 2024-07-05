//
//  LoginViewModel.swift
//  CloudKitchen
//
//  Created by E5000745 on 02/07/24.
//

import Foundation
class LoginViewModel: ObservableObject {
    @Published var mobileNumber: String = ""
    func requestOTP(for mobileNumber: String) {
        let mobileNumber = "+91 \(mobileNumber)"
        Task {
            do {
                let result = try await APIHandler.shared.requestOTP(url: "https://whale-app-ct2dl.ondigitalocean.app/users/sendOtp", mobileNumber: mobileNumber)
                if let otp = result?["data"] {
                    print("OTP: \(otp)")
                }
            } catch {
                print("error in requesting OTP: \(error)")
            }
        }
    }
    func verifyOTP(_ otp: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        Task {
            do {
                let result = try await APIHandler.shared.verifyOTP(url: "https://whale-app-ct2dl.ondigitalocean.app/users/verifyOtp", mobileNumber: mobileNumber, OTP: otp)
                guard let data = result?["data"] as? [String: Any] else {
                    completion(.failure(DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: ""))))
                    return
                }
                guard let jwtToken = data["jwtToken"] as? [String: Any], let accessToken = jwtToken["accessToken"] as? String else {
                    completion(.failure(DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: ""))))
                    return
                }
                if let userModel = try JSONDecoder.fromJSONToModel(UserModel.self, json: data) {
                    setUser(userModel: userModel)
                }
                self.verificationSuccessResponce(true, with: accessToken)
                completion(.success(true))
            } catch {
                print("error while verifing OTP: \(error)")
                completion(.failure(error))
            }
        }
    }
    private func verificationSuccessResponce(_ isSuccess: Bool, with accessToken: String) {
        UserDefaultsUtility.setSignedInStatus(isSuccess)
        UserDefaultsUtility.setAccessToken(accessToken)
    }
    private func setUser(userModel: UserModel) {
        UserDefaultsUtility.setUser(userModel)
    }
}
