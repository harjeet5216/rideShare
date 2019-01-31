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

extension Date {
    
    func timeAgoSinceDate() -> String {
        
        // From Time
        let fromDate = self
        
        // To Time
        let toDate = Date()
        
        // Estimation
        // Year
        if let interval = Calendar.current.dateComponents([.year], from: fromDate, to: toDate).year, interval > 0  {
            
            return interval == 1 ? "\(interval)" + " " + "year ago" : "\(interval)" + " " + "years ago"
        }
        
        // Month
        if let interval = Calendar.current.dateComponents([.month], from: fromDate, to: toDate).month, interval > 0  {
            
            return interval == 1 ? "\(interval)" + " " + "month ago" : "\(interval)" + " " + "months ago"
        }
        
        // Day
        if let interval = Calendar.current.dateComponents([.day], from: fromDate, to: toDate).day, interval > 0  {
            
            return interval == 1 ? "\(interval)" + " " + "day ago" : "\(interval)" + " " + "days ago"
        }
        
        // Hours
        if let interval = Calendar.current.dateComponents([.hour], from: fromDate, to: toDate).hour, interval > 0 {
            
            return interval == 1 ? "\(interval)" + " " + "hour ago" : "\(interval)" + " " + "hours ago"
        }
        
        // Minute
        if let interval = Calendar.current.dateComponents([.minute], from: fromDate, to: toDate).minute, interval > 0 {
            
            return interval == 1 ? "\(interval)" + " " + "minute ago" : "\(interval)" + " " + "minutes ago"
        }
        
        return "a moment ago"
    }
}
