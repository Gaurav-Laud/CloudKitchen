//
//  MealDetailModel.swift
//  CloudKitchen
//
//  Created by E5000745 on 30/07/24.
//

import Foundation
class MealDetailModel: Codable {
    var _id: String
    var badges: [String]
    var category: String
    var description: String
    var images: [String]
    var ingredients: [String]
    var monthlyMenu: [String: [MenuItemModel]]
    var monthlySubscriptionCost: Double
    var name: String
    var price: Double
    var status: String
    var type: String
    var weeklyMenu: [MenuItemModel]
    var weeklySubscriptionCost: Double
    var avgRating: Float
    var noOfRatings: Int
    var bannerImage: String
    var updatedBy: String
    var kitchen: String
    var reviews: [MealReviewModel]
    private enum CodingKeys: String, CodingKey {
        case _id
        case badges
        case category
        case description
        case images
        case ingredients
        case monthlyMenu
        case monthlySubscriptionCost
        case name
        case price
        case status
        case type
        case weeklyMenu
        case weeklySubscriptionCost
        case avgRating
        case noOfRatings
        case bannerImage
        case updatedBy
        case kitchen
        case reviews
    }
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._id = try container.decodeIfPresent(String.self, forKey: ._id) ?? ""
        self.badges = try container.decodeIfPresent([String].self, forKey: .badges) ?? []
        self.category = try container.decodeIfPresent(String.self, forKey: .category) ?? ""
        self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        self.images = try container.decodeIfPresent([String].self, forKey: .images) ?? []
        self.ingredients = try container.decodeIfPresent([String].self, forKey: .ingredients) ?? []
        self.monthlyMenu = try container.decodeIfPresent([String : [MenuItemModel]].self, forKey: .monthlyMenu) ?? [:]
        self.monthlySubscriptionCost = try container.decodeIfPresent(Double.self, forKey: .monthlySubscriptionCost) ?? 0
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.price = try container.decodeIfPresent(Double.self, forKey: .price) ?? 0
        self.status = try container.decodeIfPresent(String.self, forKey: .status) ?? ""
        self.type = try container.decodeIfPresent(String.self, forKey: .type) ?? ""
        self.weeklyMenu = try container.decodeIfPresent([MenuItemModel].self, forKey: .weeklyMenu) ?? []
        self.weeklySubscriptionCost = try container.decodeIfPresent(Double.self, forKey: .weeklySubscriptionCost) ?? 0
        self.avgRating = try container.decodeIfPresent(Float.self, forKey: .avgRating) ?? 0
        self.noOfRatings = try container.decodeIfPresent(Int.self, forKey: .noOfRatings) ?? 0
        self.bannerImage = try container.decodeIfPresent(String.self, forKey: .bannerImage) ?? ""
        self.updatedBy = try container.decodeIfPresent(String.self, forKey: .updatedBy) ?? ""
        self.kitchen = try container.decodeIfPresent(String.self, forKey: .kitchen) ?? ""
        self.reviews = try container.decodeIfPresent([MealReviewModel].self, forKey: .reviews) ?? []
    }
}
class MenuItemModel: Codable {
    var id: Int
    var dayCount: Int
    var items: [String]
    var image: String
}
class MealReviewModel: ReviewModel {
    var mealId: String
    private enum CodingKeys: String, CodingKey {
        case mealId
    }
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.mealId = try container.decodeIfPresent(String.self, forKey: .mealId) ?? ""
        try super.init(from: decoder)
    }
}
