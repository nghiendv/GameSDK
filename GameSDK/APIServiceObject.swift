//
//  APIServiceObject.swift
//  LoginSocialSDK
//
//  Created by Đào Văn Nghiên on 2/7/20.
//  Copyright © 2020 nghiendv. All rights reserved.
//

import UIKit
import Alamofire

/*
 *  APIServiceObject is a base class, used to manage requests for each service object
 *
 */
class APIServiceObject: NSObject {
    var requests = [DataRequest]()
    var serviceAgent = APIServiceAgent()

    /*
     * cancel all request for the certain service object
     * and remove all request from requests
     */
    func cancelAllRequests() {
        let sessionManager = Alamofire.SessionManager.default
        if #available(iOS 9.0, *) {
            sessionManager.session.getAllTasks { (_ tasks: [URLSessionTask]) in
                for task in tasks {
                    task.cancel()
                }
            }
        } else {
            // Fallback on earlier versions
            sessionManager.session.getTasksWithCompletionHandler({ (sessionTasks, uploadTasks, downloadTasks) in
                for task in sessionTasks {
                    task.cancel()
                }
                for task in uploadTasks {
                    task.cancel()
                }
                for task in downloadTasks {
                    task.cancel()
                }
            })
        }
        for request in requests {
            request.cancel()
        }
        requests.removeAll()
    }

    /*
     *  add request to request array
     *  @param request  DataRequest
     */

    func addToQueue(_ request: DataRequest) {
        requests.append(request)
    }
}

