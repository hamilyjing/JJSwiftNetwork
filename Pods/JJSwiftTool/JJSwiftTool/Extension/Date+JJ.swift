//
//  Date+JJ.swift
//  PANewToapAPP
//
//  Created by jincieryi on 16/9/20.
//  Copyright © 2016年 PingAn. All rights reserved.
//

import Foundation

extension Date {
    // MARK: Date comparison
    
    public func jjs_isToday() -> Bool {
        return self.isEqualToDateIgnoringTime(Date())
    }
    
    public func jjs_isSameMonthAsDate(_ date: Date) -> Bool {
        return self.jjs_month == date.jjs_month
    }
    
    public func jjs_isSameYearAsDate(_ date: Date) -> Bool {
        return self.jjs_year == date.jjs_year
    }
    
    public func jjs_isThisYear() -> Bool {
        return self.jjs_isSameYearAsDate(Date())
    }
    
    public func jjs_isNextYear() -> Bool {
        return (self.jjs_year == Date().jjs_year + 1)
    }
    
    public func jjs_isLastYear() -> Bool {
        return (self.jjs_year == Date().jjs_year - 1)
    }
    
    public func jjs_isEarlierThanDate(_ date: Date) -> Bool {
        return (self as NSDate).earlierDate(date) == self
    }
    
    public func jjs_isLaterThanDate(_ date: Date) -> Bool {
        return (self as NSDate).laterDate(date) == self
    }
    
    public func jjs_isInFuture() -> Bool {
        return self.jjs_isLaterThanDate(Date())
    }
    
    public func jjs_isInPast() -> Bool {
        return self.jjs_isEarlierThanDate(Date())
    }
    
    fileprivate func isEqualToDateIgnoringTime(_ date: Date) -> Bool {
        return ((self.jjs_year == date.jjs_year) && (self.jjs_month == date.jjs_month) && (self.jjs_day == date.jjs_day))
    }
    
    //MARK: Between
    
    public static func jjs_secondsBetween(date1 d1:Date, date2 d2:Date) -> Int {
        let dc = Calendar.current.dateComponents([.second], from: d1, to: d2)
        
        return dc.second!
    }
    
    public static func jjs_minutesBetween(date1 d1: Date, date2 d2: Date) -> Int {
        let dc = Calendar.current.dateComponents([.minute], from: d1, to: d2)
        
        return dc.minute!
    }
    
    public static func jjs_hoursBetween(date1 d1: Date, date2 d2: Date) -> Int {
        let dc = Calendar.current.dateComponents([.hour], from: d1, to: d2)
        
        return dc.hour!
    }
    
    public static func jjs_daysBetween(date1 d1: Date, date2 d2: Date) -> Int {
        let dc = Calendar.current.dateComponents([.day], from: d1, to: d2)
        
        return dc.day!
    }
    
    public static func jjs_weeksBetween(date1 d1: Date, date2 d2: Date) -> Int {
        let dc = Calendar.current.dateComponents([.weekOfYear], from: d1, to: d2)
        
        return dc.weekOfYear!
    }
    
    public static func jjs_monthsBetween(date1 d1: Date, date2 d2: Date) -> Int {
        let dc = Calendar.current.dateComponents([.month], from: d1, to: d2)
        
        return dc.month!
    }
    
    public static func jjs_yearsBetween(date1 d1: Date, date2 d2: Date) -> Int {
        let dc = Calendar.current.dateComponents([.year], from: d1, to: d2)
        
        return dc.year!
    }
    
    //MARK: Date
    
    public func jjs_plus(seconds s: UInt) -> Date {
        return self.jjs_addComponentsToDate(seconds: Int(s), minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: 0)
    }
    
    public func jjs_minus(seconds s: UInt) -> Date {
        return self.jjs_addComponentsToDate(seconds: -Int(s), minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: 0)
    }
    
    public func jjs_plus(minutes m: UInt) -> Date {
        return self.jjs_addComponentsToDate(seconds: 0, minutes: Int(m), hours: 0, days: 0, weeks: 0, months: 0, years: 0)
    }
    
    public func jjs_minus(minutes m: UInt) -> Date {
        return self.jjs_addComponentsToDate(seconds: 0, minutes: -Int(m), hours: 0, days: 0, weeks: 0, months: 0, years: 0)
    }
    
    public func jjs_plus(hours h: UInt) -> Date {
        return self.jjs_addComponentsToDate(seconds: 0, minutes: 0, hours: Int(h), days: 0, weeks: 0, months: 0, years: 0)
    }
    
