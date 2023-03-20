//
//  ChatViewModel.swift
//  CharmAI
//
//  Created by Eymen Varilci on 15.03.2023.
//

import UIKit
import OpenAISwift
import CoreData

protocol ViewModelDelegate: AnyObject {
    
    func responseSuccess()
}

protocol ViewModelProtocol {
    var delegate : ViewModelDelegate? {get set}
    func numberOfRows() -> Int
    func chatForRow(at indexPath: Int) -> Chat
    func getResponse(input: String, completion: @escaping(Result<String,Error>) -> Void)
    func saveChat(chate: Chat)
    func fetchChat()
    func isPremium() -> Bool
}

class ChatViewModel: ViewModelProtocol {
    var delegate: ViewModelDelegate?
    private var client = OpenAISwift(authToken: K.APIKey)
   
    var messages = [Chat(data: ["isSender" : false, "id": UUID(), "date": Date().timeIntervalSince1970 as Double, "message" : "Hello, my name is CharmAI. How can i help you?"])] {
        didSet {
            delegate?.responseSuccess()
        }
    }
    func getResponse(input: String, completion: @escaping(Result<String,Error>) -> Void) {
        let senderID = UUID().uuidString
        let sender = Chat(data: ["isSender" : true, "id": senderID, "date": Date().timeIntervalSince1970 as Double, "message": input])
    saveChat(chate: sender)
        self.messages.append(sender)
        client.sendCompletion(with: input, maxTokens: 500, temperature: 1,  completionHandler: { [weak self] result in
            switch result {
            case .success(let model):
                let output = model.choices.first?.text ?? "hello"
                let newOutput = output.trimmingCharacters(in: .whitespacesAndNewlines)
                let responseID = UUID().uuidString
                let chat = Chat(data: ["isSender" : false, "id": responseID, "date": Date().timeIntervalSince1970 as Double, "message": newOutput])
                self?.saveChat(chate: chat)
                self?.messages.append(chat)
                completion(.success(newOutput))
                self?.delegate?.responseSuccess()
                
            case .failure(let error):
                completion(.failure(error))
               
            }
        })
    }
    
    func saveChat(chate: Chat) {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<ChatEntity> = ChatEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", chate.message)
        do {
            let existingChats = try context.fetch(fetchRequest)
            if let existingChat = existingChats.first {
                // A ChatEntity object with the same message already exists
                print("Chat already exists with message: \(existingChat.message ?? "")")
                return
            }
            // Insert a new ChatEntity object with the provided chat data
            let chat = NSEntityDescription.insertNewObject(forEntityName: "ChatEntity", into: context) as! ChatEntity
            chat.message = chate.message
            chat.id = chate.messageID
            chat.isSender = chate.isSender
            try context.save()
            print("Chat saved successfully")
        } catch {
            print("Error saving chat: \(error.localizedDescription)")
        }
    }
    func isPremium() -> Bool {
        let arr = messages.filter({$0.isSender == false})
        if arr.count >= 5 {
            print("have to pay")
            return false
        }
        return true
    }
    
    func fetchChat() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ChatEntity")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
            var chat : Chat!
            var dict : [String : Any]!
            
            for result in results as! [NSManagedObject] {
                let message = result.value(forKey: "message") as? String ?? ""
                let id = result.value(forKey: "id") as? String ?? ""
                let isSender =  result.value(forKey: "isSender") as? Bool ?? false
        
                dict = ["message":message,"id":id,"date": Date().timeIntervalSince1970,"isSender":isSender]
                chat = Chat(data: dict)
                self.messages.append(chat)
            }
            
        } catch  {
            print(error.localizedDescription)
        }
    }
       
    func numberOfRows() -> Int {
        return messages.count
    }
    func chatForRow(at indexPath: Int) -> Chat {
        messages[indexPath]
    }
}
