//
//  ViewController.swift
//  Todo
//
//  Created by Aye Thu Thu Zaw on 2020/06/22.
//  Copyright © 2020 ALJ. All rights reserved.
//

import UIKit
import RealmSwift


class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView! // TableView
     // Realm Todoアイテムコレクション
     var todoItems:Results<ToDo>? {
         do {
             let realm = try! Realm()
             
             print(realm.objects(ToDo.self))
             return realm.objects(ToDo.self).sorted(byKeyPath: "createDate")
         } catch {
             print("エラー")
         }
         return nil
     }
     
     
     var actionType = ""
     var selectedTodo:ToDo!

     override func viewDidLoad() {
         super.viewDidLoad()
         tableView.dataSource = self
         tableView.delegate = self
     }
     
     override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         
         tableView.reloadData()
     }
     
     
     @IBAction func addButtonTapped(sender: Any) {
         self.actionType = "NEW"
         self.performSegue(withIdentifier: "toDetail", sender: nil)
     }
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "toDetail" {
             let vc = segue.destination as! TodoDetailViewController
             vc.actionType = self.actionType
             vc.selectedTodo = selectedTodo
         }
     }
     
     func numberOfSections(in tableView: UITableView) -> Int {
         return 1
     }
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return todoItems!.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
         let toDo = todoItems?[indexPath.row]
         cell.textLabel?.text = toDo?.name
         return cell
     }
     //編集
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         self.actionType = "UPDATE"
         selectedTodo = todoItems?[indexPath.row]
         self.performSegue(withIdentifier: "toDetail", sender: selectedTodo)
     }
   

}

