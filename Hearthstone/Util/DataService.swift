//
//  DataService.swift
//  Hearthstone
//
//  Created by Manthan Shah on 2018-06-01.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import Foundation

protocol DataServiceDelegate: class {
    func cardsLoaded()
}

class DataService {
    
    static let shared = DataService()
    weak var delegate: DataServiceDelegate?
    
    var cards = [Card]()
    
    func getAllCards() {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        let key = "lpKU2LSInKmshG16oNyak484VUOup1B1yThjsnU8mrrnRmvleN"
        
        guard let url = URL(string: "https://omgvamp-hearthstone-v1.p.mashape.com/cards") else { return }
        var request = URLRequest(url: url)
        request.setValue(key, forHTTPHeaderField: "X-Mashape-Key")
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if (error == nil) {
                // Success.
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL session task completed: \(statusCode)")
                
                if let data = data {
                    self.cards = Card.parseCardJSON(data: data)
                    self.delegate?.cardsLoaded()
                }
            } else {
                // Failure.
                print("URL session task failed: \(error?.localizedDescription).")
            }
        }
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
}
