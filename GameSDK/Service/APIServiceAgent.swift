//
//  APIServiceAgent.swift
//  LoginSocialSDK
//
//  Created by Đào Văn Nghiên on 2/7/20.
//  Copyright © 2020 nghiendv. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CFNetwork

/*
 *  APIServiceAgent takes responsible for
 *  - Convert DataResponse<Any> to JSON object
 *  - Detect and handle application errors such as: token expired, version not support...
 */

let statusCodeSuccess   = "success"
let statusCodeFail      = "fail"

class APIServiceAgent: NSObject {
    /*
     *  perform request
     *  param:
     *  - request: DataRequest
     *  - completion block (JSON, NSError?)
     */
    func startRequestBase(_ request: DataRequest, completion: @escaping(String, NSError?) -> Void) {
        request
            .validate()
            .responseString { response in
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        completion(data, nil)
                    }
                    
                case .failure(let error as NSError):
                    completion("", error)
                    break
                }
        }
    }
    
    func startRequest(_ request: DataRequest, completion: @escaping(JSON, NSError?) -> Void) {
        request
            .validate()
            .responseJSON { (_ response: DataResponse<Any>) in
                switch response.result {
                case .success:
                    let json            = JSON(response.result.value!)
                    let message         = json["message"].stringValue
                    let responseCode    = json["code"].intValue
                    
                    if responseCode == APIErrorCode.success.rawValue {
                        completion(json["data"] as JSON, nil)
                    } else if responseCode == APIErrorCode.invalidToken.rawValue {
                        let error = NSError.errorWith(code: responseCode, message: message)
                        completion(json, error)
                    } else {
                        let error = NSError.errorWith(code: responseCode, message: message)
                        completion(json, error)
                    }
                    break
                case .failure(let error as NSError):
                    if error.code == NSURLErrorNotConnectedToInternet || error.code == NSURLErrorNetworkConnectionLost {
                        let error = NSError.errorWith(code: error.code, message: String.internetConnectionLost)
                        completion(JSON.null, error)
                    } else if error.code == NSURLErrorCancelled {
                        completion(JSON.null, NSError.errorWith(code: error.code, message: String.internetConnectionLost))
                    } else {
                        completion(JSON.null, error)
                    }
                    break
                default:
                    break
                }
        }
    }
    
    func startRequestSearch(_ request: DataRequest, completion: @escaping(JSON, NSError?) -> Void) {
        request
            .validate()
            .responseJSON { (_ response: DataResponse<Any>) in
                switch response.result {
                case .success:
                    let json            = JSON(response.result.value!)
                    let message         = json["message"].stringValue
                    let responseCode    = json["code"].intValue
                    
                    if responseCode == APIErrorCode.success.rawValue {
                        let extraData = json["extraData"]
                        if extraData != nil  {
                            let error = NSError.errorWith(code: 888888, message: "")
                            completion(extraData["recommendData"] as JSON, error)
                        } else  {
                            completion(json["data"] as JSON, nil)
                        }
                    } else if responseCode == APIErrorCode.invalidToken.rawValue {
                        let error = NSError.errorWith(code: responseCode, message: message)
                        completion(json, error)
                    } else {
                        let error = NSError.errorWith(code: responseCode, message: message)
                        completion(json, error)
                    }
                    break
                case .failure(let error as NSError):
                    if error.code == NSURLErrorNotConnectedToInternet || error.code == NSURLErrorNetworkConnectionLost {
                        let error = NSError.errorWith(code: error.code, message: String.internetConnectionLost)
                        completion(JSON.null, error)
                    } else if error.code == NSURLErrorCancelled {
                        completion(JSON.null, NSError.errorWith(code: error.code, message: String.internetConnectionLost))
                    } else {
                        completion(JSON.null, error)
                    }
                    break
                default:
                    break
                }
        }
    }
    
    func startRequestPromotion(_ request: DataRequest, completion: @escaping(JSON, NSError?) -> Void) {
        request
            .validate()
            .responseJSON { (_ response: DataResponse<Any>) in
                switch response.result {
                case .success:
                    let json            = JSON(response.result.value!)
                    let message         = json["message"].stringValue
                    let responseCode    = json["code"].intValue
                    
                    if responseCode == APIErrorCode.success.rawValue {
                        completion(json, nil)
                    } else if responseCode == APIErrorCode.invalidToken.rawValue {
                        let error = NSError.errorWith(code: responseCode, message: message)
                        completion(json, error)
                    } else {
                        let error = NSError.errorWith(code: responseCode, message: message)
                        completion(json, error)
                    }
                    break
                case .failure(let error as NSError):
                    if error.code == NSURLErrorNotConnectedToInternet || error.code == NSURLErrorNetworkConnectionLost {
                        let error = NSError.errorWith(code: error.code, message: String.internetConnectionLost)
                        completion(JSON.null, error)
                    } else if error.code == NSURLErrorCancelled {
                        completion(JSON.null, NSError.errorWith(code: error.code, message: String.internetConnectionLost))
                    } else {
                        completion(JSON.null, error)
                    }
                    break
                default:
                    break
                }
        }
    }
    
    /*
     *  Manhhx: Them phan tra ve is_confirm_sms
     *  perform request
     *  param:
     *  - request: DataRequest
     *  - completion block (JSON, NSError?)
     */
    func startRequestWithConfirmSMS(_ request: DataRequest, completion: @escaping(JSON, NSError?) -> Void) {
        request
            .validate()
            .responseJSON { (_ response: DataResponse<Any>) in
                switch response.result {
                case .success:
                    let json            = JSON(response.result.value!)
                    let message         = json["message"].stringValue
                    let responseCode    = json["code"].intValue
                    
                    if responseCode == APIErrorCode.success.rawValue {
                        completion(json, nil)
                    } else if responseCode == APIErrorCode.invalidToken.rawValue {
                        let error = NSError.errorWith(code: responseCode, message: message)
                        completion(json, error)
                    } else {
                        let error = NSError.errorWith(code: responseCode, message: message)
                        completion(json, error)
                    }
                    break
                case .failure(let error as NSError):
                    if error.code == NSURLErrorNotConnectedToInternet || error.code == NSURLErrorNetworkConnectionLost {
                        let error = NSError.errorWith(code: error.code, message: String.internetConnectionLost)
                        completion(JSON.null, error)
                    } else if error.code == NSURLErrorCancelled {
                        completion(JSON.null, NSError.errorWith(code: error.code, message: String.internetConnectionLost))
                    } else {
                        completion(JSON.null, error)
                    }
                    break
                default:
                    break
                }
        }
    }
}
