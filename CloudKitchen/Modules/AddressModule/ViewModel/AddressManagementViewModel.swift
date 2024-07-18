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
    func getLocation(_ completion: (LocationModel) -> Void) {
        CloudLocationManager.shared.getLocation { [weak self] latitude, longitude in
            guard let self = self else { return }
            CloudLocationManager.shared.getCityName(latitude: latitude, longitude: longitude) { location in
                CloudKitchenUtility.shared.selectedAddress = location
            }
        }
    }
}
