//
//  KitchenModel.swift
//  CloudKitchen
//
//  Created by E5000745 on 06/07/24.
//

import Foundation
class KitchenModel: Codable, Identifiable {
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
@Observable
class LocationModel: Codable, Identifiable {
    var houseNo: String
    var addressLine1: String
    var addressLine2: String
    var city: String
    var state: String
    var pincode: String
    var country: String
    var coordinates: (Double, Double)?
    var type: String?
    var fullName: String
    var phoneNumber: String
    private enum CodingKeys: String, CodingKey {
        case houseNo
        case addressLine1
        case addressLine2
        case city
        case state
        case pincode
        case country
        case type
        case fullName
        case phoneNumber
    }
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.houseNo = try container.decodeIfPresent(String.self, forKey: .houseNo) ?? ""
        self.addressLine1 = try container.decodeIfPresent(String.self, forKey: .addressLine1) ?? ""
        self.addressLine2 = try container.decodeIfPresent(String.self, forKey: .addressLine2) ?? ""
        self.city = try container.decodeIfPresent(String.self, forKey: .city) ?? ""
        self.state = try container.decodeIfPresent(String.self, forKey: .state) ?? ""
        self.pincode = try container.decodeIfPresent(String.self, forKey: .pincode) ?? ""
        self.country = try container.decodeIfPresent(String.self, forKey: .country) ?? ""
        self.type = try container.decodeIfPresent(String.self, forKey: .type) ?? ""
        self.fullName = try container.decodeIfPresent(String.self, forKey: .fullName) ?? ""
        self.phoneNumber = try container.decodeIfPresent(String.self, forKey: .phoneNumber) ?? ""
    }
    init() {
        self.houseNo = ""
        self.addressLine1 = ""
        self.addressLine2 = ""
        self.city = ""
        self.state = ""
        self.pincode = ""
        self.country = ""
        self.type = ""
        self.fullName = ""
        self.phoneNumber = ""
    }
    init(houseNo: String = "", addressLine1: String = "", addressLine2: String = "", city: String = "", state: String = "", pincode: String = "", country: String = "", type: String = "", fullName: String = "", phoneNumber: String = "") {
        self.houseNo = houseNo
        self.addressLine1 = addressLine1
        self.addressLine2 = addressLine2
        self.city = city
        self.state = state
        self.pincode = pincode
        self.country = country
        self.type = type
        self.fullName = fullName
        self.phoneNumber = phoneNumber  
    }
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.houseNo, forKey: .houseNo)
        try container.encode(self.addressLine1, forKey: .addressLine1)
        try container.encode(self.addressLine2, forKey: .addressLine2)
        try container.encode(self.city, forKey: .city)
        try container.encode(self.state, forKey: .state)
        try container.encode(self.pincode, forKey: .pincode)
        try container.encode(self.country, forKey: .country)
        try container.encode(self.type, forKey: .type)
        try container.encode(self.fullName, forKey: .fullName)
        try container.encode(self.phoneNumber, forKey: .phoneNumber)
    }
}

@Observable
class MealModel: Codable, Identifiable {
    var _id: String
    var name: String
    var description: String
    var badges: [String]
    var images: [String]
    var price: Float
    var weeklySubscriptionCost: Float
    var monthlySubscriptionCost: Float
    var ratingModel: RatingModel?
    var isAdded: Bool = false
    private enum CodingKeys: String, CodingKey {
        case _id
        case name
        case description
        case badges
        case images
        case price
        case weeklySubscriptionCost
        case monthlySubscriptionCost
        case ratingModel = "rating"
    }
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._id = try container.decode(String.self, forKey: ._id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        self.badges = try container.decodeIfPresent([String].self, forKey: .badges) ?? []
        self.images = try container.decodeIfPresent([String].self, forKey: .images) ?? []
        self.price = try container.decodeIfPresent(Float.self, forKey: .price) ?? 0
        self.weeklySubscriptionCost = try container.decodeIfPresent(Float.self, forKey: .weeklySubscriptionCost) ?? 0
        self.monthlySubscriptionCost = try container.decodeIfPresent(Float.self, forKey: .monthlySubscriptionCost) ?? 0
        self.ratingModel = try container.decodeIfPresent(RatingModel.self, forKey: .ratingModel)
    }
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self._id, forKey: ._id)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.description, forKey: .description)
        try container.encode(self.badges, forKey: .badges)
        try container.encode(self.images, forKey: .images)
        try container.encode(self.price, forKey: .price)
        try container.encode(self.weeklySubscriptionCost, forKey: .weeklySubscriptionCost)
        try container.encode(self.monthlySubscriptionCost, forKey: .monthlySubscriptionCost)
        try container.encode(self.ratingModel, forKey: .ratingModel)
        try container.encode(self._id, forKey: ._id)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.description, forKey: .description)
        try container.encode(self.badges, forKey: .badges)
    }
}
