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
    
    func fetchKitchens() {
        Task {
            do {
                self.kitchenModels = try await APIHandler.shared.makeFetchAPICall([KitchenModel].self, url: "https://whale-app-ct2dl.ondigitalocean.app/kitchens")
                print("^^ \(self.kitchenModels.count)")
            } catch {
                print("error while fetching kitchens: \(error)")
            }
        }
    }
}
