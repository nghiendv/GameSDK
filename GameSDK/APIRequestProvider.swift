//
//  APIRequestProvider.swift
//  LoginSocialSDK
//
//  Created by Đào Văn Nghiên on 2/7/20.
//  Copyright © 2020 nghiendv. All rights reserved.
//

import UIKit
import Alamofire

let kClientVersionHeaderField = "os_version_code"
let kClientOSHeaderField = "os_type"

// public
let baseURL = "http://18.138.108.34:8080"
//let baseURL = "http://192.168.1.59:9009"
let apiVersion = "/sdk-api"

/*
 *  APIRequestProvider takes responsible for build and provide request for service objects
 *  default header for request will be defined here
 */
class APIRequestProvider: NSObject {

    //mark: SINGLETON
    static var shareInstance: APIRequestProvider = {
        let instance = APIRequestProvider()
        return instance
    }()

    //mark: DEFAULT HEADER & REQUEST URL
    private var _headers: HTTPHeaders = [:]
    var headers: HTTPHeaders {
        set {
            _headers = headers
        }

        get {
            let headers: HTTPHeaders = [
                "Accept": "application/json",
                "Content-Type": "application/json",
                "token": "erywhefnmsdnfakwehr9q3i48759qfsm@#$%^dfbn29384612394rkedfmbnksdhf"
            ]

            return headers
        }
    }

    private var _headersLogin: HTTPHeaders = [:]
    var headersLogin: HTTPHeaders {
        set {
            _headersLogin = headersLogin
        }
        get {
            let imei = UIDevice.current.identifierForVendor?.uuidString
            let authorization = "Bearer " + imei!

            let headersLogin: HTTPHeaders = [
//                "Authorization": authorization,
                "Accept": "application/json",
                "Content-Type": "application/json",
                "token": "erywhefnmsdnfakwehr9q3i48759qfsm@#$%^dfbn29384612394rkedfmbnksdhf"
            ]

            return headersLogin
        }
    }

    func commonParam() -> [String: String] {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        let deviceOS = "ios"
        
        var param = [String: String]()
        param[kClientVersionHeaderField] = version
        param[kClientOSHeaderField] = deviceOS
        return param
    }

    private var _requestURL: String = baseURL
    var requestURL: String {
        set {
            _requestURL = requestURL
        }
        get {

            var url = _requestURL
            url.append("\(apiVersion)/")
            return url
        }
    }

    var alamoFireManager: SessionManager

    override init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = 30 // seconds for testing

        alamoFireManager = Alamofire.SessionManager(configuration: configuration)
    }

    func login(loginType: LoginType, accessToken: String) -> DataRequest {
        let urlString = requestURL.appending("social/login")
        var param = commonParam()
        param["login_type"] = loginType.stringValue()
        param["access_token"] = accessToken
        return alamoFireManager.request(urlString,
                                        method: .post,
                                        parameters: param,
                                        encoding: JSONEncoding.default,
                                        headers: self.headers)
    }
    
    func checkRefund(userId: String) -> DataRequest {
        let urlString = requestURL.appending("payments/check-refund")
        var param = commonParam()
        param["user_id"] = userId
        return alamoFireManager.request(urlString,
                                        method: .post,
                                        parameters: param,
                                        encoding: JSONEncoding.default,
                                        headers: self.headers)
    }
    
    func saveReceipt(userId: String, receiptId: String, paymentType: PaymentType) -> DataRequest {
        let urlString = requestURL.appending("payments/confirm")
        var param = commonParam()
        param["user_id"] = userId
        param["purchase_type"] = paymentType.stringValue()
        param["receipt_id"] = receiptId
        return alamoFireManager.request(urlString,
                                        method: .post,
                                        parameters: param,
                                        encoding: JSONEncoding.default,
                                        headers: self.headers)
    }
    
    func usersRefund() -> DataRequest {
        let urlString = requestURL.appending("payments/users-refund")
        let param = commonParam()
        return alamoFireManager.request(urlString,
                                        method: .get,
                                        parameters: param,
                                        encoding: URLEncoding.queryString,
                                        headers: self.headers)
    }
}
