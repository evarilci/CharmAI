//
//  Chat.swift
//  CharmAI
//
//  Created by Eymen Varilci on 15.03.2023.
//

import Foundation

struct Chat {
    let isSender : Bool
    let messageID : UUID
    let date: Date
    let message : String
  
    
    
    init(data: [String : Any]) {
        self.isSender = data["isSender"] as? Bool ?? false
        self.messageID = data["id"] as! UUID
        self.message = data["message"] as? String ?? ""
        self.date = data["date"] as? Date ?? Date.now
    }
}



