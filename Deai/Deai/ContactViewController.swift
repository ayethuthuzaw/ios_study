//
//  ContactViewController.swift
//  Deai
//
//  Created by Aye Thu Thu Zaw on 2020/06/23.
//  Copyright © 2020 ALJ. All rights reserved.
//

import UIKit
import NCMB

class ContactViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var objects = [NCMBObject]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
           self.fetchUsers()
       }
    
    func fetchUsers(){
        let query = NCMBQuery(className: "Action")
        query?.whereKey("from", equalTo: NCMBUser.current())
        query?.whereKey("acceptedOrRejected", equalTo: "accepted")
        query?.includeKey("to")
        query?.findObjectsInBackground({(objects, error) in
            if error != nil {
                print("取得失敗:\(String(describing: error))")
            } else {
                print("取得成功:\(String(describing: objects))")
                self.objects = objects as! [NCMBObject]
                self.tableView.reloadData()
            }
        })
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let toUser = self.objects[indexPath.row].object(forKey: "to") as! NCMBUser
        cell.textLabel!.text = toUser.userName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let toUser = self.objects[indexPath.row].object(forKey: "to") as! NCMBUser
        self.performSegue(withIdentifier: "toUserDetail", sender: toUser)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toUserDetail" {
            let vc = segue.destination as! UserDetailViewController
            vc.user = sender as! NCMBUser
        }
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
