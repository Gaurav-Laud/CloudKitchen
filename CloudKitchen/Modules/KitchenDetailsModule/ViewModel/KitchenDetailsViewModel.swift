//
//  KitchenDetailsViewModel.swift
//  CloudKitchen
//
//  Created by E5000745 on 10/07/24.
//

import Foundation
class KitchenDetailsViewModel: ObservableObject {
    @Published var kitchenModel: KitchenModel?
    @Published var kitchenDetailsModel: KitchenDetailsModel?
    
    func fetchKitchenDetails(with kitchenId: String) {
        let url = "https://whale-app-ct2dl.ondigitalocean.app/kitchens/\(kitchenId)"
        Task { @MainActor [weak self] in
            guard let self = self else { return }
            do {
                let kitchenDetailsModel = try await APIHandler.shared.makeFetchAPICall(KitchenDetailsModel.self, url: url)
                self.fetchKitchensDetailsSuccessResponse(kitchenDetailsModel: kitchenDetailsModel)
            } catch {
                print("error while fetching kitchen details: \(error)")
            }
        }
    }
    private func fetchKitchensDetailsSuccessResponse(kitchenDetailsModel: KitchenDetailsModel) {
        self.convertImageUrls(for: kitchenDetailsModel)
        self.setupDefaultValues(kitchenDetailsModel: kitchenDetailsModel)
        self.kitchenDetailsModel = kitchenDetailsModel
    }
    private func convertImageUrls(for kitchenDetailsModel: KitchenDetailsModel) {
        kitchenDetailsModel.bannerImage = kitchenDetailsModel.bannerImage.replacingOccurrences(of: "http:", with: "https:")
        let images = kitchenDetailsModel.images.map({ $0.replacingOccurrences(of: "http:", with: "https:") })
        kitchenDetailsModel.images = images
        kitchenDetailsModel.meals.forEach({
            let mealImages = $0.images.map({ $0.replacingOccurrences(of: "http:", with: "https:") })
            $0.images = mealImages
        })
    }
    private func setupDefaultValues(kitchenDetailsModel: KitchenDetailsModel) {
        kitchenDetailsModel.meals.first?.isAdded = true
    }
    func selectMeal(with id: String) {
        kitchenDetailsModel?.meals.forEach({ $0.isAdded = $0._id == id })
    }
}
