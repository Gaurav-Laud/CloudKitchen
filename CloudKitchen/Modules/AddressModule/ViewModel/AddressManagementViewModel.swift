//
//  AddressManagementViewModel.swift
//  CloudKitchen
//
//  Created by E5000745 on 17/07/24.
//

import Foundation
@Observable
class AddressManagementViewModel {
    var addresses: [LocationModel] = []
    var displayAddresses: [LocationModel] = []
    var searchString: String = ""
    func getLocation(_ completion: @escaping (LocationModel) -> Void) {
        CloudLocationManager.shared.getLocation { [weak self] latitude, longitude in
            guard let _ = self else { return }
            CloudLocationManager.shared.getCityName(latitude: latitude, longitude: longitude) { location in
                CloudKitchenUtility.shared.selectedAddress = location
                completion(location)
            }
        }
    }
    func fetchAddresses(for userId: String) {
        Task {
            do {
                let userInfo = try await APIHandler.shared.makeFetchAPICall(UserModel.self, url: "https://whale-app-ct2dl.ondigitalocean.app/users/\(userId)")
                self.addresses = userInfo.addresses
                self.displayAddresses = getSearchResults(for: searchString)
            } catch {
                print("Error while fetching user data: \(error)")
            }
        }
    }
    func getSearchResults(for searchTerm: String) -> [LocationModel] {
        guard !searchTerm.isEmpty else { return addresses }
        return addresses.filter({ $0.fullName.contains(searchTerm) })
    }
}
