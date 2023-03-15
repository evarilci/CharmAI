//
//  ChatViewModel.swift
//  CharmAI
//
//  Created by Eymen Varilci on 15.03.2023.
//

import UIKit


struct ChatViewModel {
    private let chat : Chat
    init(chat: Chat) {
        self.chat = chat
    }

    var chatBackgroundColor: UIColor {
        return chat.isSender ? .accentColor : .receivedMessage
    }
    var isCurrentUser : Bool {
        return chat.isSender
    }
}


