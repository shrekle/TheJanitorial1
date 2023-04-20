//
//  DateHelper.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 4/18/23.
//

import Foundation


class DateHelper {
    
    static func TaskTimestampHourFrom(date: Date?)-> String {
        
        guard let date else { print("😈 dateHelper is homo"); return "" }
        
        let df = DateFormatter()
        
        df.dateFormat = "h:mm a"
        
        return df.string(from: date)
    }
    
    static func TaskTimestampDateFrom(date: Date?)-> String {
        
        guard let date else { print("😈 dateHelper is homo"); return "" }
        
        let df = DateFormatter()
        
        df.dateFormat = "M/d"
        
        return df.string(from: date)
    }
    
}

