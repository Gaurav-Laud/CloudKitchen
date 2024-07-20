//
//  CloudKitchenUtility.swift
//  CloudKitchen
//
//  Created by E5000745 on 05/07/24.
//

import Foundation
extension JSONDecoder {
    public static func fromJSONToModel<T: Codable>(_ model: T.Type, json: [String: Any])  throws -> T? {
        do {
            let data = try JSONSerialization.data(withJSONObject: json)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("error decoding \(String(describing: T.self)): \(error)");
            throw error
        }
    }
    public static func fromJSONToModel<T: Codable>(_ model: T.Type, json: [[String: Any]])  throws -> T? {
        do {
            let data = try JSONSerialization.data(withJSONObject: json)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("error decoding \(String(describing: T.self)): \(error)");
            throw error
        }
    }
}
extension JSONEncoder {
    public static func fromModelToJSON<T: Codable>(_ object: T) throws -> Any? {
        do {
            let data = try JSONEncoder().encode(object)
            return try JSONSerialization.jsonObject(with: data)
        } catch {
            print("error encoding \(String(describing: T.self)): \(error)");
            throw error
        }
    }
}

class CloudKitchenUtility {
    static let shared = CloudKitchenUtility()
    let addressNotificationKey = Notification.Name("addressNotificationKey")
    var selectedAddress: LocationModel? {
        set {
            guard let address = newValue else { return }
            UserDefaultsUtility.setSelectedAddress(address)
            NotificationCenter.default.post(name: self.addressNotificationKey, object: nil, userInfo: [addressNotificationKey.rawValue: address])
        }
        get {
            UserDefaultsUtility.getSelectedAddress()
        }
    }
}
