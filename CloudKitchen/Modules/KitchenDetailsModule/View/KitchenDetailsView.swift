//
//  KitchenDetailsView.swift
//  CloudKitchen
//
//  Created by E5000745 on 10/07/24.
//

import SwiftUI

struct KitchenDetailsView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var kitchenDetailsViewModel = KitchenDetailsViewModel()
    init(kitchenModel: KitchenModel? = nil) {
        self.kitchenDetailsViewModel.kitchenModel = kitchenModel
    }
    var body: some View {
        VStack {
            self.getTopView()
            self.getKitchenTypeView()
            self.getMealListView()
            self.getBottomButton()
        }
        .toolbar { getToolbarView() }
        .toolbar(.visible, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
        .navigationBarBackButtonHidden()
        .onAppear(perform: {
            kitchenDetailsViewModel.fetchKitchenDetails(with: kitchenDetailsViewModel.kitchenModel?._id ?? "")
        })
    }
    @ToolbarContentBuilder
    private func getToolbarView() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button(action: { dismiss() }, label: {
                Label("", systemImage: Constants.chevron_left)
            })
            .tint(.black)
        }
    }
    @ViewBuilder
    private func getTopView() -> some View {
        VStack(spacing: 7.0) {
            CloudLabel(text: kitchenDetailsViewModel.kitchenModel?.name ?? "", font: .largeTitle, fontWeight: .bold)
            CloudLabel(text: kitchenDetailsViewModel.kitchenModel?.description ?? "", font: .body, textColor: .secondary, textAlignment: .center)
                .padding(.horizontal)
//            CloudLabel(text: "Breakfast | Lunch | Dinner", font: .body, textColor: .yellow, textAlignment: .center)
            /*HStack(content: {
                Spacer()
                CloudLabel(text: "35-40 mins", font: .footnote, textColor: .secondary)
                Spacer()
                CloudLabel(text: "10Km", font: .footnote, textColor: .secondary)
                Spacer()
            })*/
        }
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(radius: 5)
    }
    @ViewBuilder
    private func getKitchenTypeView() -> some View {
        HStack {
            ForEach(kitchenDetailsViewModel.kitchenDetailsModel?.type ?? [], id: \.self) { type in
                self.getTypeLabel(type)
            }
            Spacer()
        }
        .padding()
    }
    @ViewBuilder
    private func getTypeLabel(_ type: String) -> some View {
        let title = type == "veg" ? Constants.veg : Constants.non_veg
        let imageName = type == "veg" ? Constants.veg_symbol : Constants.non_veg_symbol
        Label(title, image: ImageResource(name: imageName, bundle: Bundle.main))
            .font(.caption)
            .padding(5)
            .background(.white)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
    @ViewBuilder
    private func getBottomButton() -> some View {
        let title = kitchenDetailsViewModel.kitchenDetailsModel?.meals.first(where: { $0.isAdded })?.name ?? ""
        Button(action: { }, label: {
            HStack {
                Text(title)
                Spacer()
                Text(Constants.view_plan)
                Image(systemName: Constants.arrow_right)
            }
                .padding()
                .frame(maxWidth: .infinity)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .background(.yellow)
                .clipShape(.rect(cornerRadius: 6))
        })
        .padding()
    }
    @ViewBuilder
    func getMealListView() -> some View {
        List(kitchenDetailsViewModel.kitchenDetailsModel?.meals ?? []) { meal in
            MealCardView(mealModel: meal)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                .onTapGesture(perform: { kitchenDetailsViewModel.selectMeal(with: meal._id) })
        }
        .listStyle(.inset)
        .scrollIndicators(.never)
    }
}

#Preview {
    KitchenDetailsView()
}
