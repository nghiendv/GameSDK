//
//  PaymentService.swift
//  LoginSocialSDK
//
//  Created by nghiendv on 2/8/20.
//  Copyright © 2020 nghiendv. All rights reserved.
//

import UIKit
import SwiftyJSON
import Foundation

public class PaymentService {
    
    public static let shared = PaymentService()
    var serviceAgent = APIServiceAgent()
    var paymentBlock: CompletionBlock?
    var userId: String?
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.handlePaymentResult(_:)), name: .IAPHelperPurchaseSuccessNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.handlePaymentFail(_:)), name: .IAPHelperPurchaseFailNotification, object: nil)
    }
    
    @objc func handlePaymentFail(_ notification: Notification) {
        guard let message = notification.object as? String else { return }
        paymentBlock?(false, message, nil)
    }
    
    @objc func handlePaymentResult(_ notification: Notification) {
        guard let receiptID = notification.object as? String else { return }
        self.saveTransation(receiptId: receiptID, purchaseType: .item, userId: self.userId ?? "") { (isSaveTransationSuccess, saveTransationResult, saveTransationError) in
        }
        paymentBlock?(true, "Payment Success", nil)
    }
    
    public class func purchaseProduct(productId: String, userId: String, completion: @escaping CompletionBlock) {
        
        let store = IAPHelper(productIds: [])
        self.shared.checkUser(userId: userId) { (isCheckUserSuccess, checkUserResult, checkUserError) in
            if (isCheckUserSuccess) {
                store.requestProduct(productId) { (isRequestSuccess, products) in
                    if isRequestSuccess {
                        if let product = products?.first {
                            self.shared.userId = userId
                            self.shared.paymentBlock = completion
                            store.buyProduct(product)
                        } else {
                            completion(false, "No product", nil)
                        }
                    } else {
                        completion(isRequestSuccess, "No product", nil)
                    }
                }
            } else {
                completion(isCheckUserSuccess, checkUserResult, checkUserError)
            }
        }
    }
    
    func checkUser(userId: String, completion: @escaping CompletionBlock) {
        let request = APIRequestProvider.shareInstance.checkRefund(userId: userId)
        PaymentService.shared.serviceAgent.startRequest(request) { (_ json: JSON, _ error: NSError?) in
            if error == nil {
                let isBlocked = json["is_blocked"].intValue
                if isBlocked == 0 {
                    completion(true, json["message"].stringValue, error)
                } else {
                    completion(false, json["message"].stringValue, error)
                }
            } else {
                completion(false, "", error)
            }
        }
    }
    
    func saveTransation(receiptId: String, purchaseType: PaymentType, userId: String, completion: @escaping CompletionBlock) {
        let request = APIRequestProvider.shareInstance.saveReceipt(userId: userId, receiptId: receiptId, paymentType: purchaseType)
        PaymentService.shared.serviceAgent.startRequest(request) { (_ json: JSON, _ error: NSError?) in
            if error == nil {
                completion(true, json["receipt_id"].stringValue, error)
            } else {
                completion(false, json["message"].stringValue, error)
            }
        }
    }
    
}
