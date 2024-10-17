//
//  RazorPayUtility.swift
//  CloudKitchen
//
//  Created by E5000745 on 24/08/24.
//

import Foundation
import Razorpay
class RazorPayUtility {
    static let shared: RazorPayUtility = RazorPayUtility()
    private let razorPayKey = "rzp_test_CLECjNaCmPM9pH"
    private var paymentResponceCallback: ((Result<[String: String], Error>) -> Void) = { _ in }
    func startPayment(for orderId: String, amount: Int, callback: @escaping ((Result<[String: String], Error>) -> Void)) {
        let razorPay = RazorpayCheckout.initWithKey(razorPayKey, andDelegate: self)
        self.paymentResponceCallback = callback
        let options: [String:Any] = [
                "name": "Razorpay Corp",
                "description": "Demoing Charges",
                "image": "https://s3.amazonaws.com/rzp-mobile/images/rzp.pn",
                "theme": ["color": "#3399cc"],
                "currency": "INR",
                "order_id": orderId,
                "amount": "\(amount * 100)", // Amount is in currency subunits, e.g., for ₹100 pass 10000
                "prefill": [
                    "email": "madhurao527@gmail.com",
                    "contact": "6300592930"
                ]
            ]
        razorPay.open(options)
    }
}

extension RazorPayUtility: RazorpayResultProtocol {
    func onComplete(response: [AnyHashable : Any]) {
        print("Payment completed with response: \(response)")
        guard let response = response as? [String: Any] else {
            self.paymentResponceCallback(.failure(DecodingError.typeMismatch(String.self, .init(codingPath: [], debugDescription: ""))))
            return
        }
        if let statusCode = response["http_status_code"] as? Int, !(200..<300).contains(statusCode) {
            self.paymentResponceCallback(.failure(URLError(URLError.Code(rawValue: statusCode))))
        } else if let response = response as? [String: String] {
            self.paymentResponceCallback(.success(response))
        }
    }
}
