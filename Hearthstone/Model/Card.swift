//
//  Card.swift
//  Hearthstone
//
//  Created by Manthan Shah on 2018-06-01.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import Foundation
import UIKit

class Card {
    
    var name = String()
    var image = String()
    var type = String()
    var playerClass = String()
    
    static func parseCardJSON(data: Data) -> [Card] {
        
        var cardsArr = [Card]()
        
        do {
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            
            if let types = jsonResult as? Dictionary<String, Any> {
                for type in types {
                    if let cards = types[type.key] as? [Dictionary<String, Any>] {
                        for card in cards {
                            let newCard = Card()
                            
                            if let name = card["name"] as? String {
                                newCard.name = name
                            }
                            
                            if let type = card["type"] as? String {
                                newCard.type = type
                            }
                            
                            if let playerClass = card["playerClass"] as? String {
                                newCard.playerClass = playerClass
                            }
                            
                            if let image = card["img"] as? String {
                                newCard.image = image
                            }
                            
                            cardsArr.append(newCard)
                        }
                    }
                }
            }
        } catch let err {
            print(err)
        }
        
        return cardsArr
    }
    
}
