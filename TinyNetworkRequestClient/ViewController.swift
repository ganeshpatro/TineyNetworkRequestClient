//
//  ViewController.swift
//  TinyNetworkRequestClient
//
//  Created by Ganesh on 02/02/19.
//  Copyright © 2019 Ganesh. All rights reserved.
//

import UIKit



enum AppURL: String {
    case GROUPS = "http://api.myjson.com/bins/3b0u2"
}

enum GroupsResult<T> {
    case success(T)
    case error(Error)
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NetworkRequestManager.sharedManager.sendGETRequest(AppURL.GROUPS.rawValue) { (result) in
            switch (result) {
            case .success(let dataResponnse):
                //Handle the response and do the parsing
                do {
                    let searchResultDict = try JSONSerialization.jsonObject(with: dataResponnse, options: JSONSerialization.ReadingOptions.allowFragments);
                    print("API Result is - \(searchResultDict)")
                } catch(let error) {
                    print("Error in serializing - \(error)")
                }
            case .failue(let error):
                print("There is an error in the response.")
            }
        }
    }
}

