//
//  NumberView.swift
//  1A2B
//
//  Created by hg on 2017/8/31.
//  Copyright © 2017年 hg. All rights reserved.
//

import UIKit

let  width = UIScreen.main.bounds.width
let height = UIScreen.main.bounds.height
let identifier = "NumberViewCell"

protocol NumberViewProtocol: class {
    
    func passInputNum(nums:[String]) 
}

class NumberView: UIView ,UICollectionViewDelegate,UICollectionViewDataSource{
   
    
  
    @IBOutlet weak var numshowLabel: UILabel!
    
    @IBOutlet weak var keyboard: UICollectionView!
    
    fileprivate var datasource:[String] = ["1","2","3","4","5","6","7","8","9"];
    
    var inputNum:[String] = [];
    
    weak var delegate:NumberViewProtocol?
    
    @IBAction func closeView(_ sender: Any) {
        
       
        self.removeFromSuperview()
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        
        if inputNum.count > 0 {
            
            inputNum.removeLast()
        }
        
        setValue(nums: inputNum)
        print(inputNum)
    }
    
    @IBAction func sureAction(_ sender: Any) {
        
        if inputNum.count == 4 {
            
            delegate?.passInputNum(nums: inputNum)
            closeView(sender)
        }
        else {
            
            print("请输入4个数字")
        }
    }
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        

        createCollection()
    }
   
    
  
    func createCollection() {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: keyboard.frame.width/3, height: keyboard.frame.height/3)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        
        keyboard.collectionViewLayout = flowLayout
        keyboard.backgroundColor = UIColor.groupTableViewBackground
        keyboard.delegate = self
        keyboard.dataSource = self

        keyboard.showsVerticalScrollIndicator = false
        keyboard.register(UINib(nibName: "NumberViewCell", bundle: nil), forCellWithReuseIdentifier: identifier)
        keyboard.allowsSelection = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! NumberViewCell
        cell.numStr = datasource[indexPath.item]
        return cell
    }

     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        
        let  cell = collectionView.cellForItem(at: indexPath) as! NumberViewCell

        if inputNum.count == 4 {
            
            inputNum[3] = cell.numLabel.text!
        }
        else {
            
            let value = cell.numLabel.text
            
            if !inputNum.contains(value!){
                inputNum.append(cell.numLabel.text!)
            }
            
        }
        print(inputNum)
        setValue(nums: inputNum)

    }
    
    func setValue(nums:[String])  {
        var str = ""
        
        for num in inputNum {
            str.append(num)
        }
        
        if inputNum.count == 0 {
            
            numshowLabel.text = "数字显示"
        }
        numshowLabel.text = str
    }
    
}

extension NumberView{
    
    class func numberView() -> NumberView {
        
        return Bundle.main.loadNibNamed("NumberView", owner: nil, options: nil )?.first as! NumberView
    }
}


