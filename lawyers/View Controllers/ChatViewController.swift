//
//  ChatViewController.swift
//  lawyers
//
//  Created by apple on 7/31/20.
//  Copyright © 2020 hst. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseAuth


class ChatViewController: UIViewController {

    @IBOutlet weak var TABLEvIEW: UITableView!
    @IBOutlet weak var txtfMessage: UITextField!
    var chatList : [ChatViewModel] = [ChatViewModel]()
    var userId : String = ""
    var otherUserId : String = ""
    var id : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Database.database().reference().child("chats").child(Auth.auth().currentUser!.uid).child(self.otherUserId).observe(.childAdded, with: { (snap) in
        
        if snap.exists() {
                    let ch = snap.value as! [String: Any]
                    let mess = ch["message"] as? String
                    let id = ch["id"] as? String
                    self.chatList.append(ChatViewModel(message: mess!, sender: id!))
                }
               self.TABLEvIEW.reloadData()
                 let indexPath = IndexPath(row: self.chatList.count - 1, section: 0)
                 self.TABLEvIEW.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.bottom , animated: false)
            })
        
//
//       Database.database().reference().child("chats").child(Auth.auth().currentUser!.uid).child(self.otherUserId).observe(.childAdded, with: { (snapshot) in
//                        if let childDic = snapshot.value as? Dictionary<String, AnyObject>{
//
//                                        self.chatList.removeAll()
//                                        for child in childDic{
//                                            if let ch = child.value as? Dictionary<String, AnyObject>{
//
//
//                                            }
//                                        }
//                                    }
//                     self.TABLEvIEW.reloadData()
//
//                 }) { (error) in
//                     print(error.localizedDescription)
//                 }
//
        
    
        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionSendMessage(_ sender: Any) {
        if(self.txtfMessage.text == ""){
     //add alert view here gulzar
            print("please type message")
        }
        else{
            
            let chat = ["message": self.txtfMessage.text!, "id": Auth.auth().currentUser!.uid] as [String: Any]
            Database.database().reference().child("chats").child(Auth.auth().currentUser!.uid).child(self.otherUserId).childByAutoId().setValue(chat)
            
            Database.database().reference().child("chats").child(self.otherUserId).child(Auth.auth().currentUser!.uid).childByAutoId().setValue(chat)
            
            self.txtfMessage.text?.removeAll()
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

//MARK:- TABLE VIEW METHODS

extension ChatViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(self.chatList[indexPath.row].sender == Auth.auth().currentUser!.uid){
            let cell = tableView.dequeueReusableCell(withIdentifier: "SenderTableViewCell", for: indexPath) as! SenderTableViewCell
            cell.lblMessage.text = self.chatList[indexPath.row].message
            return cell
        }
        else{
           let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiverTableViewCell", for: indexPath) as! ReceiverTableViewCell
           cell.lblMessage.text = self.chatList[indexPath.row].message
           return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
