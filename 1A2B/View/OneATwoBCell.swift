//
//  OneATwoBCell.swift
//  1A2B
//
//  Created by hg on 2017/9/6.
//  Copyright © 2017年 hg. All rights reserved.
//

import UIKit

class OneATwoBCell: UITableViewCell {

    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    var model:DataModel? {
        
        didSet{
            numLabel.text = model?.nums
            contentLabel.text = model?.content
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
