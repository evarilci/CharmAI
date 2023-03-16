//
//  ChatViewModel.swift
//  CharmAI
//
//  Created by Eymen Varilci on 15.03.2023.
//

import UIKit

protocol ViewModelDelegate: AnyObject {
    
    
}

protocol ViewModelProtocol {
    var delegate : ViewModelDelegate? {get set}
    func numberOfRows() -> Int
    func chatForRow(at indexPath: Int) -> Chat
}

class ChatViewModel: ViewModelProtocol {
    var delegate: ViewModelDelegate?
    
    var messages = [Chat(data: ["isSender" : true, "id" : UUID(), "date" : Date().timeIntervalSince1970, "message": "This is my prompt" ]), Chat(data: ["isSender" : false, "id" : UUID(), "date" : Date().timeIntervalSince1970, "message": "This is ai message" ]), Chat(data: ["isSender" : true, "id" : UUID(), "date" : Date().timeIntervalSince1970, "message": "This is my promptThis is my promptThis is my promptThis is my promptThis is my promptThis is my promptThis is my promptThis is my promptThis is my prompt" ]), Chat(data: ["isSender" : false, "id" : UUID(), "date" : Date().timeIntervalSince1970, "message": "This is ai messageThis is ai messageThis is ai messageThis is ai messageThis is ai messageThis is ai messageThis is ai messageThis is ai messageThis is ai messageThis is ai messageThis is ai messageThis is ai messageThis is ai messageThis is ai messageThis is ai messageThis is ai messageThis is ai messageThis is ai messageThis is ai messageThis is ai messageThis is ai messageThis is ai messageThis is ai message"])]

    
    func numberOfRows() -> Int {
        return messages.count
    }
    func chatForRow(at indexPath: Int) -> Chat {
        messages[indexPath]
    }
    
}

