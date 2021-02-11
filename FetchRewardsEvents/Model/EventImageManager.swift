//
//  EventImageManager.swift
//  FetchRewardsEvents
//
//  Created by Mohana G on 2/10/21.
//

import UIKit

var imageCache = NSCache<AnyObject, AnyObject>()

class EventImageManager: UIImageView {
    var image_url: String?
    func fetchEventImageFromURL(imageURLString: String) {
        image_url = imageURLString
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: imageURLString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        if let imageURL = URL(string: imageURLString){
            let session = URLSession(configuration: .default)
            session.dataTask(with: imageURL) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                } else {
                    if let safeData = data {
                        if let imageToCache = UIImage(data: safeData) {
                            if let uString = self.image_url, uString == imageURLString {
                              DispatchQueue.main.async {
                                self.image = imageToCache
                            }
                            }
                            
                            imageCache.setObject(imageToCache, forKey: imageURLString as AnyObject)
                        }
                        
                        
                    }
                }
                
            }.resume()
        }
    }
}






