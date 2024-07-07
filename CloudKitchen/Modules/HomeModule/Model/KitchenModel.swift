//
//  KitchenModel.swift
//  CloudKitchen
//
//  Created by E5000745 on 06/07/24.
//

import Foundation
class KitchenModel: Codable {
    var _id: String
    var name: String
    var description: String
    var addresses: [String]
    var availablePlans: [PlanModel]
    var avgRating: Float
    var noOfRatings: Int
    var reviews: [ReviewModel]
    var images: [String]
    var location: LocationModel
    var badges: [String]
    var meals: [MealModel]
    var startingPrice: Double
    var type: [String]
    var bannerImage: String
    var createdAt: String
    var updatedAt: String
    var owner: UserModel?
    var contact: [String]
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._id = try container.decode(String.self, forKey: ._id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        self.addresses = try container.decodeIfPresent([String].self, forKey: .addresses) ?? []
        self.availablePlans = try container.decodeIfPresent([PlanModel].self, forKey: .availablePlans) ?? []
        self.avgRating = try container.decodeIfPresent(Float.self, forKey: .avgRating) ?? 0
        self.noOfRatings = try container.decodeIfPresent(Int.self, forKey: .noOfRatings) ?? 0
        self.reviews = try container.decodeIfPresent([ReviewModel].self, forKey: .reviews) ?? []
        self.images = try container.decodeIfPresent([String].self, forKey: .images) ?? []
        self.location = try container.decodeIfPresent(LocationModel.self, forKey: .location) ?? LocationModel()
        self.badges = try container.decodeIfPresent([String].self, forKey: .badges) ?? []
        self.meals = try container.decodeIfPresent([MealModel].self, forKey: .meals) ?? []
        self.startingPrice = try container.decodeIfPresent(Double.self, forKey: .startingPrice) ?? 0
        self.type = try container.decodeIfPresent([String].self, forKey: .type) ?? []
        self.bannerImage = try container.decodeIfPresent(String.self, forKey: .bannerImage) ?? ""
        self.createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt) ?? ""
        self.updatedAt = try container.decodeIfPresent(String.self, forKey: .updatedAt) ?? ""
        self.owner = try container.decodeIfPresent(UserModel.self, forKey: .owner)
        self.contact = try container.decodeIfPresent([String].self, forKey: .contact) ?? []
    }
}

class PlanModel: Codable {
    var _id: String
    var name: String
    var description: String
    var type: String
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._id = try container.decode(String.self, forKey: ._id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        self.type = try container.decodeIfPresent(String.self, forKey: .type) ?? ""
    }
}

class ReviewModel: Codable {
    var _id: String
    var comment: String
    var kitchenId: String
    var feedback: String
    var rating: Float
    var createdAt: String
    var updatedAt: String
    var user: UserModel
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._id = try container.decode(String.self, forKey: ._id)
        self.comment = try container.decodeIfPresent(String.self, forKey: .comment) ?? ""
        self.kitchenId = try container.decodeIfPresent(String.self, forKey: .kitchenId) ?? ""
        self.feedback = try container.decodeIfPresent(String.self, forKey: .feedback) ?? ""
        self.rating = try container.decodeIfPresent(Float.self, forKey: .rating) ?? 0.0
        self.createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt) ?? ""
        self.updatedAt = try container.decodeIfPresent(String.self, forKey: .updatedAt) ?? ""
        self.user = try container.decode(UserModel.self, forKey: .user)
    }
}

class LocationModel: Codable {
    var houseNo: String
    var addressLine1: String
    var addressLine2: String
    var city: String
    var state: String
    var pincode: String
    var country: String
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.houseNo = try container.decodeIfPresent(String.self, forKey: .houseNo) ?? ""
        self.addressLine1 = try container.decodeIfPresent(String.self, forKey: .addressLine1) ?? ""
        self.addressLine2 = try container.decodeIfPresent(String.self, forKey: .addressLine2) ?? ""
        self.city = try container.decodeIfPresent(String.self, forKey: .city) ?? ""
        self.state = try container.decodeIfPresent(String.self, forKey: .state) ?? ""
        self.pincode = try container.decodeIfPresent(String.self, forKey: .pincode) ?? ""
        self.country = try container.decodeIfPresent(String.self, forKey: .country) ?? ""
    }
    init() {
        self.houseNo = ""
        self.addressLine1 = ""
        self.addressLine2 = ""
        self.city = ""
        self.state = ""
        self.pincode = ""
        self.country = ""
    }
}

class MealModel: Codable {
    var _id: String
    var name: String
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._id = try container.decode(String.self, forKey: ._id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
    }
}
