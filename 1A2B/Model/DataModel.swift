//
//  DataModel.swift
//  1A2B
//
//  Created by hg on 2017/8/29.
//  Copyright © 2017年 hg. All rights reserved.
//

import UIKit

class DataModel: NSObject {

    var content:String = ""
    var nums:String = ""
    
    init(dict:[String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override init() {
        super.init()
    }
   
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
