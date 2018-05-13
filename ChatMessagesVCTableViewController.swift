//
//  ChatMessagesVCTableViewController.swift
//  MyFirebaseApp
//
//  Created by Narumol Pugkhem on 5/8/18.
//  Copyright © 2018 Narumol Pugkhem. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuthUI
import FirebaseGoogleAuthUI

class ChatMessagesVCTableViewController: UITableViewController {
  
  var key: String!
  var data: String?
  var chats = [Chat]()
  var thisRoomName: String = ""
  var room: Room?
  
  private lazy var ref = {
    Database.database().reference()
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = self.title
    
    let rightButton = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addChat))
    navigationItem.setRightBarButton(rightButton, animated: true)
  }
  
  @objc
  func addChat() {

    let chatkey = ref.child("Rooms").child(self.key).child("chats").childByAutoId().key
    let chatRef = ref.child("Rooms").child(self.key).child("chats").child(chatkey)

    let alert = UIAlertController(title: "Added Message", message: nil, preferredStyle: UIAlertControllerStyle.alert)

    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
      let text = alert.textFields?.first?.text
      let chat = Chat(message: text!, userName: "Ohmy Pugkhem")
      chatRef.setValue(chat.json)
      self.tableView.reloadData()
    }))
    
    alert.addTextField { _ in
    }
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    present(alert, animated: true, completion: nil)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    setRoomTitle()
    readChats()
  }
  
  func setRoomTitle() {
    self.ref.child("Rooms").child(key).observeSingleEvent(of: .value) { snapShot in
      if let element = snapShot.value as? [String:Any], let name = element["name"] as? String {
        self.thisRoomName = name
        self.navigationItem.title = name
      }
    }
  }
  
  /// Reads chats from each room and update tableview
  func readChats() {
    
    self.ref.child("Rooms").child(key).child("chats").observe(.childAdded) { (snapShot) in
      guard let eachChat = snapShot.value as? [String: Any] else { return }
      let chat = Chat(message: eachChat["message"] as! String, userName: eachChat["userName"] as! String)
      print("chat, \(chat)")
      
      self.chats.append(chat)
      print(self.chats)
      self.tableView.reloadData()
    }
  }
  
  // MARK: - Table view data source
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return chats.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChatTableViewCell
    
    guard chats.count > 0 else {
      return cell
    }
    
    let chat = chats[indexPath.row]
    cell.userName?.text = "@\(chat.userName)"
    cell.message?.text = chat.message

    guard let title = self.title else { return cell }

    let imageName = imageNameFor(cell.userName.text!)
    cell.userImageView.image = UIImage.init(named: imageName)
   
    return cell
  }
  
  func imageNameFor(_ title: String) -> String {
    if title.lowercased().range(of: "joey") != nil {
      return "spidy"
    } else if title.lowercased().range(of: "shivali") != nil {
      return "superwoman"
    } else if title.lowercased().range(of: "ohmy") != nil {
      return "moana"
    }
    return "spidy"
  }
  
  /*
   // Override to support conditional editing of the table view.
   override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the specified item to be editable.
   return true
   }
   */
  
  /*
   // Override to support editing the table view.
   override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
   if editingStyle == .delete {
   // Delete the row from the data source
   tableView.deleteRows(at: [indexPath], with: .fade)
   } else if editingStyle == .insert {
   // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
   }
   }
   */
  
  /*
   // Override to support rearranging the table view.
   override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
   
   }
   */
  
  /*
   // Override to support conditional rearranging of the table view.
   override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the item to be re-orderable.
   return true
   }
   */
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}


