//
//  FirstViewController.swift
//  Pedometer
//
//  Created by Aye Thu Thu Zaw on 2020/06/12.
//  Copyright © 2020 ALJ. All rights reserved.
//

import UIKit
import CoreMotion
import MessageUI

class FirstViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var stepCountLabel: UILabel!
    
    var pedometer = CMPedometer()
    var stepCount = Int()
    
    func startStepCounting() {

        if(CMPedometer.isStepCountingAvailable()){
                self.pedometer.startUpdates(from: NSDate() as Date) {
                (data: CMPedometerData?, error) -> Void in
                DispatchQueue.main.async(execute: { () -> Void in
                    if(error == nil){
                        self.stepCount = Int(truncating: data!.numberOfSteps)
                        self.stepCountLabel.text = "\(self.stepCount)"
                    }
                })
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startStepCounting()
    }
    
    @IBAction func sendMail(_ sender: Any) {
        let mailViewController = MFMailComposeViewController()
        let subject = "歩きました！"
        let message = String(format: "たった今、私は %d 歩きました！", stepCount)

        mailViewController.mailComposeDelegate = self
        mailViewController.setSubject(subject)
        mailViewController.setMessageBody(message, isHTML: false)
        self.present(mailViewController, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resetButtonAction(_ sender: Any) {
         self.reset()
    }
    
    func reset() {
        //各変数をリセット
        self.stepCount = 0
        pedometer = CMPedometer()
        
        // 歩数取得開始
        startStepCounting()
        
        //ラベルの値をリセット
        self.stepCountLabel.text = "\(self.stepCount)"
    }
}

