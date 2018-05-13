//
//  Room.swift
//  MyFirebaseApp
//
//  Created by Narumol Pugkhem on 5/8/18.
//  Copyright © 2018 Narumol Pugkhem. All rights reserved.
//

import Foundation

struct Room {
  var name: String
  var key: String
  var json: [String: Any]
  
  init(name: String, key: String) {
    self.name = name
    self.key = key
    self.json = ["name": name] as [String: Any]
  }
}

struct Chat {
  var message: String
  var userName: String
  var json: [String:Any]
  
  init(message: String, userName: String) {
    self.message = message
    self.userName = userName
    self.json = ["message": message, "userName" : userName]
  }
}
