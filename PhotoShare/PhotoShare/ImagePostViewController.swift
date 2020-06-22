//
//  ImagePostViewController.swift
//  PhotoShare
//
//  Created by Aye Thu Thu Zaw on 2020/06/19.
//  Copyright © 2020 ALJ. All rights reserved.
//

import UIKit
import NCMB

class ImagePostViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var pickedImage:UIImage!
    var imageFile:NCMBFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.imageView.image = pickedImage
        self.imageView.contentMode = UIView.ContentMode.scaleAspectFit
    }
    
    @IBAction func postButtonTapped(_ sender: Any) {
        postImageToNCMB()

    }
    
    func postImageToNCMB(){
        // 画像をリサイズ
        let resizedImage = self.resizeImage(image: pickedImage, ratio: 0.1) // 50% に縮小
        let imageData = NSData(data: resizedImage.pngData()!) as NSData
        // ファイル名生成（UUIDでユニークな文字を生成）
        let filename = "\(NSUUID().uuidString).png"
        imageFile = NCMBFile.file(withName: filename, data:imageData as Data) as? NCMBFile
        // アップロード時はアクティビティインディケータを表示
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        // アップロード処理
        imageFile.saveInBackground({(error) in
            // アクティビティインディケータ表示を解除
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if (error != nil) {
                print("写真保存失敗:\(String(describing: error))")
            } else {
                print("写真保存成功")
                // 画像メタデータ（ファイル名、投稿ユーザ）をデータストアに保存
                let imageMeta = NCMBObject(className: "Photo")
                imageMeta?.setObject(filename, forKey: "filename")
                imageMeta?.setObject(NCMBUser.current(), forKey: "owner")
                imageMeta?.saveInBackground({(error) in
                    if (error != nil) {
                        print("写真メタ保存失敗:\(String(describing: error))")
                    }else{
                        print("写真メタ保存成功")
                        // アラート表示
                        let alert = UIAlertController(
                            title: "写真アップロード完了",
                            message: "写真のアップロード完了しました。",
                            preferredStyle: .alert
                        )
                        let action = UIAlertAction(
                            title: "OK",
                            style: .default,
                            handler: {(action:UIAlertAction) -> Void in
                                // OKボタンタップしたらトップに戻る
                                self.navigationController?.popToRootViewController(animated: true)
                        })
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                })
            }
            },progressBlock: { (percentDone: Int32) -> Void in
                // 進捗状況取得 保存完了まで何度も呼ばれます
                print("upload status:\(percentDone)%")
        })
    }

    /// 画像を指定された比率に縮小
    func resizeImage(image: UIImage, ratio: CGFloat) -> UIImage {
        let size = CGSize(width: image.size.width * ratio, height: image.size.height * ratio)
        UIGraphicsBeginImageContext(size)
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage!
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
