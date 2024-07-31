//
//  KitchenDetailsModel.swift
//  CloudKitchen
//
//  Created by E5000745 on 11/07/24.
//

import Foundation
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
}

class AvailablePlanModel: Codable {
    var _id: String
    var name: String
    var description: String
    var noOfMeals: Int
    var type: String
    var features: [FeatureModel]
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._id = try container.decode(String.self, forKey: ._id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        self.noOfMeals = try container.decodeIfPresent(Int.self, forKey: .noOfMeals) ?? 0
        self.type = try container.decodeIfPresent(String.self, forKey: .type) ?? ""
        self.features = try container.decodeIfPresent([FeatureModel].self, forKey: .features) ?? []
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
