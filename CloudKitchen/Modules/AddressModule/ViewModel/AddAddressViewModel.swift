//
//  AddAddressViewModel.swift
//  CloudKitchen
//
//  Created by E5000745 on 19/07/24.
//

import Foundation
@Observable
class AddAddressViewModel {
    var name: String = ""
    var phoneNumber: String = ""
    var buildingName: String = ""
    var area: String = ""
    var zipCode: String = ""
    var city: String = ""
    
    func saveAddress(_ completion: @escaping () -> Void) {
        Task {
            do {
                let userModel = UserDefaultsUtility.getUser()
                guard let userId = userModel?.id else { return }
                let locationModel = LocationModel(houseNo: buildingName, addressLine1: area, addressLine2: "", city: city, country: "", fullName: name, phoneNumber: phoneNumber)
                userModel?.addresses.append(locationModel)
                guard let userDict = try JSONEncoder.fromModelToJSON(userModel?.addresses) as? [[String: Any]] else { return }
                let res = try await APIHandler.shared.makePutAPICall(UserModel.self, url: "https://whale-app-ct2dl.ondigitalocean.app/users/\(userId)", parameters: ["addresses": userDict])
                print(res?.id ?? "^^^^")
                completion()
            } catch {
                print("Error while saving address in user model: \(error)")
            }
        }
    }
    func validateDetails() -> Bool {
        !name.isEmpty && !phoneNumber.isEmpty && !buildingName.isEmpty && !area.isEmpty && !zipCode.isEmpty && !city.isEmpty
    }
}
