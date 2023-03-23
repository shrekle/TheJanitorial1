//
//  TextHelper.swift
//  chatAppCWC
//
//  Created by adrian garcia on 3/16/23.
//

import Foundation

class TextHelper {
    
    static func sanitizePhoneNumber(_ phone: String)-> String {
        return phone
            .replacingOccurrences(of: "(", with: "")
            .replacingOccurrences(of: ")", with: "")
            .replacingOccurrences(of: "-", with: "")
            .replacingOccurrences(of: " ", with: "")
    }
    
    //https://stackoverflow.com/questions/56476007/swiftui-textfield-max-length
    static func limitText(_ stringvar: inout String, _ limit: Int) {
        if (stringvar.count > limit) {
            stringvar = String(stringvar.prefix(limit))
        }
    }
    
    //https://stackoverflow.com/questions/32364055/formatting-phone-number-in-swift
    static func applyPatternOnNumbers(_ stringvar: inout String, pattern: String, replacementCharacter: Character) {
        
        var pureNumber = stringvar.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
        
        for index in 0 ..< pattern.count { // will be the #'s
            guard index < pureNumber.count else { stringvar = pureNumber; return }
            
            let characterIndex = String.Index(utf16Offset: index, in: pattern) // A position of a character/Index  in a string
            let patternCharacter = pattern[characterIndex] // it will specify which of deez characters ,+# (###) ###-####, based on the current index of the loop
            
            guard patternCharacter != replacementCharacter else { continue }
            
            pureNumber.insert(patternCharacter, at: characterIndex) // as soon as you type something in the pureNumber, it gets replaced with "" (like a regex doo doo)
        }
 
        stringvar = pureNumber
        
        if (stringvar.count > 17) {
            stringvar = String(stringvar.prefix(17))
        }
    }
    
}
