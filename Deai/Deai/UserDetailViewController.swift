//
//  UserDetailViewController.swift
//  Deai
//
//  Created by Aye Thu Thu Zaw on 2020/06/23.
//  Copyright © 2020 ALJ. All rights reserved.
//

import UIKit
import NCMB
import MessageUI

class UserDetailViewController: UIViewController, MFMailComposeViewControllerDelegate  {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var mailLabel: UILabel!
    
    var user = NCMBUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mailLabel.text = user.object(forKey: "mailAddress") as? String

               let fbPictureUrl = "https://3.bp.blogspot.com/-esJ3eqpx3Vc/XMZ94CFpjHI/AAAAAAABSmE/eJFVEHwpty0fxzrsX_Pmtw89nvUDxQt_QCLcBGAs/s800/ishiki_hikui_man.png"
               if let fbpicUrl = NSURL(string: fbPictureUrl) {
                if let data = NSData(contentsOf: fbpicUrl as URL) {
                    self.imageView.image = UIImage(data: data as Data)
                   }
               }
    }
    
    @IBAction func contact(_ sender: Any) {
        if MFMailComposeViewController.canSendMail()==false {
            print("Email Send Failed")
            return
        }
        let mailViewController = MFMailComposeViewController()
        let toRecipients = [user.object(forKey: "mailAddress") as! String] //Toのアドレス指定
        mailViewController.mailComposeDelegate = self
        mailViewController.setSubject("「出会いアプリ」メール通知")
        mailViewController.setToRecipients(toRecipients) //Toアドレスの表示
        mailViewController.setMessageBody("", isHTML: false)
        
        let fbPictureUrl = "https://3.bp.blogspot.com/-esJ3eqpx3Vc/XMZ94CFpjHI/AAAAAAABSmE/eJFVEHwpty0fxzrsX_Pmtw89nvUDxQt_QCLcBGAs/s800/ishiki_hikui_man.png"
        if let fbpicUrl = NSURL(string: fbPictureUrl) {
            if let data = NSData(contentsOf: fbpicUrl as URL) {
                mailViewController.addAttachmentData(data as Data, mimeType: "image/png", fileName: "image")
            }
        }
        self.present(mailViewController, animated: true, completion: nil)
    }
    
   func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
           switch result {
           case MFMailComposeResult.cancelled:
               print("メール送信キャンセル")
               break
           case MFMailComposeResult.saved:
               print("メールドラフト保存")
               break
           case MFMailComposeResult.sent:
               print("メール送信完了")
               break
           case MFMailComposeResult.failed:
               print("メール送信失敗")
               break
           default:
               break
           }
           // 画面を閉じる
        controller.dismiss(animated: true, completion: nil)
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
