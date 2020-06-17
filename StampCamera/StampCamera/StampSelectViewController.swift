//
//  StampSelectViewController.swift
//  StampCamera
//
//  Created by Aye Thu Thu Zaw on 2020/06/16.
//  Copyright © 2020 ALJ. All rights reserved.
//

import UIKit

class StampSelectViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var imageArray:[UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 1...6{
               imageArray.append(UIImage(named: "\(i).png")!)
           }

    }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return imageArray.count
       }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)-> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath)
        
        let imageView = cell.viewWithTag(1) as! UIImageView
        imageView.image = imageArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //Stampインスタンスを作成
        let stamp = Stamp()
        //stampにインデックスパスからスタンプ画像を設定
        stamp.image = imageArray[indexPath.row]
        //AppDelegateのインスタンスを取得
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //配列stampArrayにstampを追加
        appDelegate.stampArray.append(stamp)
        //新規スタンプ追加フラグをtrueに設定
        appDelegate.isNewStampAdded = true
        //スタンプ選択画面を閉じる
        self.dismiss(animated: true, completion: nil)
    }

    
    @IBAction func closeTapped(){
        self.dismiss(animated: true, completion: nil)
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
