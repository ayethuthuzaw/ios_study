//
//  ViewController.swift
//  Counter
//
//  Created by Aye Thu Thu Zaw on 2020/06/04.
//  Copyright © 2020 ALJ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var countLabel: UILabel!
    var count = Int()
    var countLabelText = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        count = 0
    }

    @IBAction func plusPushed(_ sender: Any) {
           count = count + 1
        if count >= 0 && count < 10 {
               countLabel.textColor = UIColor.blue
           } else if count >= 10 && count < 20 {
               countLabel.textColor = UIColor.lightGray
           } else if count >= 20 && count < 30 {
               countLabel.textColor = UIColor.purple
           } else {
               countLabel.textColor = UIColor.black
           }
        countLabelText = "\(count)"
        countLabel.text = countLabelText
    }
    @IBAction func minusPushed(_ sender: Any) {
        if count > 0 {
            count = count - 1
            if count >= 0 && count < 10 {
                countLabel.textColor = UIColor.blue
            } else if count >= 10 && count < 20 {
                countLabel.textColor = UIColor.lightGray
            } else if count >= 20 && count < 30 {
                countLabel.textColor = UIColor.purple
            } else {
                countLabel.textColor = UIColor.black
            }
            countLabelText = "\(count)"
            countLabel.text = countLabelText
        }
    }
    @IBAction func resetPushed(_ sender: Any) {
        count = 0
        countLabel.textColor = UIColor.black
        countLabelText = "\(count)"
        countLabel.text = countLabelText
    }
    
}

