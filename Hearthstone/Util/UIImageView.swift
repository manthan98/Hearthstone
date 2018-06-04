//
//  UIImageView.swift
//  Hearthstone
//
//  Created by Manthan Shah on 2018-06-04.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
    func imageFromServerURL(urlString : String) {
        let url = URL(string: urlString)
        self.image = nil
        
        // Check cached image.
        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = cachedImage
            return
        }
        
        // If not, download image from url.
        // Load image async to prevent locking main thread.
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url!) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        imageCache.setObject(image, forKey: urlString as NSString)
                        self?.image = image
                    }
                }
            }
        }
    }
}
