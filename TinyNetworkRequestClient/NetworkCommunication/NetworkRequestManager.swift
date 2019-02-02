//
//  NetworkRequestManager.swift
//  TinyNetworkRequestClient
//
//  Created by Ganesh on 02/02/19.
//  Copyright © 2019 Ganesh. All rights reserved.
//

import UIKit

enum APIResult {
    case success(Data)
    case failue(Error)
}

typealias APIResultCallBack = (_ apiResult: APIResult) -> Void

class NetworkRequestManager: NSObject {
    
    static let sharedManager = NetworkRequestManager()
    
    //MARK:- GET Request
    func sendGETRequest(_ url: String, withCompletion completion: @escaping APIResultCallBack) {
        
        let url = URL(string: url)!
        let urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: TimeInterval(120))
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, urlResponse, error) in
            DispatchQueue.main.async {
                if error == nil {
                    if data != nil {
                        completion(APIResult.success(data!))
                    }
                } else {
                    print(error?.localizedDescription ?? "")
                    completion(APIResult.failue(error!))
                }
            }
        }
        task.resume()
    }
}
