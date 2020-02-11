//
//  SocialStruct.swift
//  LoginSocialSDK
//
//  Created by nghiendv on 1/10/20.
//  Copyright © 2020 nghiendv. All rights reserved.
//

import UIKit
import Foundation

public extension Notification.Name {
    static let IAPHelperPurchaseNotification = Notification.Name("IAPHelperPurchaseNotification")
    static let IAPHelperPurchaseSuccessNotification = Notification.Name("IAPHelperPurchaseSuccessNotification")
    static let IAPHelperPurchaseFailNotification = Notification.Name("IAPHelperPurchaseFailNotification")
}

public struct SocialUserDetails {
    public var userId: String = ""
    public var type: SocialLoginType = .google
    public var name: String = ""
    public var email: String = ""
    public var profilePic: String = ""
}

public enum SocialLoginType: String {
    case google = "google"
    case facebook = "facebook"
}
