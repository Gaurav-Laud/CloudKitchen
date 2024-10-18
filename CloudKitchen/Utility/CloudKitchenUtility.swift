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
extension Date {
    public func convertToString(_ format: String? = String.datePostingFormat, _ withUTC: Bool = false) -> String {
        let dateFormatter = DateFormatter()
        if withUTC { dateFormatter.timeZone = TimeZone(secondsFromGMT: 0) }
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
extension String {
    public static let datePostingFormat: String = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    public static let dateDisplayFormat: String = "dd-MM-yyyy"
    public func convertFormatOfDate(from originalFormat: String = String.datePostingFormat, to destinationFormat: String = String.dateDisplayFormat, _ withUTC: Bool = false) -> String? {

        // Orginal format:
        let dateOriginalFormat = DateFormatter()
        if withUTC { dateOriginalFormat.timeZone = TimeZone(secondsFromGMT: 0) }
        dateOriginalFormat.dateFormat = originalFormat

        // Destination format:
        let dateDestinationFormat = DateFormatter()
        if withUTC { dateDestinationFormat.timeZone = TimeZone(secondsFromGMT: 0) }
        dateDestinationFormat.dateFormat = destinationFormat

        // Convert current String Date to NSDate
        guard let dateFromString = dateOriginalFormat.date(from: self) else { return nil }

        // Convert new NSDate created above to String with the good format
        let dateFormatted = dateDestinationFormat.string(from: dateFromString)

        return dateFormatted
    }
}
