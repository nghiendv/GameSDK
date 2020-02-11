//
//  FacebookLogin.swift
//  LoginSocialSDK
//
//  Created by nghiendv on 1/10/20.
//  Copyright © 2020 nghiendv. All rights reserved.
//

import UIKit
import Foundation
import FBSDKCoreKit
import FBSDKLoginKit

class FacebookLogin {
    
    public static let shared = FacebookLogin()
    
    func fbLogin(viewController: UIViewController, completion: @escaping CompletionBlock) {
        
        LoginManager().logIn(permissions: ["public_profile", "email"], from: viewController) { (result, error) in
            if let error = error {
                completion(false, "", error as NSError)
            } else if result?.isCancelled ?? false {
                completion(false, "", NSError.errorWith(code: 0, message: String.internetConnectionLost))
            } else {
                completion(true, AccessToken.current?.tokenString ?? "", nil)
            }
        }
    }
    
    static func fbLogOut() {
        LoginManager().logOut()
    }
}
