//
//  UIImageView+imageFromServerURL.swift
//  itunesAPIVIPER
//
//  Created by José Carlos Yebes Torres on 15/10/17.
//  Copyright © 2017 José Carlos Yebes Torres. All rights reserved.
//

import UIKit

extension UIImageView {
    public func imageFromServerURL(url: URL) {
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error.debugDescription)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }
    
}
