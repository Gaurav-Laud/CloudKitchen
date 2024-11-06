//
//  HomeViewModel.swift
//  CloudKitchen
//
//  Created by E5000745 on 06/07/24.
//

import Foundation
class HomeViewModel: ObservableObject {
    @Published var searchString: String = ""
    @Published var kitchenModels: [KitchenModel] = []
    @Published var selectedAddress: LocationModel?
    @Published var displayKitchenModels: [KitchenModel] = []
    
    func fetchKitchens() {
        Task { @MainActor [weak self] in
            guard let self = self else { return }
            do {
                let kitchenModels = try await APIHandler.shared.makeFetchAPICall([KitchenModel].self, url: "https://whale-app-ct2dl.ondigitalocean.app/kitchens")
                self.fetchKitchensSuccessResponse(kitchenModels: kitchenModels)
            } catch {
                print("error while fetching kitchens: \(error)")
            }
        }
    }
    private func fetchKitchensSuccessResponse(kitchenModels: [KitchenModel]) {
        self.kitchenModels = kitchenModels
        self.convertImageUrls(for: kitchenModels)
        self.updateDisplayModels()
    }
    private func convertImageUrls(for kitchenModels: [KitchenModel]) {
        kitchenModels.forEach({
            $0.bannerImage = $0.bannerImage.replacingOccurrences(of: "http:", with: "https:")
            let images = $0.images.map({ $0.replacingOccurrences(of: "http:", with: "https:")})
            $0.images = images
        })
    }
    func getSearchResults(for searchTerm: String) -> [KitchenModel] {
        guard !searchTerm.isEmpty else { return kitchenModels }
        return kitchenModels.filter({ $0.name.localizedCaseInsensitiveContains(searchTerm) })
    }
    func updateDisplayModels() {
        self.displayKitchenModels = self.getSearchResults(for: self.searchString)
    }
}
