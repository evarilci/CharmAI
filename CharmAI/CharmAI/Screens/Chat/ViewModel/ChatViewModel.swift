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
}

class ChatViewModel: ViewModelProtocol {
    var delegate: ViewModelDelegate?
    private var client = OpenAISwift(authToken: K.APIKey)
    var messages = [Chat]() {
        didSet {
           
            self.delegate?.responseSuccess()
            
        }
    }

    func getResponse(input: String, completion: @escaping(Result<String,Error>) -> Void) {
        let sender = Chat(data: ["isSender" : true, "id": UUID(), "date": Date().timeIntervalSince1970 as Double, "message": input])
    //    self.saveChat(chate: sender)
        self.messages.append(sender)
        client.sendCompletion(with: input, maxTokens: 500, temperature: 1,  completionHandler: { result in
            switch result {
            case .success(let model):
                let output = model.choices.first?.text ?? "hello"
                let newOutput = output.trimmingCharacters(in: .whitespacesAndNewlines)
                let chat = Chat(data: ["isSender" : false, "id": UUID(), "date": Date().timeIntervalSince1970 as Double, "message": newOutput])
             //   self.saveChat(chate: chat)
                self.messages.append(chat)
                completion(.success(newOutput))
                
            case .failure(let error):
                completion(.failure(error))
               
            }
        })
    }
    
    func saveChat(chate: Chat) {
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let chat = NSEntityDescription.insertNewObject(forEntityName: "ChatEntity", into: context)
        chat.setValue(chate.message, forKey: "message")
        chat.setValue(chate.messageID, forKey: "id")
       // chat.setValue(chate.date, forKey: "date")
        chat.setValue(chate.isSender, forKey: "isSender")
        
        
        
//        for i in chate {
//            chat.setValue(i.message, forKey: "message")
//            chat.setValue(i.messageID, forKey: "id")
//            chat.setValue(i.date, forKey: "date")
//            chat.setValue(i.isSender, forKey: "isSender")
//        }
        do {
            try context.save()
            print("success")
        } catch {
            print(error.localizedDescription)
        }


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
                let id = result.value(forKey: "id") as? UUID ?? UUID()
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

