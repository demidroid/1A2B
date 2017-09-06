//
//  NumberViewCell.swift
//  1A2B
//
//  Created by hg on 2017/9/1.
//  Copyright © 2017年 hg. All rights reserved.
//

import UIKit

class NumberViewCell: UICollectionViewCell {

    @IBOutlet public weak var numLabel: UILabel!
    
    var numStr :String? {
    
        didSet{
         
            numLabel.text  = numStr
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
   
}
