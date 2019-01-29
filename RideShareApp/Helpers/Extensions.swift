//
//  Extensions.swift
//  
//
//  Created by Harjeet  on 1/28/19.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension RideTableViewCell {
    
    func loadImagesUsingCacheUrlString(urlString: String) {
        
        
        let tempUrlString = urlString
        let urlString = NSURL(string: tempUrlString)
        
        
        if let cachedImage = imageCache.object(forKey: urlString!) as? UIImage {
            self.imageU.image = cachedImage
            return
        }
        
        
        let sharedSession = URLSession.shared
        let request = URLRequest(url: urlString! as URL)
        
        // Create Data Task
        
        let dataTask = sharedSession.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    
                    imageCache.setObject(image, forKey: urlString!)
                    self.imageU.image = image
                }
            }
        })
        
        dataTask.resume()
        }
    }

