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
                self.kitchenDetailsModel = try await APIHandler.shared.makeFetchAPICall(KitchenDetailsModel.self, url: url)
            } catch {
                print("error while fetching kitchen details: \(error)")
            }
        }
    }
}
