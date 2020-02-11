//
//  GoogleLogin.swift
//  LoginSocialSDK
//
//  Created by nghiendv on 1/10/20.
//  Copyright © 2020 nghiendv. All rights reserved.
//

import UIKit
import Foundation
import GoogleSignIn

@objc public class GoogleLogin: UIViewController {
    
    public static let shared = GoogleLogin()
    var signInBlock: CompletionBlock?
    
    func googleSignIn(viewController: UIViewController, clientID: String, completion: @escaping CompletionBlock) {
        
        self.signInBlock = completion
        GIDSignIn.sharedInstance().clientID = clientID
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = viewController
//        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        GIDSignIn.sharedInstance().signIn()
    }
    
    static func googleSignOut() {
        GIDSignIn.sharedInstance().signOut()
    }
}

extension GoogleLogin: GIDSignInDelegate {
    
    @objc public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        if error == nil {
            if signInBlock != nil {
                self.signInBlock!(true, user.authentication.accessToken, nil)
            }
            
        } else {
            if signInBlock != nil {
                signInBlock!(false, "", error as NSError?)
            }
        }
    }
    
    @objc public func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        if signInBlock != nil {
            signInBlock!(false, "", error as NSError?)
        }
    }

}
