//
//  DateFormatter+Extension.swift
//  PershinTestApp
//
//  Created by Sergey Pershin on 14.04.2021.
//

import Foundation


extension DateFormatter {
    static private var cachedFormatters = [String: DateFormatter]()
    static private let lock = NSLock()
    
    static func formatDateToString(_ date: Date, with format: String) -> String {
        let formatter: DateFormatter

        lock.lock()
        if let existingFormatter = self.cachedFormatters[format] {
            formatter = existingFormatter
        } else {
            formatter = DateFormatter()
            formatter.dateFormat = format
            self.cachedFormatters[format] = formatter
        }
        lock.unlock()
        
        return formatter.string(from: date)
    }
    
    static func formatStringToDate(_ dateString: String, with format: String) -> Date? {
        let formatter: DateFormatter

        lock.lock()
        if let existingFormatter = self.cachedFormatters[format] {
            formatter = existingFormatter
        } else {
            formatter = DateFormatter()
            formatter.dateFormat = format
            self.cachedFormatters[format] = formatter
        }
        lock.unlock()
        
        return formatter.date(from: dateString)
    }
}
