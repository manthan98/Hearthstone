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
        if (card.image == "no image") {
            self.imageView.image = UIImage(named: "no-image")
        } else {
            // Load image async from URL in a background thread to prevent locking main thread.
            guard let url = URL(string: card.image) else { return }
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.imageView.image = image
                        }
                    }
                }
            }
        }
        
        self.nameLabel.text = card.name
        self.typeLabel.text = card.type
        self.playerClassLabel.text = card.playerClass
        
        self.nameLabel.textColor = UIColor.white
        self.typeLabel.textColor = UIColor.white
        self.playerClassLabel.textColor = UIColor.white
    }
    
}
