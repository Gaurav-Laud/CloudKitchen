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
    private var paymentResponceCallback: ((Result<String, Error>) -> Void) = { _ in }
    func startPayment(for orderId: String, amount: Int, callback: @escaping ((Result<String, Error>) -> Void)) {
        let razorPay = RazorpayCheckout.initWithKey(razorPayKey, andDelegate: self)
        self.paymentResponceCallback = callback
        let options: [String:Any] = [
                "name": "Razorpay Corp",
                "description": "Demoing Charges",
                "image": "https://s3.amazonaws.com/rzp-mobile/images/rzp.pn",
                "theme": ["color": "#3399cc"],
                "currency": "INR",
                "order_id": orderId,
                "amount": amount, // Amount is in currency subunits, e.g., for ₹100 pass 10000
                "prefill": [
                    "email": "madhurao527@gmail.com",
                    "contact": "6300592930"
                ]
            ]
        razorPay.open(options)
    }
}

extension RazorPayUtility: RazorpayPaymentCompletionProtocol {
    func onPaymentError(_ code: Int32, description str: String) {
        print("payment failure: \(code) - \(str)")
        self.paymentResponceCallback(.failure(NSError(domain: "", code: Int(code), userInfo: ["desc": str])))
    }
    
    func onPaymentSuccess(_ payment_id: String) {
        print("Payment success: \(payment_id)")
        self.paymentResponceCallback(.success(payment_id))
    }
}
