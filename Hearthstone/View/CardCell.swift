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
        // Load image async from URL in a background thread to prevent locking main thread.
        guard let url = URL(string: card.image) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("Failed fetching image:", error?.localizedDescription)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Not a proper HTTPURLResponse or statusCode")
                return
            }
            
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data!)
            }
        }.resume()
        
        self.nameLabel.text = card.name
        self.typeLabel.text = card.type
        self.playerClassLabel.text = card.playerClass
    }
    
}
