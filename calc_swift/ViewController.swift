//
//  ViewController.swift
//  calc_swift
//
//  Created by 山口 智生 on 2015/03/01.
//  Copyright (c) 2015年 Tomoki Yamaguchi. All rights reserved.
//

import UIKit



/*
相性占い機能について
19950215
みたいに8桁にして入力してください。
*/

class ViewController: UIViewController {
    
    @IBOutlet weak var panel: UILabel!
    
    var tab :Int = 0//どこに入力しているか
    
    var mode = 0.0
    
    let NUM_ANSWER = 2
    let NUM0 = 0
    let NUM1 = 1
    
    var nums :[Double] = [0.0,0.0,0.0]
    
    var ops = [" ", "+", "-", "*", "÷", "♥"]
    
    var op = 0

    func inputnum(tmpnum: Int){
        if(tab < 2){//左の数字にしか入力許可しない
            if(mode == 0){
                nums[tab] = nums[tab]*10.0 + Double(tmpnum)
            }else{
                mode = mode/10
                nums[tab] = nums[tab] + mode * Double(tmpnum)
            }
        }
        update()
    }
    func double2string(tmpnum: Double) -> String {
        var tmpString: String!
        if tmpnum == 0 {
            return " "
        }
        if floor(tmpnum) == ceil(tmpnum) {//整数
            tmpString = "\(Int(tmpnum))"
        }else{
            tmpString = "\(tmpnum)"
        }
        return tmpString
    }
    
    func uranai(var num1: Double, var num2: Double) -> Double{
        var tmpDouble = (num1/10000-1900)/(num2/10000-1900)
        if tmpDouble > 1 {//0〜1にする
            tmpDouble = 1.0/tmpDouble
        }
        
        var dist = abs(num1%10-num2%10) + abs((num1/10)%10 - (num2/10)%10) + abs((num1/100)%10 - (num2/100)%10) + abs((num1/1000)%10 - (num2/1000)%10)
        
        tmpDouble = (20.0-dist)/20 * tmpDouble
        
        return tmpDouble
    }
    
    func update(){
        //ラベルのupdate
        var tmpInt:Int = 0
        var tmpString: String = "0"
        if nums[NUM0] != 0 {
            tmpString = double2string(nums[NUM0])
        }
        if mode==1 {
            tmpString = tmpString + "."
        }
        tmpString = tmpString + "\(ops[op])"
        if tab>0 {
            tmpString = tmpString + double2string(nums[NUM1])
            if(tab>1){
                tmpString = tmpString + "=" + double2string(nums[NUM_ANSWER])
            }
        }
        panel.text = tmpString
        return
    }
    func updateOp(operand: Int){
        if tab < 2{
            tab = 1
            op = operand
            mode = 0
        }
        return
    }
    
    @IBAction func bu_num(sender: AnyObject) {
        inputnum(sender.tag)
        
    }
    @IBAction func bu_dot(sender: AnyObject) {
        if(mode==0){
            mode = 1
        }
        update()
    }
    
    
    @IBAction func plus(sender: AnyObject) {
        updateOp(1)
        update()
    }
    @IBAction func minus(sender: AnyObject) {
        updateOp(2)
        update()
    }
    @IBAction func multi(sender: AnyObject) {
        updateOp(3)
        update()
    }
    @IBAction func waru(sender: AnyObject) {
        updateOp(4)
        update()
    }
    @IBAction func buUranai(sender: AnyObject) {
        updateOp(5)
        update()
    }
    @IBAction func enter(sender: AnyObject) {
        if(tab==1){
        switch(op){
            case 1:
                nums[NUM_ANSWER] = nums[NUM0] + nums[NUM1]
                break
            case 2:
                nums[NUM_ANSWER] = nums[NUM0] - nums[NUM1]
                break
            case 3:
                nums[NUM_ANSWER] = nums[NUM0] * nums[NUM1]
                break
            case 4:
                nums[NUM_ANSWER] = nums[NUM0] / nums[NUM1]
                break
            case 5:
                nums[NUM_ANSWER] = uranai(nums[NUM0], num2: nums[NUM1])
            default:
                break
            }
        tab=2
        }
        update()
    }
    
    @IBAction func AllClear(sender: AnyObject) {
        nums = [0,0,0]
        tab=0
        mode = 0
        op = 0
        update()
    }
    
    @IBAction func clear(sender: AnyObject) {//back
        if(nums[tab]==0){
            if tab > 0 {
                tab = tab-1
            }
            if tab==0 {
                op = 0
            }
        }else{
            nums[tab] = 0
            if tab > 1{
                tab = tab-1
            }
        }
        update()
    }
    
    @IBAction func tax(sender: AnyObject) {
        nums[tab] = nums[tab] * 1.08
        update()
    }
    
    @IBAction func ans(sender: AnyObject) {
        nums[NUM0] = nums[NUM_ANSWER]
        nums[NUM_ANSWER] = 0
        nums[NUM1] = 0
        tab = 0
        mode = 0
        op = 0
        update()
    }
    

    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        AllClear(0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

