//
//  TodoDetailViewController.swift
//  Todo
//
//  Created by Aye Thu Thu Zaw on 2020/06/22.
//  Copyright © 2020 ALJ. All rights reserved.
//

import UIKit
import RealmSwift

class TodoDetailViewController: UIViewController {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var commitButton: UIButton!
    @IBOutlet weak var trashButton: UIBarButtonItem!
    
    var actionType = ""
    var selectedTodo:ToDo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.initView()
    }
    
    func initView() {
        if actionType == "NEW" {
            self.title = "TODO新規追加"
            self.commitButton.setTitle("新規追加", for: .normal)
            self.commitButton.addTarget(self, action: #selector(dbAdd(_:)), for: .touchUpInside)
            self.titleField.text = ""
            self.descTextView.text = ""
            self.navigationItem.rightBarButtonItem = nil
        } else if actionType == "UPDATE" {
            self.title = "TODO編集"
            self.commitButton.setTitle("更新", for: .normal)
            self.commitButton.addTarget(self, action: #selector(dbUpdate(_:)), for: .touchUpInside)
            self.titleField.text = selectedTodo.name
            self.descTextView.text = selectedTodo.desc
        }
    }
    
    //ToDo追加
    @objc func dbAdd(_ sender: UIButton) {
        //入力チェック
        if isValidateInputContents() == false {return}
        //データ
        let toDo = ToDo()
        toDo.name = titleField.text!
        toDo.desc = descTextView.text!
        toDo.createDate = NSDate()//時間をセット
        print(toDo.name)

        do {
            let realm = try! Realm()
            print(toDo)
            try! realm.write {realm.add(toDo)}
            print("DB登録成功")
        } catch {
            print("DB登録失敗")
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    //入力チェック
    private func isValidateInputContents() -> Bool {
        //名前の入力
        if let title = titleField.text {
            if title.count == 0 {return false}
        } else {
            return false
        }
        
        return true
    }
    
    //DB更新
    @objc func dbUpdate(_ sender: UIButton) {
        do {
            let realm = try Realm()
            try realm.write {
                selectedTodo.name = self.titleField.text!
                selectedTodo.desc = self.descTextView.text!
                selectedTodo.updateDate = NSDate()
            }
            print("DB更新成功")
        } catch {
            print("DB更新失敗")
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dbDelete(_ sender: Any) {
        do {
            let realm = try Realm()
            try realm.write {realm.delete(selectedTodo)}
        } catch {
            print("失敗")
        }
        
        self.navigationController?.popViewController(animated: true)
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
