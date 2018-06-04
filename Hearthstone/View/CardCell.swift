//
//  CardCell.swift
//  Hearthstone
//
//  Created by Manthan Shah on 2018-06-01.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import UIKit

class CardCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var playerClassLabel: UILabel!
    
    public func configureCell(card: Card) {
        self.nameLabel.text = card.name
        self.typeLabel.text = card.type
        self.playerClassLabel.text = card.playerClass
        
        if (card.image != "") {
            self.imageView.imageFromServerURL(urlString: card.image)
        } else {
            self.imageView.image = UIImage(named: "no-image")
        }
        
        self.nameLabel.textColor = UIColor.white
        self.typeLabel.textColor = UIColor.white
        self.playerClassLabel.textColor = UIColor.white
    }
    
}
