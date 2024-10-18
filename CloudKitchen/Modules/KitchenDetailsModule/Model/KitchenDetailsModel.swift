//
//  KitchenDetailsModel.swift
//  CloudKitchen
//
//  Created by E5000745 on 11/07/24.
//

import Foundation
@Observable
class KitchenDetailsModel: Codable {
    var _id: String
    var addresses: [String]
    var badges: [String]
    var closingHours: String
    var contact: [String]
    var description: String
    var discounts: [String]
    var availablePlans: [AvailablePlanModel]
    var images: [String]
    var location: LocationModel?
    var owner: UserModel?
    var searchTags: [String]
    var bannerImage: String
    var noOfRatings: Int
    var type: [String]
    var avgRating: Float
    var name: String
    var startingPrice: Float
    var status: String
    var thumbUrl: String
    var openingHours: String
    var paymentsAccepted: [String]
    var reviews: [ReviewModel]
    var meals: [MealModel]
    
    private enum CodingKeys: String, CodingKey {
        case _id
        case addresses
        case badges
        case closingHours
        case contact
        case description
        case discounts
        case availablePlans
        case images
        case location
        case owner
        case searchTags
        case bannerImage
        case noOfRatings
        case type
        case avgRating
        case name
        case startingPrice
        case status
        case thumbUrl
        case openingHours
        case paymentsAccepted
        case reviews
        case meals
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._id = try container.decode(String.self, forKey: ._id)
        self.addresses = try container.decodeIfPresent([String].self, forKey: .addresses) ?? []
        self.badges = try container.decodeIfPresent([String].self, forKey: .badges) ?? []
        self.closingHours = try container.decodeIfPresent(String.self, forKey: .closingHours) ?? ""
        self.contact = try container.decodeIfPresent([String].self, forKey: .contact) ?? []
        self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        self.discounts = try container.decodeIfPresent([String].self, forKey: .discounts) ?? []
        self.availablePlans = try container.decodeIfPresent([AvailablePlanModel].self, forKey: .availablePlans) ?? []
        self.images = try container.decodeIfPresent([String].self, forKey: .images) ?? []
        self.location = try container.decodeIfPresent(LocationModel.self, forKey: .location)
        self.owner = try container.decodeIfPresent(UserModel.self, forKey: .owner)
        self.searchTags = try container.decodeIfPresent([String].self, forKey: .searchTags) ?? []
        self.bannerImage = try container.decodeIfPresent(String.self, forKey: .bannerImage) ?? ""
        self.noOfRatings = try container.decodeIfPresent(Int.self, forKey: .noOfRatings) ?? 0
        self.type = try container.decodeIfPresent([String].self, forKey: .type) ?? []
        self.avgRating = try container.decodeIfPresent(Float.self, forKey: .avgRating) ?? 0
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.startingPrice = try container.decodeIfPresent(Float.self, forKey: .startingPrice) ?? 0
        self.status = try container.decodeIfPresent(String.self, forKey: .status) ?? ""
        self.thumbUrl = try container.decodeIfPresent(String.self, forKey: .thumbUrl) ?? ""
        self.openingHours = try container.decodeIfPresent(String.self, forKey: .openingHours) ?? ""
        self.paymentsAccepted = try container.decodeIfPresent([String].self, forKey: .paymentsAccepted) ?? []
        self.reviews = try container.decodeIfPresent([KitchenReviewModel].self, forKey: .reviews) ?? []
        self.meals = try container.decodeIfPresent([MealModel].self, forKey: .meals) ?? []
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self._id, forKey: ._id)
        try container.encode(self.addresses, forKey: .addresses)
        try container.encode(self.badges, forKey: .badges)
        try container.encode(self.closingHours, forKey: .closingHours)
        try container.encode(self.contact, forKey: .contact)
        try container.encode(self.description, forKey: .description)
        try container.encode(self.discounts, forKey: .discounts)
        try container.encode(self.availablePlans, forKey: .availablePlans)
        try container.encode(self.images, forKey: .images)
        try container.encode(self.location, forKey: .location)
        try container.encode(self.owner, forKey: .owner)
        try container.encode(self.searchTags, forKey: .searchTags)
        try container.encode(self.bannerImage, forKey: .bannerImage)
        try container.encode(self.noOfRatings, forKey: .noOfRatings)
        try container.encode(self.type, forKey: .type)
        try container.encode(self.avgRating, forKey: .avgRating)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.startingPrice, forKey: .startingPrice)
        try container.encode(self.status, forKey: .status)
        try container.encode(self.thumbUrl, forKey: .thumbUrl)
        try container.encode(self.openingHours, forKey: .openingHours)
        try container.encode(self.paymentsAccepted, forKey: .paymentsAccepted)
        try container.encode(self.reviews, forKey: .reviews)
        try container.encode(self.meals, forKey: .meals)
    }
}
@Observable
class AvailablePlanModel: Codable {
    var _id: String
    var name: String
    var description: String
    var noOfMeals: Int
    var type: String
    var features: [FeatureModel]
    
    var isSelected: Bool = false
    
    private enum CodingKeys: String, CodingKey {
        case _id
        case name
        case description
        case noOfMeals
        case type
        case features
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._id = try container.decode(String.self, forKey: ._id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        self.noOfMeals = try container.decodeIfPresent(Int.self, forKey: .noOfMeals) ?? 0
        self.type = try container.decodeIfPresent(String.self, forKey: .type) ?? ""
        self.features = try container.decodeIfPresent([FeatureModel].self, forKey: .features) ?? []
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self._id, forKey: ._id)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.description, forKey: .description)
        try container.encode(self.noOfMeals, forKey: .noOfMeals)
        try container.encode(self.type, forKey: .type)
        try container.encode(self.features, forKey: .features)
    }
}

class FeatureModel: Codable {
    var id: Int
    var title: String
    var description: String
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
    }
}

class RatingModel: Codable {
    var avgRating: Float
    var ratings: [Float]
    var noOfRatings: Int
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.avgRating = try container.decodeIfPresent(Float.self, forKey: .avgRating) ?? 0
        self.ratings = try container.decodeIfPresent([Float].self, forKey: .ratings) ?? []
        self.noOfRatings = try container.decodeIfPresent(Int.self, forKey: .noOfRatings) ?? 0
    }
}
