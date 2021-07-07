//
//  Date+.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/14.
//

import Foundation

extension Date {
    
    static let koreaTimeZone = TimeZone(abbreviation: "KST")!
    
    private var calendar: Calendar {
        var calendar = Calendar.current
        calendar.timeZone = Date.koreaTimeZone
        return calendar
    }
    
    func month() -> Int {
        return self.get(.month)
    }
    
    func get(_ type: Calendar.Component) -> String {
        let calendar = Calendar.current
        let result = calendar.component(type, from: self)
        return (result < 10 ? "0\(result)" : result.description)
    }
    
    func get(_ type: Calendar.Component) -> Int {
        let calendar = Calendar.current
        let result = calendar.component(type, from: self)
        return result
    }
    
    func toString(format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.autoupdatingCurrent
        return formatter.string(from: self)
    }
    
    func toStringKST(format: String ) -> String {
        return self.toString(format: format)
    }
    
    static var currentTimeStamp: Int64 {
        return Int64(Date().timeIntervalSince1970 * 1000)
    }
}
