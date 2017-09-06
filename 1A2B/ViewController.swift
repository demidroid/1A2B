//
//  ViewController.swift
//  1A2B
//
//  Created by hg on 2017/8/8.
//  Copyright © 2017年 hg. All rights reserved.
//

import UIKit
import SCLAlertView
// 系统生成的数字
private var randNum:[Int] = [0,0,0,0]

// 用户所猜数字
private var userNums:[Int] = []

// 猜测次数
private var count:Int = 0


// 猜测结果
private var results:[DataModel] = []


private var isWinner:Bool = false

let ABIdentifier = "OneATwoBCell"

class ViewController: UIViewController {
   
 

    @IBOutlet weak var counto0downTextView: UILabel!
    @IBOutlet weak var recordTable: UITableView!
    @IBOutlet weak var inputNumField: UITextField!
    
    var timer = Timer()
    
    // 清空数据
    @IBAction func refreshAction(_ sender: Any) {
        
        timer.invalidate()
        counto0downTextView.text = "倒计时"
        results.removeAll()
        recordTable.reloadData()
        inputNumField.text = "数据显示"
    }
    
    @IBAction func startAction(_ sender: Any) {
        
        if !timer.isValid {
            
            timer.invalidate() // just in case this button is tapped multiple times
            
            // start the timer
            timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        }
        
        
      let numberView = NumberView.numberView()
        numberView.delegate = self
        numberView.frame = CGRect(x: (width-240)/2, y:(height-360)/2, width: 240, height: 360)
        self.view.addSubview(numberView)
        
        self.view.bringSubview(toFront: numberView)
    }

    func timerAction() {
        count += 1
        counto0downTextView.text = "\(count)"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        randNumbers()
        recordTable.dataSource = self
        recordTable.delegate = self
        recordTable.register(UINib(nibName:"OneATwoBCell",bundle:nil), forCellReuseIdentifier: ABIdentifier)
       
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.   
    }

    
}

// 数字显示
extension ViewController:NumberViewProtocol{
    
    func passInputNum(nums: [String]) {
        
       userNums.removeAll()
        var str = ""
        for num in nums {
            
            userNums.append(Int(num)!)
            str.append(num)
        }
        
       inputNumField.text  = str
        
//       results.append(compareData())
        results.insert(compareData(), at: 0)
        recordTable.reloadData()
    }
}

// 获取随机数
extension ViewController{
    
    fileprivate func randNumbers(){
        
        for i in 0..<4 {
            
            choice(position: i)
        }
        
        print(randNum)
    }
    
    fileprivate func choice(position:Int){
        
        let temp = arc4random_uniform(9)+1
        
        for num in randNum {
            
            
            guard  num != temp else{
                
                choice(position: position)
                
                return
            }
            randNum[position] = Int(temp)
            
        }
    }
    
    // 对比两个数组
    fileprivate func compareData() -> DataModel{
        let dataModel = DataModel()
        
        var A = 0
        var B = 0
        
        for i in 0..<4 {
            
            if randNum.contains(userNums[i]){
                
                if i == randNum.index(of: userNums[i]){
                    
                    A = A + 1
                }
                else {
                    
                    B = B + 1
                }
            }
        }
        dataModel.nums = inputNumField.text!
        dataModel.content = String(format:"%dA%dB",A,B)
        
        if A==4 {
            isWinner = true
            timer.invalidate()
            
            SCLAlertView().showInfo("恭喜您猜对了", subTitle: "你真厉害")
        }
        
        
        print(dataModel.content)
        return dataModel;
    }
}

extension ViewController{
    
    fileprivate func loadData(){
        
        NetworkTools.requestData(URLString: "http://c.m.163.com/nc/article/list/T348649079062/0-20.html", type:.get){
            
            (result : Any) in
                print(result)
            
        }
    }
}


extension ViewController:UITableViewDataSource,UITableViewDelegate{


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return results.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: ABIdentifier, for: indexPath) as! OneATwoBCell
        cell.model = results[indexPath.item]
        return cell
    }

}

