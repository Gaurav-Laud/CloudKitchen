//
//  APIHandler.swift
//  CloudKitchen
//
//  Created by E5000745 on 01/07/24.
//

import Foundation
enum HTTPMethodType: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}
class APIHandler {
    static let shared = APIHandler()
    private init() { }
    
    private func prepareURLRequest(url: String, parameters: [String: Any]? = nil, httpMethod: HTTPMethodType, accessToken: String? = UserDefaultsUtility.getAccessToken()) throws -> URLRequest {
        guard let url = URL(string: url) else { throw URLError(.badURL) }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = httpMethod.rawValue
        if let accessToken = accessToken {
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        if let parameters = parameters {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        }
        return request
    }
    
    private func dataToModel<T: Codable>(_ type: T.Type, _ data: Data) throws -> T {
        try JSONDecoder().decode(type, from: data)
    }
    
    func makeFetchAPICall<T: Codable>(_ type: T.Type, url: String, parameters: [String: Any]? = nil) async throws -> T {
        let request = try prepareURLRequest(url: url, parameters: parameters, httpMethod: .get)
        let (data, _) = try await URLSession.shared.data(for: request)
        if type == [String: Any].self || type == [Any].self {
            return try JSONSerialization.jsonObject(with: data) as! T
        } else {
            return try dataToModel(type, data)
        }
    }
    
    func makePostAPICall<T: Codable>(_ type: T.Type? = nil, url: String, parameters: [String: Any]? = nil) async throws -> T? {
        let request = try prepareURLRequest(url: url, parameters: parameters, httpMethod: .post)
        let (data, _) = try await URLSession.shared.data(for: request)
        guard let type = type else { return nil }
        if type == [String: Any].self || type == [Any].self {
            return try JSONSerialization.jsonObject(with: data) as? T
        } else {
            return try dataToModel(type, data)
        }
    }
    
    func makePutAPICall<T: Codable>(_ type: T.Type? = nil, url: String, parameters: [String: Any]? = nil) async throws -> T? {
        let request = try prepareURLRequest(url: url, parameters: parameters, httpMethod: .put)
        let (data, _) = try await URLSession.shared.data(for: request)
        guard let type = type else { return nil }
        if type == [String: Any].self || type == [Any].self {
            return try JSONSerialization.jsonObject(with: data) as? T
        } else {
            return try dataToModel(type, data)
        }
    }
    
    func makeDeleteAPICall<T: Codable>(_ type: T.Type? = nil, url: String, parameters: [String: Any]? = nil) async throws -> T? {
        let request = try prepareURLRequest(url: url, parameters: parameters, httpMethod: .delete)
        let (data, _) = try await URLSession.shared.data(for: request)
        guard let type = type else { return nil }
        if type == [String: Any].self || type == [Any].self {
            return try JSONSerialization.jsonObject(with: data) as? T
        } else {
            return try dataToModel(type, data)
        }
    }
    
    func requestOTP(url: String, mobileNumber: String) async throws -> [String: Any]? {
        let parameters = ["mobileNumber": mobileNumber]
        let request = try prepareURLRequest(url: url, parameters: parameters, httpMethod: .post, accessToken: nil)
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONSerialization.jsonObject(with: data) as? [String: Any]
    }
    
    func verifyOTP(url: String, mobileNumber: String, OTP: String) async throws -> [String: Any]? {
        let parameters: [String: Any] = [:]
        let request = try prepareURLRequest(url: url, parameters: parameters, httpMethod: .put, accessToken: nil)
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONSerialization.jsonObject(with: data) as? [String: Any]
    }
}
