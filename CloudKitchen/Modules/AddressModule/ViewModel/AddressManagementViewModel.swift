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
            guard let self = self else { return }
            CloudLocationManager.shared.getCityName(latitude: latitude, longitude: longitude) { location in
                CloudKitchenUtility.shared.selectedAddress = location
                self.addresses.append(location)
                self.postAddress(locationModel: location)
                completion(location)
            }
        }
    }
    func fetchAddresses(for userId: String) {
        Task { [weak self] in
            guard let self = self else { return }
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
    func selectAddress(_ address: LocationModel) {
        addresses.forEach({ $0.isSelected = $0.id == address.id })
    }
    func setGlobalSelectedAddress() {
        CloudKitchenUtility.shared.selectedAddress = addresses.filter({ $0.isSelected }).first
    }
    private func postAddress(locationModel: LocationModel) {
        Task { [weak self] in
            guard let self = self else { return }
            do {
                let userModel = UserDefaultsUtility.getUser()
                userModel?.addresses = addresses
                guard let userId = userModel?.id else { return }
                guard let userDict = try JSONEncoder.fromModelToJSON(userModel?.addresses) as? [[String: Any]] else { return }
                let user = try await APIHandler.shared.makePutAPICall(UserModel.self, url: "https://whale-app-ct2dl.ondigitalocean.app/users/\(userId)", parameters: ["addresses": userDict])
            } catch {
                print("Error while saving address: \(error)")
            }
        }
    }
}
