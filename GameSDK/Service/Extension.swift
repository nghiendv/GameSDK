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

enum LoginType: Int {
    case facebook   = 1
    case google     = 2
    case your_id    = 3
    case device_id  = 4
    
    func stringValue() -> String {
        switch self {
            case .facebook:
                return "1"
            case .google:
                return "2"
            case .your_id:
                return "3"
            case .device_id:
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