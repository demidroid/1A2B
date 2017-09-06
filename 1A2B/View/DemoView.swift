//
//  DemoView.swift
//  1A2B
//
//  Created by hg on 2017/9/5.
//  Copyright © 2017年 hg. All rights reserved.
//

import UIKit

class DemoView: UIView {

    @IBAction func close(_ sender: Any) {
        
        print("-------")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension DemoView{
    
    class func demoView() -> DemoView{
        
        return Bundle.main.loadNibNamed("DemoView", owner: nil, options: nil)?.first as! DemoView
    }
}