    public func jjs_minus(hours h: UInt) -> Date {
        return self.jjs_addComponentsToDate(seconds: 0, minutes: 0, hours: -Int(h), days: 0, weeks: 0, months: 0, years: 0)
    }
    
    public func jjs_plus(days d: UInt) -> Date {
        return self.jjs_addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: Int(d), weeks: 0, months: 0, years: 0)
    }
    
    public func jjs_minus(days d: UInt) -> Date {
        return self.jjs_addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: -Int(d), weeks: 0, months: 0, years: 0)
    }
    
    public func jjs_plus(weeks w: UInt) -> Date {
        return self.jjs_addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: Int(w), months: 0, years: 0)
    }
    
    public func jjs_minus(weeks w: UInt) -> Date {
        return self.jjs_addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: -Int(w), months: 0, years: 0)
    }
    
    public func jjs_plus(months m: UInt) -> Date {
        return self.jjs_addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: Int(m), years: 0)
    }
    
    public func jjs_minus(months m: UInt) -> Date {
        return self.jjs_addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: -Int(m), years: 0)
    }
    
    public func jjs_plus(years y: UInt) -> Date {
        return self.jjs_addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: Int(y))
    }
    
    public func jjs_minus(years y: UInt) -> Date {
        return self.jjs_addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: -Int(y))
    }
    
    fileprivate func jjs_addComponentsToDate(seconds sec: Int, minutes min: Int, hours hrs: Int, days d: Int, weeks wks: Int, months mts: Int, years yrs: Int) -> Date {
        var dc = DateComponents()
        dc.second = sec
        dc.minute = min
        dc.hour = hrs
        dc.day = d
        dc.weekOfYear = wks
        dc.month = mts
        dc.year = yrs
        
        return Calendar.current.date(byAdding: dc, to: self)!
    }
    
    public func jjs_dateByAddingMonths(_ months: Int) -> Date {
        var dateComp = DateComponents()
        dateComp.month = months
        
        return Calendar.current.date(byAdding: dateComp, to: self)!
    }
    
    //MARK: Adjusting Date
    
    public func jjs_dateBySubtractingMonths(_ months: Int) -> Date {
        var dateComp = DateComponents()
        dateComp.month = (months * -1)
        
        return Calendar.current.date(byAdding: dateComp, to: self)!
    }
    
    public func jjs_dateByAddingWeeks(_ weeks: Int) -> Date {
        var dateComp = DateComponents()
        dateComp.day = 7 * weeks
        
        return Calendar.current.date(byAdding: dateComp, to: self)!
    }
    
    public func jjs_dateBySubtractingWeeks(_ weeks: Int) -> Date {
        var dateComp = DateComponents()
        dateComp.day = ((7 * weeks) * -1)
        
        return Calendar.current.date(byAdding: dateComp, to: self)!
    }
    
    public func jjs_dateByAddingDays(_ days: Int) -> Date {
        var dateComp = DateComponents()
        dateComp.day = days
        
        return Calendar.current.date(byAdding: dateComp, to: self)!
    }
    
    public func jjs_dateBySubtractingDays(_ days: Int) -> Date {
        var dateComp = DateComponents()
        dateComp.day = (days * -1)
        
        return Calendar.current.date(byAdding: dateComp, to: self)!
    }
    
    public func jjs_dateByAddingHours(_ hours: Int) -> Date {
        var dateComp = DateComponents()
        dateComp.hour = hours
        
        return Calendar.current.date(byAdding: dateComp, to: self)!
    }
    
    public func jjs_dateBySubtractingHours(_ hours: Int) -> Date {
        var dateComp = DateComponents()
        dateComp.hour = (hours * -1)
        
        return Calendar.current.date(byAdding: dateComp, to: self)!
    }
    
    public func jjs_dateByAddingMinutes(_ minutes: Int) -> Date {
        var dateComp = DateComponents()
        dateComp.minute = minutes
        
        return Calendar.current.date(byAdding: dateComp, to: self)!
    }
    
    public func jjs_dateBySubtractingMinutes(_ minutes: Int) -> Date {
        var dateComp = DateComponents()
        dateComp.minute = (minutes * -1)
        
        return Calendar.current.date(byAdding: dateComp, to: self)!
    }
    
    public func jjs_dateByAddingSeconds(_ seconds: Int) -> Date {
        var dateComp = DateComponents()
        dateComp.second = seconds
        
        return Calendar.current.date(byAdding: dateComp, to: self)!
    }
    
    public func jjs_dateBySubtractingSeconds(_ seconds: Int) -> Date {
        var dateComp = DateComponents()
        dateComp.second = (seconds * -1)
        
        return Calendar.current.date(byAdding: dateComp, to: self)!
    }
    
    public func jjs_dateAtStartOfDay() -> Date {
        var components = self.jjs_components()
        components.hour = 0
        components.minute = 0
        components.second = 0
        
        return Calendar.current.date(from: components)!
    }
    
    public func jjs_dateAtEndOfDay() -> Date {
        var components = self.jjs_components()
        components.hour = 23
        components.minute = 59
        components.second = 59
        
        return Calendar.current.date(from: components)!
    }
    
    public func jjs_dateAtStartOfWeek() -> Date {
        let flags: Set<Calendar.Component> = [Calendar.Component.year, Calendar.Component.month, Calendar.Component.weekOfYear, Calendar.Component.weekday]
        var components = Calendar.current.dateComponents(flags, from: self)
        components.weekday = Calendar.current.firstWeekday
        components.hour = 0
        components.minute = 0
        components.second = 0
        
        return Calendar.current.date(from: components)!
    }
    
    public func jjs_dateAtEndOfWeek() -> Date {
        let flags: Set<Calendar.Component> = [Calendar.Component.year, Calendar.Component.month, Calendar.Component.weekOfYear, Calendar.Component.weekday]
        var components = Calendar.current.dateComponents(flags, from: self)
        components.weekday = Calendar.current.firstWeekday + 6
        components.hour = 0
        components.minute = 0
        components.second = 0
        
        return Calendar.current.date(from: components)!
    }
    
    public func jjs_dateAtTheStartOfMonth() -> Date {
        var components = self.jjs_components()
        components.day = 1
        let firstDayOfMonthDate :Date = Calendar.current.date(from: components)!
        
        return firstDayOfMonthDate
    }
    
    public func jjs_dateAtTheEndOfMonth() -> Date {
        var components = self.jjs_components()
        components.month = (components.month ?? 0) + 1
        components.day = 0
        let lastDayOfMonth :Date = Calendar.current.date(from: components)!
        
        return lastDayOfMonth
    }
    
    static func jjs_tomorrow() -> Date {
        return Date().jjs_dateByAddingDays(1).jjs_dateAtStartOfDay()
    }
    
    static func jjs_yesterday() -> Date {
        return Date().jjs_dateBySubtractingDays(1).jjs_dateAtStartOfDay()
    }
    
    fileprivate static func jjs_componentFlags() -> Set<Calendar.Component> { return [Calendar.Component.year, Calendar.Component.month, Calendar.Component.day, Calendar.Component.weekOfYear, Calendar.Component.hour, Calendar.Component.minute, Calendar.Component.second, Calendar.Component.weekday, Calendar.Component.weekdayOrdinal, Calendar.Component.weekOfYear] }
    
    fileprivate static func jjs_components(_ fromDate: Date) -> DateComponents! {
        return Calendar.current.dateComponents(Date.jjs_componentFlags(), from: fromDate)
    }
    
    fileprivate func jjs_components() -> DateComponents  {
        return Date.jjs_components(self)!
    }
    
    //MARK: Getter
    
    public var jjs_second: UInt {
        if #available(iOS 8.0, *) {
            return UInt(NSCalendar.current.component(.second, from: self))
        } else {
            // Fallback on earlier versions(项目已不支持7.0,故无需操作)
        }
        
        return UInt()
    }
    
    public var jjs_minute: UInt {
        if #available(iOS 8.0, *) {
            return UInt(NSCalendar.current.component(.minute, from: self))
        } else {
            // Fallback on earlier versions
        }
        
        return UInt()
    }
    
    public var jjs_hour: UInt {
        if #available(iOS 8.0, *) {
            return UInt(NSCalendar.current.component(.hour, from: self))
        } else {
            // Fallback on earlier versions
        }
        
        return UInt()
    }
    
    public var jjs_day: UInt {
        if #available(iOS 8.0, *) {
            return UInt(Calendar.current.component(.day, from: self))
        } else {
            // Fallback on earlier versions
        }
        
        return UInt()
    }
    
    public var jjs_month: UInt {
        if #available(iOS 8.0, *) {
            return UInt(NSCalendar.current.component(.month, from: self))
        } else {
            // Fallback on earlier versions
        }
        
        return UInt()
    }
    
    public var jjs_year: UInt {
        if #available(iOS 8.0, *) {
            return UInt(NSCalendar.current.component(.year, from: self))
        } else {
            // Fallback on earlier versions
        }
        
        return UInt()
    }
}
