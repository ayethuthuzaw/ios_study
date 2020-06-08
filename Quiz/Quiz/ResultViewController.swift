//
//  ResultViewController.swift
//  Quiz
//
//  Created by Aye Thu Thu Zaw on 2020/06/08.
//  Copyright © 2020 ALJ. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var levelImage: UIImageView!
    
    var correctPercentage = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if correctPercentage < 30 {
                levelLabel.text = "猿レベル"
                levelImage.image = UIImage(named:"bad")
            } else if correctPercentage >= 30 && correctPercentage < 90 {
                levelLabel.text = "一般人レベル"
                levelImage.image = UIImage(named:"normal")
            } else if correctPercentage >= 90 {
                levelLabel.text = "天才レベル"
                levelImage.image = UIImage(named:"good")
            }
            percentageLabel.text = String(format:"%d %%", correctPercentage)
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
