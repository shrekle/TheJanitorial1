//
//  TextHelper.swift
//  chatAppCWC
//
//  Created by adrian garcia on 3/16/23.
//

import Foundation

class TextHelper {
    
    static func sanitizeEmail(_ email: String)-> String {
        return email.replacingOccurrences(of: " ", with: "")
    }
}


