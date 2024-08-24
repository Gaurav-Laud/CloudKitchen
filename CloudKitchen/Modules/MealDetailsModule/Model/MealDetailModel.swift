//
//  MealDetailModel.swift
//  CloudKitchen
//
//  Created by E5000745 on 30/07/24.
//

import Foundation
enum SubscriptionType: String {
    case weekly
    case monthly
}
@Observable
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
    
    var selectedSubscriptionType: SubscriptionType = .weekly
    var slot: SlotModel?
    
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
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self._id, forKey: ._id)
        try container.encode(self.badges, forKey: .badges)
        try container.encode(self.category, forKey: .category)
        try container.encode(self.description, forKey: .description)
        try container.encode(self.images, forKey: .images)
        try container.encode(self.ingredients, forKey: .ingredients)
        try container.encode(self.monthlyMenu, forKey: .monthlyMenu)
        try container.encode(self.monthlySubscriptionCost, forKey: .monthlySubscriptionCost)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.price, forKey: .price)
        try container.encode(self.status, forKey: .status)
        try container.encode(self.type, forKey: .type)
        try container.encode(self.weeklyMenu, forKey: .weeklyMenu)
        try container.encode(self.weeklySubscriptionCost, forKey: .weeklySubscriptionCost)
        try container.encode(self.avgRating, forKey: .avgRating)
        try container.encode(self.noOfRatings, forKey: .noOfRatings)
        try container.encode(self.bannerImage, forKey: .bannerImage)
        try container.encode(self.updatedBy, forKey: .updatedBy)
        try container.encode(self.kitchen, forKey: .kitchen)
        try container.encode(self.reviews, forKey: .reviews)
    }
}
class MenuItemModel: Codable {
    var id: Int
    var dayCount: Int
    var items: [String]
    var image: String
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.dayCount = try container.decodeIfPresent(Int.self, forKey: .dayCount) ?? 0
        let items = try container.decodeIfPresent([String?].self, forKey: .items) ?? []
        self.image = try container.decodeIfPresent(String.self, forKey: .image) ?? ""
        self.items = items.compactMap({ $0 })
    }
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
