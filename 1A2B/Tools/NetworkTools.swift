//
//  NetworkTools.swift
//  1A2B
//
//  Created by hg on 2017/8/22.
//  Copyright © 2017年 hg. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}

class NetworkTools: NSObject {

    class func requestData(URLString:String,type: MethodType,params:[String:Any]?=nil,
                           finishedCallback:@escaping(_ result:Any) -> ()){
        
        let method = type == .get ? HTTPMethod.get:HTTPMethod.post
        
        Alamofire.request(URLString, method: method, parameters: params).responseJSON{ (response) in
            
            guard let result = response.result.value else {
                
                print(response.result.error)
                return
            }
            
            finishedCallback(result)
        }
    }
}
