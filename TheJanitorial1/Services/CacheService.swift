//
//  CacheService.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 4/11/23.
//

import SwiftUI

struct CacheService {
        
        // key will be the URL and the value is the image
        static private var imageCache = [String: Image]()
        
       static func getImage(forKey: String)-> Image? {
            return imageCache[forKey]
        }
        
        static func setImage(image: Image, forKey: String) {
            imageCache[forKey] = image
        }
    }


