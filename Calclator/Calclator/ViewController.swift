//
//  ViewController.swift
//  Calclator
//
//  Created by Aye Thu Thu Zaw on 2020/06/17.
//  Copyright © 2020 ALJ. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    
    let resultLabel :UILabel = UILabel();
    let screenWidth :Double = Double(UIScreen.main.bounds.size.width)
    let screenHeight :Double = Double(UIScreen.main.bounds.size.height)
    
    // 1行に配置するボタンの数
    let yButtonCount = 4
    // 1列に配置するボタンの数
    let xButtonCount = 4
    // ボタン間の余白（縦）
    let buttonMargin :Double = 10.0
    // ボタン間の余白（横）
    // 計算結果表示エリアの縦幅
    var resultArea :Double = 0
    
    var number:NSDecimalNumber = 0
    var result:NSDecimalNumber = 0
    var operatorId:String = ""
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch screenHeight {
        case 480:
            resultArea = 200.0
        case 568:
            resultArea = 250.0
        case 667:
            resultArea = 300.0
        case 736:
            resultArea = 350.0
        default:
            resultArea = 400.0
        }

           resultLabel.frame = CGRect(
               x: 10,
               y: 50,
               width: screenWidth - ( 10 * 2 ),
               height: 250
           )
          
           resultLabel.backgroundColor = self.colorWithRGBHex(hex: 0xF5F5DC, alpha: 1.0)
           let font:UIFont = UIFont(name:"Arial",size:50)!
           resultLabel.font = font
           resultLabel.textAlignment = .right
           resultLabel.numberOfLines = 4
           resultLabel.text = "0"
           self.view.addSubview(resultLabel)
        resultLabel.font = UIFont(name:"LettersLaughingattheirExecution",size:50)
        self.view.backgroundColor = UIColor.black



    
    let buttonLabels = [
        "7","8","9","×",
        "4","5","6","-",
        "1","2","3","+",
        "0","C","÷","="
    ]
    
    for y in 0 ..< yButtonCount {
        for x in 0 ..< xButtonCount {
            // ボタンインスタンス生成（この時点ではサイズ、配置場所はきめていない）
            let button :UIButton = UIButton()
    
            let buttonNumber = y * xButtonCount + x
            
            button.setTitle(buttonLabels[buttonNumber], for: .normal)
            
            let buttonPositionX =
                ( screenWidth - buttonMargin ) / Double(xButtonCount) * Double(x) + buttonMargin
            let buttonPositionY =
                ( screenHeight - resultArea - buttonMargin ) / Double(yButtonCount) * Double(y) + buttonMargin + resultArea
            // ボタンサイズ
            let buttonWidth =
                ( screenWidth - ( buttonMargin * ( Double(xButtonCount) + 1 ) ) ) / Double(xButtonCount)
            let buttonHeight =
                ( screenHeight - resultArea - ( ( buttonMargin * Double(yButtonCount) + 1 ) ) ) / Double(yButtonCount)
            // ボタンの配置場所、サイズを設定
            button.frame = CGRect(x:buttonPositionX,y:buttonPositionY,width:buttonWidth,height:buttonHeight)
            // ボタン背景色設定
            button.backgroundColor = UIColor.green
            let gradient : CAGradientLayer = CAGradientLayer()
            gradient.frame = button.bounds
            let arrayColors: NSArray = [
                self.colorWithRGBHex(hex: 0xFFFFFF, alpha: 1.0).cgColor as AnyObject,
                self.colorWithRGBHex(hex: 0xCCCCCC, alpha: 1.0).cgColor as AnyObject
            ]
            gradient.colors = arrayColors as? [Any]
            button.layer.insertSublayer(gradient, at: 0)
            // 角丸
            button.layer.masksToBounds = true
            button.layer.cornerRadius = 5.0
            // ボタンのテキストカラー
            button.setTitleColor(UIColor.black, for: .normal)
            button.setTitleColor(UIColor.gray, for: .highlighted)
            button.addTarget(self, action: #selector(self.buttonTapped(_:)), for: .touchUpInside)
            // ボタン配置
            self.view.addSubview(button)
        }
        }
    }
    
    @objc func buttonTapped(_ sender: AnyObject){
        print("buttonTapped!!")
        let tappedButton:UIButton = sender as! UIButton
        let tappedButtonTitle:NSString = tappedButton.currentTitle! as NSString
        print("タップしたボタン:\(tappedButtonTitle)")
        
        switch tappedButtonTitle {
        // 数字をタップした場合
        case "0","1","2","3","4","5","6","7","8","9":
            self.numberButtonTapped(nbt: tappedButtonTitle)
        case "×","-","+","÷":
            self.operatorButtonTapped(obt: tappedButtonTitle)
        case "=":
            self.equalButtonTapped(ebt: tappedButtonTitle)
        case "C":
            self.clearButtonTapped(cbt: tappedButtonTitle)
        default:
            print("その他")
        }
    }
    
    func numberButtonTapped(nbt tappedButtonTitle:NSString){
        print("数字ボタンタップ:" + (tappedButtonTitle as String))
        let tappedButtonNum:NSDecimalNumber = NSDecimalNumber(string: tappedButtonTitle as String)
         number = number.multiplying(by: NSDecimalNumber(string: "10")).adding(tappedButtonNum)
         resultLabel.text = number.stringValue
        
    }
    
    // 演算子のボタンをタップした時
    func operatorButtonTapped(obt tappedButtonTitle:NSString){
        print("演算子ボタンタップ:" + (tappedButtonTitle as String))
        operatorId = tappedButtonTitle as String
         result = number
         number = NSDecimalNumber(string: "0")
        
    }
    
    // 等号のボタンをタップした時
    func equalButtonTapped(ebt tappedButtonTitle:NSString){
        print("等号ボタンタップ:" + (tappedButtonTitle as String))
        switch operatorId {
        case "+":
            result = result.adding(number)
        case "-":
            result = result.subtracting(number)
        case "×":
            result = result.multiplying(by: number)
        case "÷":
            if(number.isEqual(to: 0)){
                number = 0
                resultLabel.text = "無限大"
                return
            } else {
                result = result.dividing(by: number)
            }
        default:
            print("その他")
        }
        number = 0
        resultLabel.text = result.stringValue
        operatorId = "="    }
    
    // クリアのボタンをタップした時
    func clearButtonTapped(cbt tappedButtonTitle:NSString){
        print("クリアボタンタップ:" + (tappedButtonTitle as String))
        number = NSDecimalNumber(string: "0")
         result = NSDecimalNumber(string: "0")
         operatorId = ""
         resultLabel.text = number.stringValue
        
    }
    
    func colorWithRGBHex(hex: Int, alpha: Float = 1.0) -> UIColor {
        let r = Float((hex >> 16) & 0xFF)
        let g = Float((hex >> 8) & 0xFF)
        let b = Float((hex) & 0xFF)
        return UIColor(red: CGFloat(r / 255.0), green: CGFloat(g / 255.0), blue:CGFloat(b / 255.0), alpha: CGFloat(alpha))
    }
    


}

