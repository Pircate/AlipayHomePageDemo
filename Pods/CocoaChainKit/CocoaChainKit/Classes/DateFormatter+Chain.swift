//
//  DateFormatter+Chain.swift
//  CocoaChainKit
//
//  Created by GorXion on 2018/5/9.
//

public extension Chain where Base: DateFormatter {
    
    @discardableResult
    func dateFormat(_ dateFormat: String) -> Chain {
        base.dateFormat = dateFormat
        return self
    }
    
    @discardableResult
    func dateStyle(_ dateStyle: DateFormatter.Style) -> Chain {
        base.dateStyle = dateStyle
        return self
    }
    
    @discardableResult
    func timeStyle(_ timeStyle: DateFormatter.Style) -> Chain {
        base.timeStyle = timeStyle
        return self
    }
    
    @discardableResult
    func locale(_ locale: Locale) -> Chain {
        base.locale = locale
        return self
    }
    
    @discardableResult
    func generatesCalendarDates(_ generatesCalendarDates: Bool) -> Chain {
        base.generatesCalendarDates = generatesCalendarDates
        return self
    }
    
    @discardableResult
    func formatterBehavior(_ formatterBehavior: DateFormatter.Behavior) -> Chain {
        base.formatterBehavior = formatterBehavior
        return self
    }
    
    @discardableResult
    func timeZone(_ timeZone: TimeZone) -> Chain {
        base.timeZone = timeZone
        return self
    }
    
    @discardableResult
    func calendar(_ calendar: Calendar) -> Chain {
        base.calendar = calendar
        return self
    }
}
