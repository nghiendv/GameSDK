//
//  Login.swift
//  LoginSocialSDK
//
//  Created by Đào Văn Nghiên on 2/7/20.
//  Copyright © 2020 nghiendv. All rights reserved.
//

import UIKit
import SwiftyJSON
import Foundation
import FBSDKCoreKit
import FBSDKLoginKit

public class Login {
    
    public static let shared = Login()
    var serviceAgent = APIServiceAgent()
    
    public class func login(type: SocialLoginType, clientID: String = "", viewController: UIViewController, completion: @escaping(String, NSError?) -> Void) {
        switch type {
            case .facebook:
                FacebookLogin.shared.fbLogin(viewController: viewController) { (isSuccess, result, login_error) in
                    if isSuccess {
                        let request = APIRequestProvider.shareInstance.login(loginType: .facebook, accessToken: result)
                        self.shared.serviceAgent.startRequest(request) { (_ json: JSON, _ error: NSError?) in
                            if error == nil {
                                completion(json["user_id"].stringValue, nil)
                            } else {
                                completion("", error)
                            }
                        }
                    } else {
                        completion("", login_error)
                    }
                }
            case .google:
                GoogleLogin.shared.googleSignIn(viewController: viewController, clientID: clientID) { (isSuccess, result, login_error)  in
                    if isSuccess {
                        let request = APIRequestProvider.shareInstance.login(loginType: .google, accessToken: result)
                        self.shared.serviceAgent.startRequest(request) { (_ json: JSON, _ error: NSError?) in
                            if error == nil {
                                completion("\(json["user_id"])", nil)
                            } else {
                                completion("", error)
                            }
                        }
                    } else {
                        completion("", login_error)
                    }
                }
        }
    }

    public class func logout(type: SocialLoginType) {
        switch type {
        case .facebook:
            FacebookLogin.fbLogOut()
        case .google:
            GoogleLogin.googleSignOut()
        default:
            break
        }
    }
    
    

}

