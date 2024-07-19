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
}
