//
//  UIDatePicker+Chain.swift
//  CocoaChainKit
//
//  Created by GorXion on 2018/5/15.
//

public extension Chain where Base: UIDatePicker {
    
    @discardableResult
    func datePickerMode(_ datePickerMode: UIDatePickerMode) -> Chain {
        base.datePickerMode = datePickerMode
        return self
    }
    
    @discardableResult
    func locale(_ locale: Locale?) -> Chain {
        base.locale = locale
        return self
    }
    
    @discardableResult
    func calendar(_ calendar: Calendar) -> Chain {
        base.calendar = calendar
        return self
    }
    
    @discardableResult
    func timeZone(_ timeZone: TimeZone?) -> Chain {
        base.timeZone = timeZone
        return self
    }
    
    @discardableResult
    func date(_ date: Date) -> Chain {
        base.date = date
        return self
    }
    
    @discardableResult
    func minimumDate(_ minimumDate: Date?) -> Chain {
        base.minimumDate = minimumDate
        return self
    }
    
    @discardableResult
    func maximumDate(_ maximumDate: Date?) -> Chain {
        base.maximumDate = maximumDate
        return self
    }
    
    @discardableResult
    func countDownDuration(_ countDownDuration: TimeInterval) -> Chain {
        base.countDownDuration = countDownDuration
        return self
    }
    
    @discardableResult
    func minuteInterval(_ minuteInterval: Int) -> Chain {
        base.minuteInterval = minuteInterval
        return self
    }
}
