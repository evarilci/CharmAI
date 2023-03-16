//
//  ChatViewModel.swift
//  CharmAI
//
//  Created by Eymen Varilci on 15.03.2023.
//

import UIKit
import OpenAISwift

protocol ViewModelDelegate: AnyObject {
    
    func responseSuccess()
}

protocol ViewModelProtocol {
    var delegate : ViewModelDelegate? {get set}
    func numberOfRows() -> Int
    func chatForRow(at indexPath: Int) -> Chat
    func getResponse(input: String, completion: @escaping(Result<String,Error>) -> Void)
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
        let sender = Chat(data: ["isSender" : true, "id": UUID(), "date": Date().timeIntervalSince1970, "message": input])
        self.messages.append(sender)
        client.sendCompletion(with: input, maxTokens: 500, temperature: 1,  completionHandler: { result in
            switch result {
            case .success(let model):
                let output = model.choices.first?.text ?? "hello"
                let newOutput = output.trimmingCharacters(in: .whitespacesAndNewlines)
                let chat = Chat(data: ["isSender" : false, "id": UUID(), "date": Date().timeIntervalSince1970, "message": newOutput])
                self.messages.append(chat)
               
                completion(.success(newOutput))
              
            case .failure(let error):
                completion(.failure(error))
                print(error.localizedDescription)
                
            }
        })
    }
       
    func numberOfRows() -> Int {
        return messages.count
    }
    func chatForRow(at indexPath: Int) -> Chat {
        messages[indexPath]
    }
}

