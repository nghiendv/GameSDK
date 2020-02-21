//
//  Extension.swift
//  LoginSocialSDK
//
//  Created by Đào Văn Nghiên on 2/7/20.
//  Copyright © 2020 nghiendv. All rights reserved.
//

import UIKit
import Foundation

public typealias CompletionBlock = (Bool, String, NSError?) -> Void

enum APIErrorCode: Int {
    case success        = 2000
    case fail           = 201
    case invalidToken1  = 401
    case invalidToken   = 403
    case notExist       = 404
    case needMapNumber  = 440
    case notRegisted    = 900
    case downgrade      = 909
    case needCaptcha    = 800
    case invalidCaptcha = 808
    case userInactive   = 888
    case unknow         = 99999
}

public enum LoginType: Int {
    case facebook   = 1
    case google     = 2
    case deviceId   = 3
    case yourId     = 4
    
    func stringValue() -> String {
        switch self {
            case .facebook:
                return "1"
            case .google:
                return "2"
            case .deviceId:
                return "3"
            case .yourId:
                return "4"
        }
    }
}

enum PaymentType: Int {
    case item           = 1
    case subscription   = 2
    
    func stringValue() -> String {
        switch self {
            case .item:
                return "1"
            case .subscription:
                return "2"
        }
    }
}

public extension Notification.Name {
    static let IAPHelperPurchaseNotification = Notification.Name("IAPHelperPurchaseNotification")
    static let IAPHelperPurchaseSuccessNotification = Notification.Name("IAPHelperPurchaseSuccessNotification")
    static let IAPHelperPurchaseFailNotification = Notification.Name("IAPHelperPurchaseFailNotification")
}

public struct SocialUserDetails {
    public var userId: String = ""
    public var type: LoginType = .google
    public var name: String = ""
    public var email: String = ""
    public var profilePic: String = ""
}

extension NSError {
    public static func errorWith(code errorCode: Int, message errorMessage: String) -> NSError {
        return NSError.init(domain: "GameSdk", code: errorCode,
                            userInfo: [NSLocalizedDescriptionKey: errorMessage])
    }

}

extension String {
//mark: - Common
    static var internetConnectionLost: String { return NSLocalizedString("InternetConnectLost", comment: "")}
}
