//
//  ViewController.swift
//  MyFirebaseApp
//
//  Created by Narumol Pugkhem on 5/7/18.
//  Copyright © 2018 Narumol Pugkhem. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuthUI
import FirebaseGoogleAuthUI
//import FirebaseDatabaseUI

class MyTableViewController: UITableViewController {

  var authUI:FUIAuth!
  var model = [Any]()

  private lazy var ref = {
    Database.database().reference()
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Hi There"

    authUI = FUIAuth.defaultAuthUI()
    let signInproviders = [FUIGoogleAuth()]
    
    authUI?.providers = signInproviders
    authUI?.delegate = self

    var ref: DatabaseReference
    ref = Database.database().reference()

//    let key = ref.child("Rooms").childByAutoId().key
//    let myRoom = Room(name: "Ohmy's room", key: key)
//    ref.child("Rooms").child(key).setValue(myRoom.json)
//
    // Read data
    readRooms()
    
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
//    let authViewController = authUI?.authViewController()
//    present(authViewController!, animated: true, completion: nil)
  }
  
//  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    if segue.identifier == "toChatMessage" {
//      let vc = segue.destination as! ChatMessagesVCTableViewController
//      let row = tableView.indexPathForSelectedRow?.row
//      vc.title = (model[row!] as! Room).name
//    }
//  }
  
  func readRooms() {
    
    ref.child("Rooms").observeSingleEvent(of: .value) { snapShot in
      let rooms = snapShot.value as! NSDictionary
      
      for room in rooms {
        let key = room.key
        let name = room.value as! [String:Any]
        let roomName = name["name"]
        
        let eachRoom = Room(name: roomName as! String, key: key as! String)
        self.model.append(eachRoom)
        
        print("roomName", roomName!, "key", key)
      }
      self.tableView.reloadData()
    }
  }
}

extension MyTableViewController {
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return model.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    let room = model[indexPath.row] as? Room
    cell.textLabel?.text = room?.name
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let chatVC = storyboard?.instantiateViewController(withIdentifier: "chatMessageVC") as? ChatMessagesVCTableViewController
    let room = model[indexPath.row] as! Room
    chatVC?.title = room.name
    chatVC?.key = room.key
    chatVC?.room = room
    navigationController?.pushViewController(chatVC!, animated: true)
  }
}

extension MyTableViewController: FUIAuthDelegate {
  internal func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
    
    guard error == nil, let user = user else { return }
    let email = user.email
    let name = user.displayName
    print(" I am signed in +++++++++++++++ ", email, name )

  }
  
  func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
    guard error == nil, let result = authDataResult else { return }
    print("++++++++++ result \(result.user)")
  }
}







