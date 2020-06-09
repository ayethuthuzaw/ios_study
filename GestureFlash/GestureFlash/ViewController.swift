//
//  ViewController.swift
//  GestureFlash
//
//  Created by Aye Thu Thu Zaw on 2020/06/09.
//  Copyright © 2020 ALJ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var highScore1Label: UILabel!
    @IBOutlet weak var highScore2Label: UILabel!
    @IBOutlet weak var highScore3Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {

        let defaults = UserDefaults.standard
       
        let highScore1 = defaults.double(forKey: "highScore1")
        let highScore2 = defaults.double(forKey: "highScore2")
        let highScore3 = defaults.double(forKey: "highScore3")

        NSLog("ハイスコア: 1位-%f 2位-%f 3位-%f", highScore1,highScore2, highScore3)

        if highScore1 != 0 {
            highScore1Label.text = String(format: "%.3f 秒", highScore1)
        }
        if highScore2 != 0 {
            highScore2Label.text = String(format: "%.3f 秒", highScore2)
        }
        if highScore3 != 0 {
            highScore3Label.text = String(format: "%.3f 秒", highScore3)
        }
    }
    
    @IBAction func backView(segue: UIStoryboardSegue) {

    }


}

