//
//  ResultViewController.swift
//  Alj100M
//
//  Created by Aye Thu Thu Zaw on 2020/06/10.
//  Copyright © 2020 ALJ. All rights reserved.
//

import UIKit
import Social

class ResultViewController: UIViewController {
    
    @IBOutlet weak var Kirokukousin: UILabel!
    @IBOutlet weak var TimerLabel: UILabel!
    
     @IBAction func FacebookButton(_ sender: Any) {
           let text = "結果タイム" + TimerLabel.text!
           let composeViewController: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)!
           composeViewController.setInitialText(text)
           self.present(composeViewController, animated: true, completion: nil)
       }
       //Tweet
       
       @IBAction func TweetButton(_ sender: Any) {
           let text = "結果タイム" + TimerLabel.text!
           let composeViewController: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)!
           composeViewController.setInitialText(text)
           self.present(composeViewController, animated: true, completion: nil)
       }
       //Line
       
       @IBAction func LineButton(_ sender: Any) {
           let text: String! = "結果タイム" + TimerLabel.text!
           let encodeMessage: String! = text.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
           let messageURL: NSURL! = NSURL( string: "line://msg/text/" + encodeMessage )
           if (UIApplication.shared.canOpenURL(messageURL as URL)) {
               UIApplication.shared.openURL( messageURL as URL )
               }
       }

    override func viewDidLoad() {
        super.viewDidLoad()

       TimerLabel.text = NSString(format:"%.2f秒",CountTimer) as String
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
