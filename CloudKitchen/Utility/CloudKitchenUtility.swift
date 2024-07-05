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
