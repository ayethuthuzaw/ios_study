//
//  GameViewController.swift
//  Alj100M
//
//  Created by Aye Thu Thu Zaw on 2020/06/10.
//  Copyright © 2020 ALJ. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var CountLabel: UILabel!
    @IBOutlet weak var Cara1: UIImageView!
    @IBOutlet weak var Cara2: UIImageView!
    @IBOutlet weak var ase1: UIImageView!
    @IBOutlet weak var ase2: UIImageView!
    @IBOutlet weak var ganba1: UIImageView!
    @IBOutlet weak var ganba2: UIImageView!
    @IBOutlet weak var goal: UIImageView!
    
    var CountInt:Int = 0
    var timer:Timer!
    
    @IBAction func rendaButton(sender: AnyObject) {

        if Cara1.isHidden == true {
            //Cara1が非表示だったら
            //Cara1を表示して、Cara2を非表示にする
            Cara1.isHidden = false
            Cara2.isHidden = true
        } else{
            //Cara1が表示していたら
            //Cara1を非表示にして、Cara2を表示させる
            Cara1.isHidden = true
            Cara2.isHidden = false
        }

        //CountIntに+1する
        CountInt = CountInt + 1

        //CountIntを文字列へ変換してCountLabel.textへ代入する
        CountLabel.text = CountInt.description

        if CountInt > 90{
            
            if ase1.isHidden == false{
                ase1.isHidden = true
                ase2.isHidden = false
            }else{
                ase1.isHidden = false
                ase2.isHidden = true
            }

            if ganba1.isHidden == false{
                ganba1.isHidden = true
                ganba2.isHidden = false
            }else{
                ganba1.isHidden = false
                ganba2.isHidden = true
            }

            if goal.isHidden == true{
                goal.isHidden = false
            }
            
        }

        //CountIntが100になったら画面を遷移させる
        if CountInt == 100 {
            
            //timerを停止
            timer.invalidate()
            
            //画面を遷移させる(segue(toResult)を実行させる)
            self.performSegue(withIdentifier: "toResult", sender: nil)
        }

    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        CountLabel.text = CountInt.description
         
        Cara1.isHidden = true
        ase1.isHidden = true
        ase2.isHidden = true
        ganba1.isHidden = true
        ganba2.isHidden = true
        goal.isHidden = true
         
        Cara2.isHidden = false
        
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(GameViewController.onUpdate(timer:)), userInfo: nil, repeats: true)
        
    }
    @objc func onUpdate(timer : Timer){
            CountTimer = CountTimer + 0.1
        }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
