//
//  OrderConfirmationViewModel.swift
//  CloudKitchen
//
//  Created by E5000745 on 23/08/24.
//

import Foundation
protocol OrderConfirmationViewModelDelegate {
    func placeOrderSuccessReponce()
    func placeOrderFailureReponce()
}
@Observable
class OrderConfirmationViewModel {
    var kitchenModel: KitchenModel?
    var mealDetailModel: MealDetailModel?
    var reviewOrderModel: ReviewOrderModel?
    func getSubscriptionCost() -> Double {
        mealDetailModel?.selectedSubscriptionType == .weekly ? mealDetailModel?.weeklySubscriptionCost ?? 0.0 : mealDetailModel?.monthlySubscriptionCost ?? 0.0
    }
    func getDeliveryCost() -> Double {
        0.0
    }
    func getTotalCost() -> Double {
        reviewOrderModel?.grandTotal ?? 0
    }
    func getMealCount() -> Int {
        self.kitchenModel?.kitchenDetailsModel?.availablePlans.filter({ $0.isSelected }).first?.noOfMeals ?? 0
    }
    func postOrder(with response: [String: String]) {
        Task { @MainActor [weak self] in
            guard let self = self else { return }
            do {
                let response = try await APIHandler.shared.makePostAPICall([String: String].self, url: "https://whale-app-ct2dl.ondigitalocean.app/orders", parameters: self.getOrderData(for: response))
                print("response of post call: \(response)")
            } catch {
                print("error while fetching kitchens: \(error)")
            }
        }
    }
    private func getOrderData(for response: [String: String]) -> [String: Any]? {
        guard let kitchenModel = self.kitchenModel,
              let mealDetailModel = self.mealDetailModel,
              let address = UserDefaultsUtility.getSelectedAddress(),
              let userId = UserDefaultsUtility.getUser()?.id,
              let planId = self.kitchenModel?.kitchenDetailsModel?.availablePlans.filter({ $0.isSelected }).first?._id,
              let reviewOrderModel = reviewOrderModel,
              let startDate = mealDetailModel.startDate,
              let endDate = mealDetailModel.endDate
        else { return nil }
        let parameters: [String: Any] = [
            "user": userId,
            "kitchen": kitchenModel._id,
            "meal": mealDetailModel._id,
            "plan": planId,
            "status": "PLACED",
            "deliveryInstructions": "Adding sample data : ",
            //            "couponCode": "string",
            "paymentType": "UPI",
            "savedAmount": reviewOrderModel.savedAmount,
            "totalAmount": reviewOrderModel.totalAmount,
            "deliveryCharges": 0,
            "grandTotal": reviewOrderModel.grandTotal,
            "deliveryAddress": [
                "houseNo": address.houseNo,
                "addressLine1": address.addressLine1,
                "addressLine2": address.addressLine2,
                "city": address.city,
                "state": address.state,
                "pincode": address.pincode,
                "country": address.country,
                "type": address.type,
                "fullName": address.fullName,
                "phoneNumber": address.phoneNumber
            ],
            "isPaymentDone": true,
            "planStartDate": startDate,
            "planEndDate": endDate,
            "deliveryTimeSlot": mealDetailModel.slot?.startTime ?? "",
            "paymentInfo": [
                "razorpay_payment_id": response["razorpay_payment_id"],
                "razorpay_order_id": response["razorpay_order_id"],
                "razorpay_signature": response["razorpay_signature"]
            ]
        ]
        return parameters
    }
    private func getOrderId() async -> String? {
        guard let reviewOrderModel = reviewOrderModel else { return nil }
        let parameters: [String: Any] = [
            "amount": Int(reviewOrderModel.grandTotal * 100),
            "currency": "INR"
        ]
        var orderId: String? = nil
        do {
            let responce = try await APIHandler.shared.makePostAPICall(OrderIdModel.self, url: "https://whale-app-ct2dl.ondigitalocean.app/orders/generateOrderId", parameters: parameters)
            orderId = responce?.id
        } catch {
            print("Error while creating Order ID: \(error)")
        }
        return orderId
    }
    func startPayment() {
        Task { [weak self] in
            guard let self = self, let orderId = await self.getOrderId(), self.getTotalCost().isFinite else { return }
            RazorPayUtility.shared.startPayment(for: orderId, amount: Int(self.getTotalCost())) { result in
                switch result {
                case .success(let response):
                    self.postOrder(with: response)
                case .failure(let error):
                    print("error while executing payment: \(error)")
                }
            }
        }
    }
    func fetchOrder() {
        Task { [weak self] in
            guard let self = self else { return }
            guard let mealId = self.mealDetailModel?._id, let planId = self.kitchenModel?.kitchenDetailsModel?.availablePlans.filter({ $0.isSelected }).first?._id else { return }
            guard let startDate = self.mealDetailModel?.slot?.startTime, let endDate = mealDetailModel?.slot?.endTime else { return }
            do {
                let urlString =  "https://whale-app-ct2dl.ondigitalocean.app/orders/processOrder" + "?planId=\(planId)&mealId=\(mealId)&startDate\(startDate)&endDate=\(endDate)"
                self.reviewOrderModel = try await APIHandler.shared.makeFetchAPICall(ReviewOrderModel.self, url: urlString)
            } catch {
                print("Error while processing order: \(error)")
            }
        }
    }
}
