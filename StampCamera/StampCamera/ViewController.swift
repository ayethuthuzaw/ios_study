//
//  ViewController.swift
//  StampCamera
//
//  Created by Aye Thu Thu Zaw on 2020/06/16.
//  Copyright © 2020 ALJ. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UIActionSheetDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet var mainImageView:UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
       
        super.viewWillAppear(animated)
       
        if appDelegate.isNewStampAdded == true{
           
            let stamp = appDelegate.stampArray.last!
            stamp.frame = CGRectMake(0, 0, 130, 130)
            stamp.center = mainImageView.center
            stamp.isUserInteractionEnabled = true
            canvasView.addSubview(stamp)
            appDelegate.isNewStampAdded = false
        }
    }
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    
    @IBOutlet var canvasView: UIView!
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var pickerController = UIImagePickerController()
       
       override func viewDidLoad() {
           super.viewDidLoad()
            pickerController.delegate = self
       }
    
    

    
    
    @IBAction func cameraTapped(){
          
           let actionSheet:UIAlertController = UIAlertController(title:"写真を取得",
                                                                 message: "写真の取得先を選択してください",
                                                                 preferredStyle: UIAlertController.Style.actionSheet)
        
           let cancelAction:UIAlertAction = UIAlertAction(title: "Cancel",
                                                          style: UIAlertAction.Style.cancel,
                                                          handler:{
                                                           (action:UIAlertAction!) -> Void in
                                                           print("Cancel")
           })
        
           let cameraAction:UIAlertAction = UIAlertAction(title: "Camera",
                                                          style: UIAlertAction.Style.default,
                                                          handler:{
                                                           (action:UIAlertAction!) -> Void in
                                                           print("Camera")
                                                            
                                                            self.pickerController.sourceType = UIImagePickerController.SourceType.camera
                                                           
                                                            self.present(self.pickerController, animated: true, completion: nil)
           })
         
           let libraryAction:UIAlertAction = UIAlertAction(title: "Library",
                                                           style: UIAlertAction.Style.default,
                                                           handler:{
                                                               (action:UIAlertAction!) -> Void in
                                                               print("Library")
                                                            
                                                            self.pickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
                                                          
                                                            self.present(self.pickerController, animated: true, completion: nil)
           })
          
           actionSheet.addAction(cancelAction)
           actionSheet.addAction(cameraAction)
           actionSheet.addAction(libraryAction)
       
           present(actionSheet, animated: true, completion: nil)
       }
    
    

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        let pickedImage = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue)] as? UIImage
        mainImageView.image = pickedImage
        print("image 受け渡し成功")
        picker.dismiss(animated: true, completion: nil)
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func stampTapped(){
        //SegueのIdentifierを設定
        self.performSegue(withIdentifier: "ToStampList", sender: self)
    }
    
    @IBAction func deleteTapped(){
        //canvasViewのサブビューの数が1より大きかったら実行
        if canvasView.subviews.count > 1{
            //canvasViewの子ビューの最後のものを取り出す
            let lastStamp = canvasView.subviews.last! as! Stamp
            //canvasViewからlastStampを削除する
            lastStamp.removeFromSuperview()
            //lastStampが格納されているstampArrayのインデックス番号を取得
            if let index = appDelegate.stampArray.firstIndex(of: lastStamp){
                //stampArrayからlastStampを削除
                appDelegate.stampArray.remove(at: index)
            }
        }
    }
    
    @IBAction func saveTapped(){
           //画像コンテキストをサイズ、透過の有無、スケールを指定して作成
           UIGraphicsBeginImageContextWithOptions(canvasView.bounds.size, canvasView.isOpaque, 0.0)
           //canvasViewのレイヤーをレンダリング
           canvasView.layer.render(in: UIGraphicsGetCurrentContext()!)
           //レンダリングした画像を取得
           let image = UIGraphicsGetImageFromCurrentImageContext()
           //画像コンテキストを破棄
           UIGraphicsEndImageContext()
           //取得した画像をフォトライブラリへ保存
           UIImageWriteToSavedPhotosAlbum(image!, self, #selector(self.showResultOfSaveImage(_:didFinishSavingWithError:contextInfo:)), nil)
       }
    
    @objc func showResultOfSaveImage(_ image: UIImage, didFinishSavingWithError error: NSError!, contextInfo: UnsafeMutableRawPointer) {
        
        var title = "保存完了"
        var message = "カメラロールに保存しました"
        
        if error != nil {
            title = "エラー"
            message = "保存に失敗しました"
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // OKボタンを追加
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        // UIAlertController を表示
        self.present(alert, animated: true, completion: nil)
    }
    
    
    

    
    
    
    
}

