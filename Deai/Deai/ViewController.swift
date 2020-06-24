//
//  ViewController.swift
//  Deai
//
//  Created by Aye Thu Thu Zaw on 2020/06/23.
//  Copyright © 2020 ALJ. All rights reserved.
//

import UIKit
import NCMB

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var interestedInWomen: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
           // ログインチェック
           self.loginCheck()
       }
      
       func loginCheck(){
           if (NCMBUser.current() != nil) {
               print("ログイン済み")
            self.setMyPicture()
           } else {
               print("未ログイン")
               self.performSegue(withIdentifier: "toLogin", sender: nil)
           }
       }
    
    func setMyPicture(){
        let user = NCMBUser.current()
        print("user:\(String(describing: user))")
        let fbPictureUrl = "https://3.bp.blogspot.com/-esJ3eqpx3Vc/XMZ94CFpjHI/AAAAAAABSmE/eJFVEHwpty0fxzrsX_Pmtw89nvUDxQt_QCLcBGAs/s800/ishiki_hikui_man.png"
        if let fbpicUrl = NSURL(string: fbPictureUrl) {
            if let data = NSData(contentsOf: fbpicUrl as URL) {
                self.imageView.image = UIImage(data: data as Data)
            }
        }
    }

    @IBAction func logoutButtonTapped(_ sender: Any) {
        NCMBUser.logOut()
        self.loginCheck()
    }
    
    @IBAction func startButtonTapped(_ sender: Any) {
        // NCMBに好みの性別情報を保存
        let user = NCMBUser.current()
        user?.setObject(interestedInWomen.isOn, forKey: "interestedInWomen")
        user?.saveEventually({(error) in
            if (error != nil) {
                print("保存失敗:\(String(describing: error))")
            }else{
                print("保存成功:\(String(describing: user))")
                // 次の画面
                self.performSegue(withIdentifier: "toTinder", sender: nil)
            }
        })
    }
    
}

