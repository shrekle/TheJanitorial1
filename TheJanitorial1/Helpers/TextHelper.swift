//
//  TextHelper.swift
//  chatAppCWC
//
//  Created by adrian garcia on 3/16/23.
//

import Foundation

struct TextHelper { // i switched this from a class to a struct, seems to work eigther way
    
    static func sanitizeEmail(_ email: String)-> String {
        return email.replacingOccurrences(of: " ", with: "")
    }
}


