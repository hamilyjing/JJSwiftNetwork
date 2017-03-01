//
//  String+JJ.swift
//  PANewToapAPP
//
//  Created by JJ on 16/9/13.
//  Copyright © 2016年 PingAn. All rights reserved.
//

import Foundation
import CoreFoundation
import UIKit

public func FVTLog<T>(_ message: T, file: String = #file, method: String = #function, line: Int = #line) {
    #if DEBUG
        print("yzt:\((file as NSString).lastPathComponent)[\(line)],\(method):\(message)")
    #endif
}

//MARK: CMUtils
extension String {
    
    public static func jjs_isBlank(str: String?) -> Bool {
        if let strValue = str {
            if strValue.isEmpty || (strValue.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "") {
                return true
            }else {
                return false
            }
        }
        return true
    }
    
    public static func jjs_isEmpty(str: String?) -> Bool {
        if let strValue = str {
            return strValue.isEmpty
        }
        return true
    }
    
    public static func jjs_emptyOrString(str: String?) -> String {
        if String.jjs_isEmpty(str: str) {
            return ""
        }
        return str!
    }
    
    public static func jjs_emptyOrStringAndTrim(str: String?) -> String {
        if String.jjs_isEmpty(str: str) {
            return ""
        }
        return str!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    public static func jjs_defaultValue(defaultStr: String?, OrString: String?) -> String {
        let tempDefaultStr = String.jjs_isEmpty(str: defaultStr) ? "" : defaultStr!
        return String.jjs_isEmpty(str: OrString) ? tempDefaultStr : OrString!
    }
}

//MARK: PDRegex
extension String {
    
    public func jjs_stringByReplacingRegexPattern(regex: String, replacement: String) -> String? {
        return self.jjs_stringByReplacingRegexPattern(regex: regex, replacement: replacement, ignoreCase: false, assumeMultiLine: false)
    }
    
    public func jjs_stringByReplacingRegexPattern(regex: String, replacement: String, ignoreCase: Bool) -> String? {
        return self.jjs_stringByReplacingRegexPattern(regex: regex, replacement: replacement, ignoreCase: ignoreCase, assumeMultiLine: false)
    }
    
    public func jjs_stringByReplacingRegexPattern(regex: String, replacement: String, ignoreCase: Bool, assumeMultiLine: Bool) -> String? {
        var useOptions = NSRegularExpression.Options(rawValue: UInt(0))
        
        if ignoreCase {
            useOptions = NSRegularExpression.Options.caseInsensitive
        }
        
        if assumeMultiLine {
            useOptions = [useOptions,NSRegularExpression.Options.dotMatchesLineSeparators]
        }
        
        do {
            let pattern = try NSRegularExpression.init(pattern: regex, options: useOptions)
            return pattern.stringByReplacingMatches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: UInt(0)), range: NSMakeRange(0,self.characters.count), withTemplate: replacement)
        } catch  {
            return nil
        }
    }
    
    public func jjs_stringsByExtractingGroupsUsingRegexPattern(regex: String, caseInsensitive ignoreCase: Bool, treatAsOneLine assumeMultiLine: Bool) -> [String]? {
        var useOptions = NSRegularExpression.Options(rawValue: UInt(0))
        
        if ignoreCase {
            useOptions = NSRegularExpression.Options.caseInsensitive
        }
        
        if assumeMultiLine {
            useOptions = NSRegularExpression.Options.dotMatchesLineSeparators
        }
        
        do {
            let pattern = try NSRegularExpression.init(pattern: regex, options: useOptions)
            var retVal: [String] = Array.init()
            pattern.enumerateMatches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: UInt(0)), range: NSMakeRange(0,self.characters.count), using: { (result, flags, stop) in
                if let resultValue = result {
                    for i in 1..<resultValue.numberOfRanges {
                        let ocString = self as NSString
                        let matchedString = ocString.substring(with: resultValue.rangeAt(i))
                        retVal.append(matchedString)
                    }
                }
            })
            if retVal.isEmpty {
                return nil
            }else {
                return retVal
            }
        } catch  {
            return nil
        }
    }
    
    public func yzt_stringsByExtractingGroupsUsingRegexPattern(regex: String) -> [String]? {
        return self.jjs_stringsByExtractingGroupsUsingRegexPattern(regex: regex, caseInsensitive: false, treatAsOneLine: false)
    }
    
    public func jjs_matchesPatternRegexPattern(regex: String, caseInsensitive ignoreCase: Bool, treatAsOneLine assumeMultiLine: Bool) -> Bool {
        var useOptions = NSRegularExpression.Options(rawValue: UInt(0))
        
        if ignoreCase {
            useOptions = NSRegularExpression.Options.caseInsensitive
        }
        
        if assumeMultiLine {
            useOptions = [useOptions,NSRegularExpression.Options.dotMatchesLineSeparators]
        }
        
        do {
            let pattern = try NSRegularExpression.init(pattern: regex, options: useOptions)
            return (pattern.numberOfMatches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: UInt(0)), range: NSMakeRange(0,self.characters.count)) > 0)
        } catch  {
            return false
        }
    }
    
    public func jjs_matchesPatternRegexPattern(regex: String) -> Bool {
        return self.jjs_matchesPatternRegexPattern(regex: regex, caseInsensitive: false, treatAsOneLine: false)
    }
    
    //判断昵称是否由中文、字母或数字组成
    public static func jjs_matchesNickRegexPattern(regexStr: String) -> Bool {
        if regexStr.isEmpty {
            return true
        }
        
        let regex = "^[_A-Za-z0-9\u{4e00}-\u{9fa5}]*$"
        let pred = NSPredicate.init(format: "SELF MATCHES %@",regex)
        
        return pred.evaluate(with: regexStr)
    }
    
    //mask code 掩码
    public static func jjs_maskCode(name: String?) -> String? {
        if let nameValue = name {
            if nameValue.isEmpty {
                return ""
            }
            if nameValue.characters.count == 1 {
                return nameValue
            }
            if nameValue.characters.count == 2 {
                return nameValue.replacingCharacters(in: Range(uncheckedBounds: (lower: nameValue.index(nameValue.startIndex, offsetBy: 1), upper: nameValue.endIndex)), with: "*")
            }
            if nameValue.characters.count > 2 && nameValue.characters.count < 7 {
                var maskString = ""
                for _ in 0..<nameValue.characters.count - 2 {
                    maskString.append("*")
                }
                return nameValue.replacingCharacters(in: Range(uncheckedBounds: (lower: nameValue.index(nameValue.startIndex, offsetBy: 1), upper: nameValue.index(nameValue.endIndex, offsetBy: -1))), with: maskString)
            }
            if nameValue.characters.count >= 7 && nameValue.characters.count <= 9 {
                var maskString = ""
                for _ in 0..<nameValue.characters.count - 4 {
                    maskString.append("*")
                }
                return nameValue.replacingCharacters(in: Range(uncheckedBounds: (lower: nameValue.index(nameValue.startIndex, offsetBy: 2), upper: nameValue.index(nameValue.endIndex, offsetBy: -2))), with: maskString)
            }
            if nameValue.characters.count > 9 {
                var maskString = ""
                for _ in 0..<nameValue.characters.count - 6 {
                    maskString.append("*")
                }
                return nameValue.replacingCharacters(in: Range(uncheckedBounds: (lower: nameValue.index(nameValue.startIndex, offsetBy: 3), upper: nameValue.index(nameValue.endIndex, offsetBy: -3))), with: maskString)
            }
        }
        return nil
    }
    
    //Data
    public func jjs_data() -> Data? {
        return self.data(using: .utf8)
    }
    
    //UI ---- !！
    public func jjs_textSize(font: UIFont) -> CGSize {
        if self.isEmpty {
            return CGSize.zero
        }
        let newString = self as NSString
        return newString.size(attributes: [NSFontAttributeName : font])
    }
    
    //Remove characters
    public func jjs_trimWhitespace() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
    public func jjs_trimNewline() -> String {
        return self.trimmingCharacters(in: CharacterSet.newlines)
    }
    
    public func jjs_trimWhitespaceAndNewline() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    //UUID
    public func jjs_UUID() -> String? {
        let uuidRef = CFUUIDCreate(kCFAllocatorNull)
        let uuid = CFUUIDCreateString(kCFAllocatorNull, uuidRef)
        let uuidString = uuid as? String
        return uuidString
    }
    
    //JSON
    public func jjs_dictionaryWithJSON() -> [AnyHashable:Any]? {
        let data = self.jjs_data()
        if let newData = data {
            do {
                let result = try JSONSerialization.jsonObject(with: newData, options: [.mutableContainers,.mutableLeaves]) as? [AnyHashable:Any]
                return result
            } catch {
                return nil
            }
        }
        return nil
    }
    
    public static func jjs_dictionaryToJson(obj: Any) -> String? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: obj, options: JSONSerialization.WritingOptions.prettyPrinted)
            let requestDataString = String.init(data: jsonData, encoding: .utf8)
            if var requestDataStringValue = requestDataString {
                requestDataStringValue = requestDataStringValue.replacingOccurrences(of: "\n", with: "")
                requestDataStringValue = requestDataStringValue.replacingOccurrences(of: "\r", with: "")
                requestDataStringValue = requestDataStringValue.replacingOccurrences(of: " ", with: "")
                return requestDataStringValue
            }
            return nil
        } catch {
            return nil
        }
    }
    
    public func jjs_objectFromJSONString() -> Any? {
        let data = self.jjs_data()
        if let newData = data {
            do {
                let result = try JSONSerialization.jsonObject(with: newData, options: [.mutableContainers,.mutableLeaves])
                return result
            } catch {
                return nil
            }
        }
        return nil
    }
    
    public static func jjs_updateRequestInfo(arr: [Any]) -> String? {
        let requestData = String.jjs_dictionaryToJson(obj: arr)
        if var requestDataValue = requestData {
            requestDataValue = requestDataValue.replacingOccurrences(of: "\n", with: "")
            requestDataValue = requestDataValue.replacingOccurrences(of: "\r", with: "")
            requestDataValue = requestDataValue.replacingOccurrences(of: " ", with: "")
            return requestDataValue
        }
        return nil
    }
    
    //SubString
    public func jjs_subStringBeforeFirstSeparator(separator: String?) -> String? {
        if let separatorValue = separator {
            let range = self.range(of: separatorValue)
            if let rangeValue = range {
                return self.substring(to: rangeValue.lowerBound)
            }
        }
        return nil
    }
    
    public func jjs_subStringAfterFirstSeparator(separator: String?) -> String? {
        if let separatorValue = separator {
            let range = self.range(of: separatorValue)
            if let rangeValue = range {
                return self.substring(from: rangeValue.upperBound)
            }
        }
        return nil
    }
    
    public func jjs_stringBetweenTheSameString(separator: String?) -> [String]? {
        if let separatorValue = separator  {
            var array = self.components(separatedBy: separatorValue)
            if array.count > 0 {
                array.removeFirst()
                array.removeLast()
                return array
            }
        }
        return nil
    }
    
    public func jjs_milliSecondString2Second() -> String? {
        if self.characters.count > 10 {
            if let newValue = CLongLong(self) {
                return "\(newValue / 1000).\(newValue % 1000)"
            }
        }
        return nil
    }
    
    //MARK: -- 校正手机号：如去掉前面的86，17951等，并且只取11位
    public func jjs_adjustedPhoneNumber() -> String {
        var phoneNum = self.replacingOccurrences(of: " ", with: "")
        phoneNum = phoneNum.replacingOccurrences(of: "+", with: "")
        phoneNum = phoneNum.replacingOccurrences(of: "-", with: "")
        phoneNum = phoneNum.replacingOccurrences(of: "（", with: "")
        phoneNum = phoneNum.replacingOccurrences(of: "）", with: "")
        if phoneNum.hasPrefix("86") {
            phoneNum = phoneNum.substring(from: phoneNum.index(phoneNum.startIndex, offsetBy: 2))
        }
        if phoneNum.hasPrefix("17951") {
            phoneNum = phoneNum.substring(from: phoneNum.index(phoneNum.startIndex, offsetBy: 5))
        }
        if phoneNum.characters.count > 11 {
            phoneNum = phoneNum.substring(to: phoneNum.index(phoneNum.startIndex, offsetBy: 11))
        }
        return phoneNum
    }
    
    //MARK: -- 判断字符串是否email
    public func jjs_isEmail() -> Bool {
        let regex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$"
        let regexTestEmail = NSPredicate(format: "SELF MATCHES %@", regex)
        return regexTestEmail.evaluate(with: self)
    }
    
    //MARK: -- 判断字符串是否手机号
    public func jjs_isPhoneNumber() -> Bool {
        let regex = "^[1][3-8]\\d{9}$"
        let regexTestPhoneNumber = NSPredicate(format: "SELF MATCHES %@", regex)
        return regexTestPhoneNumber.evaluate(with: self)
    }
    
    //MARK: -- 字符串倒叙
    public func jjs_stringByReversed() -> String? {
        var reverdString: String = ""
        for character in self.characters {
            reverdString.insert(character, at: reverdString.startIndex)
        }
        return reverdString
    }
}

//MARK: FormatString
extension String {
    //MARK: -- 银行卡号格式化，每隔4位加空格
    public func jjs_formatBankNumber() -> String {
        if self.isEmpty || !self.jjs_isNumber() {
            return ""
        }
        let len = self.characters.count
        let remainder = len % 4
        var num = len / 4
        if remainder > 0 {
            num += 1
        }
        var mstr = ""
        for i in 0..<num {
            if i != num - 1 {
                let start = self.index(self.startIndex, offsetBy: 4 * i)
                let end = self.index(start, offsetBy: 4)
                let range = Range.init(uncheckedBounds: (lower: start, upper: end))
                let str = self.substring(with: range)
                mstr.append(str)
                mstr.append(" ")
            }else {
                let str = self.substring(from: self.index(self.startIndex, offsetBy: 4 * i))
                mstr.append(str)
            }
        }
        return mstr
    }
    
    public func jjs_isNumber() -> Bool {
        let pred = NSPredicate.init(format: "SELF MATCHES %@", "^[0-9]{4,30}$")
        return pred.evaluate(with: self)
    }
    
    //MARK: -- 格式化好的银行卡号去掉空格
    public func jjs_noFormatBankNumber() -> String {
        return self.replacingOccurrences(of: " ", with: "")
    }
    
    //MARK: -- !!!! 超过1万以万为单位，超过1亿以亿为单位，千分位化显示
    public static func jjs_formatMoney(money: String) -> String {
        var returnValue = "0.00"
        let amount = Decimal.init(string: money.replacingOccurrences(of: ",", with: ""))
        if var amountValue = amount {
            let formatter = NumberFormatter.init()
            formatter.minimumIntegerDigits = 1
            formatter.minimumFractionDigits = 2
            formatter.maximumFractionDigits = 2
            if !amountValue.isLess(than: Decimal.init(string: "100000000")!) {
                amountValue.divide(by: Decimal.init(string: "100000000.0")!)
                let moneyFormatter = String.jjs_formatThousandsStringWithString(doubleStr: formatter.string(from: amountValue as NSNumber))
                returnValue = moneyFormatter.appending("亿")
            }else if !amountValue.isLess(than: Decimal.init(string: "10000")!) {
                amountValue.divide(by: Decimal.init(string: "10000.0")!)
                let moneyFormatter = String.jjs_formatThousandsStringWithString(doubleStr: formatter.string(from: amountValue as NSNumber))
                returnValue = moneyFormatter.appending("万")
            }else {
                returnValue = String.jjs_formatThousandsStringWithString(doubleStr: formatter.string(from: amountValue as NSNumber))
            }
        }
        return returnValue
    }
    
    //MARK: -- !!!! 超过1万以万为单位，超过1亿以亿为单位，千分位化显示，不带小数点（仅限：如 50000、100000...）
    public static func jjs_formatMoneyWithOutFractionDigits(money: String) -> String {
        var returnValue = "0.00"
        let amount = Decimal.init(string: money.replacingOccurrences(of: ",", with: ""))
        if var amountValue = amount {
            let formatter = NumberFormatter.init()
            formatter.minimumIntegerDigits = 1
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 0
            if !amountValue.isLess(than: Decimal.init(string: "100000000")!) {
                amountValue.divide(by: Decimal.init(string: "100000000.0")!)
                let moneyFormatter = String.jjs_formatThousandsStringWithString(doubleStr: formatter.string(from: amountValue as NSNumber))
                returnValue = moneyFormatter.appending("亿")
            }else if !amountValue.isLess(than: Decimal.init(string: "10000")!) {
                amountValue.divide(by: Decimal.init(string: "10000.0")!)
                let moneyFormatter = String.jjs_formatThousandsStringWithString(doubleStr: formatter.string(from: amountValue as NSNumber))
                returnValue = moneyFormatter.appending("万")
            }else {
                returnValue = String.jjs_formatThousandsStringWithString(doubleStr: formatter.string(from: amountValue as NSNumber))
            }
        }
        return returnValue
    }
    
    //MARK: -- 格式化千分位数字：如32115900 ==> 32,115,900
    public static func jjs_formatThousandsStringWithString(doubleStr: String?) -> String {
        var resultStr = "0"
        var firstChar = ""
        if var doubleStrValue = doubleStr {
            doubleStrValue = doubleStrValue.replacingOccurrences(of: ",", with: "")
            if !doubleStrValue.isEmpty {
                firstChar = doubleStrValue.substring(to: doubleStrValue.index(doubleStrValue.startIndex, offsetBy: 1))
                if firstChar == "+" || firstChar == "-" {
                    let start = doubleStrValue.index(doubleStrValue.startIndex, offsetBy: 1)
                    let end = doubleStrValue.index(doubleStrValue.endIndex, offsetBy: 0)
                    let range = Range.init(uncheckedBounds: (lower: start, upper: end))
                    doubleStrValue = doubleStrValue.substring(with: range)
                }else {
                    firstChar = ""
                }
                resultStr = doubleStrValue
                var dotLoc: Range<String.Index>? = nil
                for character in doubleStrValue.characters {
                    if character == "." {
                        dotLoc = doubleStrValue.range(of: String(character))
                        break
                    }
                }
                if dotLoc != nil {
                    doubleStrValue = doubleStrValue.substring(with: Range.init(uncheckedBounds: (lower: doubleStrValue.startIndex, upper: dotLoc!.lowerBound)))
                }
                if doubleStrValue.characters.count > 3 {
                    let remainderNum = doubleStrValue.characters.count % 3
                    let divisor = doubleStrValue.characters.count / 3 - 1
                    if remainderNum != 0 {
                        resultStr.insert(",", at: resultStr.index(resultStr.startIndex, offsetBy: remainderNum))
                    }
                    for i in 0..<divisor {
                        if remainderNum != 0 {
                            resultStr.insert(",", at: resultStr.index(resultStr.startIndex, offsetBy: remainderNum + 3 * (i + 1) + i + 1))
                        }else {
                            resultStr.insert(",", at: resultStr.index(resultStr.startIndex, offsetBy: remainderNum + 3 * (i + 1) + i))
                        }
                    }
                }
            }
        }
        return firstChar.appending(resultStr)
    }
    
    public static func jjs_formatThousandsStringWithString(doubleStr: String?,decimal: Int) -> String {
        if let doubleStrValue = doubleStr {
            let result = doubleStrValue.replacingOccurrences(of: ",", with: "")
            let format = String.init(format: "%%.%df", decimal)
            if Double(result) == nil {
                return "0"
            }
            return String.jjs_formatThousandsStringWithString(doubleStr: String.init(format: format, Double(result)!))
        }
        return "0"
    }
    
    public static func jjs_formatThousandsMoneyString(doubleStr: String?) -> String {
        return String.jjs_formatThousandsStringWithString(doubleStr: doubleStr, decimal: 2)
    }
    
    public func jjs_doubleValue() -> Double? {
        return Double(self.replacingOccurrences(of: ",", with: ""))
    }
    
}

enum JJSNumberType: Int {
    case JJSNumberTypeDefault         //原始数据
    case JJSNumberTypeRoundDown       //取整（只舍不入）
    case JJSNumberTypeRoundBanker     //取整（四舍五入）
    case JJSNumberTypeTwoScaleDown    //保留两位小数（只舍不入
    case JJSNumberTypeTwoScaleBanker  //保留两位小数（四舍五入）
}

//MARK: YZTDecimal
extension String {
    /*********默认结果保留两位小数且四舍五入********/
    public func jjs_addBy(stringNum: String) -> String {
        return self.jjs_addBy(stringNum: stringNum, resultType: JJSNumberType.JJSNumberTypeTwoScaleBanker)
    }
    
    public func jjs_minusBy(stringNum: String) -> String {
        return self.jjs_minusBy(stringNum: stringNum, resultType: JJSNumberType.JJSNumberTypeTwoScaleBanker)
    }
    
    public func jjs_multiplyBy(stringNum: String) -> String {
        return self.jjs_multiplyBy(stringNum: stringNum, resultType: JJSNumberType.JJSNumberTypeTwoScaleBanker)
    }
    
    public func jjs_devideBy(stringNum: String) -> String {
        return self.jjs_devideBy(stringNum: stringNum, resultType: JJSNumberType.JJSNumberTypeTwoScaleBanker)
    }
    
    /// 加法
    ///
    /// - parameter stringNum:  加数
    /// - parameter resultType: 结果类型
    ///
    /// - returns: 和
    func jjs_addBy(stringNum: String,resultType: JJSNumberType) -> String {
        let str1 = self.jjs_clean()
        let str2 = stringNum.jjs_clean()
        if str1.jjs_isDecimalNumber() && str2.jjs_isDecimalNumber() {
            let num1 = NSDecimalNumber.init(string: str1)
            let num2 = NSDecimalNumber.init(string: str2)
            let hanlder = self.jjs_handlerWithType(type: resultType)
            let result = num1.adding(num2, withBehavior: hanlder)
            return result.stringValue
        }
        return "0"
    }
    
    /// 减法
    ///
    /// - parameter stringNum:  减数
    /// - parameter resultType: 结果类型
    ///
    /// - returns: 差
    func jjs_minusBy(stringNum: String,resultType: JJSNumberType) -> String {
        let str1 = self.jjs_clean()
        let str2 = stringNum.jjs_clean()
        if str1.jjs_isDecimalNumber() && str2.jjs_isDecimalNumber() {
            let num1 = NSDecimalNumber.init(string: str1)
            let num2 = NSDecimalNumber.init(string: str2)
            let hanlder = self.jjs_handlerWithType(type: resultType)
            let result = num1.subtracting(num2, withBehavior: hanlder)
            return result.stringValue
        }
        return "0"
    }
    
    /// 乘法
    ///
    /// - parameter stringNum:  乘数
    /// - parameter resultType: 结果类型
    ///
    /// - returns: 积
    func jjs_multiplyBy(stringNum: String,resultType: JJSNumberType) -> String {
        let str1 = self.jjs_clean()
        let str2 = stringNum.jjs_clean()
        if str1.jjs_isDecimalNumber() && str2.jjs_isDecimalNumber() {
            let num1 = NSDecimalNumber.init(string: str1)
            let num2 = NSDecimalNumber.init(string: str2)
            let hanlder = self.jjs_handlerWithType(type: resultType)
            let result = num1.multiplying(by: num2, withBehavior: hanlder)
            return result.stringValue
        }
        return "0"
    }
    
    /// 除法
    ///
    /// - parameter stringNum:  除数
    /// - parameter resultType: 结果类型
    ///
    /// - returns: 商
    func jjs_devideBy(stringNum: String,resultType: JJSNumberType) -> String {
        let str1 = self.jjs_clean()
        let str2 = stringNum.jjs_clean()
        if str1.jjs_isDecimalNumber() && str2.jjs_isDecimalNumber() {
            let num1 = NSDecimalNumber.init(string: str1)
            let num2 = NSDecimalNumber.init(string: str2)
            let hanlder = self.jjs_handlerWithType(type: resultType)
            let result = num1.dividing(by: num2, withBehavior: hanlder)
            return result.stringValue
        }
        return "0"
    }
    
    public func jjs_isBiggerThan(stringNum: String) -> Bool {
        let str1 = self.jjs_clean()
        let str2 = stringNum.jjs_clean()
        if str1.jjs_isDecimalNumber() && str2.jjs_isDecimalNumber() {
            let num1 = NSDecimalNumber.init(string: str1)
            let num2 = NSDecimalNumber.init(string: str2)
            let result = num1.compare(num2)
            if result == .orderedDescending {
                return true
            }
        }
        return false
    }
    
    public func jjs_isLessThan(stringNum: String) -> Bool {
        let str1 = self.jjs_clean()
        let str2 = stringNum.jjs_clean()
        if str1.jjs_isDecimalNumber() && str2.jjs_isDecimalNumber() {
            let num1 = NSDecimalNumber.init(string: str1)
            let num2 = NSDecimalNumber.init(string: str2)
            let result = num1.compare(num2)
            if result == .orderedAscending {
                return true
            }
        }
        return false
    }
    
    public func jjs_isEqualTo(stringNum: String) -> Bool {
        let str1 = self.jjs_clean()
        let str2 = stringNum.jjs_clean()
        if str1.jjs_isDecimalNumber() && str2.jjs_isDecimalNumber() {
            let num1 = NSDecimalNumber.init(string: str1)
            let num2 = NSDecimalNumber.init(string: str2)
            let result = num1.compare(num2)
            if result == .orderedSame {
                return true
            }
        }
        return false
    }
    
    private func jjs_isDecimalNumber() -> Bool {
        let pred = NSPredicate.init(format: "SELF MATCHES %@", "^[+-]?([0-9]*\\.?[0-9]+|[0-9]+\\.?[0-9]*)([eE][+-]?[0-9]+)?$")
        return pred.evaluate(with: self)
    }
    
    public func jjs_clean() -> String {
        return self.replacingOccurrences(of: ",", with: "")
    }
    
    func jjs_handlerWithType(type: JJSNumberType) -> NSDecimalNumberHandler {
        var handle = self.yzt_handler()
        switch type {
        case .JJSNumberTypeDefault:
            handle = self.yzt_handler()
        case .JJSNumberTypeRoundDown:
            handle = self.yzt_handler1()
        case .JJSNumberTypeRoundBanker:
            handle = self.yzt_handler2()
        case .JJSNumberTypeTwoScaleDown:
            handle = self.yzt_handler3()
        case .JJSNumberTypeTwoScaleBanker:
            handle = self.yzt_handler4()
        }
        return handle
    }
    
    //MARK: -- handler
    
    //MARK: -- 原始数据
    public func yzt_handler() -> NSDecimalNumberHandler {
        return NSDecimalNumberHandler.default()
    }
    
    //MARK: -- 取整 (只舍不入)
    public func yzt_handler1() -> NSDecimalNumberHandler {
        return NSDecimalNumberHandler.init(roundingMode: .down, scale: 0, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: true)
    }
    
    //MARK: -- 取整（四舍五入）
    public func yzt_handler2() -> NSDecimalNumberHandler {
        return NSDecimalNumberHandler.init(roundingMode: .bankers, scale: 0, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: true)
    }
    
    //MARK: -- 两位小数（只舍不入）
    public func yzt_handler3() -> NSDecimalNumberHandler {
        return NSDecimalNumberHandler.init(roundingMode: .down, scale: 2, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: true)
    }
    
    //MARK: -- 两位小数（四舍五入）
    public func yzt_handler4() -> NSDecimalNumberHandler {
        return NSDecimalNumberHandler.init(roundingMode: .bankers, scale: 2, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: true)
    }
}

//MARK: URL
extension String {
    
    public func jjs_isStandardURLString() -> Bool {
        return self.lowercased().hasPrefix("http://") || self.lowercased().hasPrefix("https://") || self.lowercased().hasPrefix("file://")
    }
    
    public func jjs_urlEncodedString() -> String? {
        return self.jjs_urlEncodeUsingEncoding(encoding: CFStringBuiltInEncodings.UTF8.rawValue)
    }
    
    public func jjs_urlDecodedString() -> String? {
        return self.jjs_urlDecodeUsingEncoding(encoding: CFStringBuiltInEncodings.UTF8.rawValue)
    }
    
    public func jjs_urlEncodeUsingEncoding(encoding: CFStringEncoding) -> String? {
        let encodedCFString = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, self as CFString, nil, "?!@#$^&%*+,:;='\"`<>()[]{}/\\| " as CFString!, encoding)
        let encodedString = encodedCFString as? String
        return encodedString
    }
    
    public func jjs_urlDecodeUsingEncoding(encoding: CFStringEncoding) -> String? {
        let decodedCFString = CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, self as CFString, "" as CFString!, encoding)
        let decodedString = decodedCFString as? String
        if let newString = decodedString {
            return newString.replacingOccurrences(of: "+", with: "")
        }
        return nil
    }
    
    public func jjs_dictionaryWithURLQuery() -> [AnyHashable:Any] {
        let params = self.components(separatedBy: "&")
        var ret = [AnyHashable:Any]()
        for param in params {
            let range = param.range(of: "=")
            if let haveRange = range {
                let key = param.substring(to: haveRange.lowerBound)
                let value = param.substring(from: haveRange.upperBound)
                ret.updateValue(value, forKey: key)
            }
        }
        return ret
    }
}

//MARK: Base64 MD5
extension String {
    
    //Base64
    public func jjs_base64EncodedString() -> String? {
        if let data = self.jjs_data() {
            return data.base64EncodedString()
        }
        return nil
    }
    
    public func jjs_base64EncodedData() -> Data? {
        if let data = self.jjs_data() {
            return data.base64EncodedData(options: .lineLength64Characters)
        }
        return nil
    }
    
    public func jjs_base64DecodedString() -> String? {
        if let stringData = self.jjs_base64DecodedData()  {
            return String.init(data: stringData, encoding: .utf8)
        }
        return nil
    }
    
    public func jjs_base64DecodedData() -> Data? {
        if let data = self.jjs_data() {
            return Data.init(base64Encoded: data, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)
        }
        return nil
    }
    
    //---- !!
    public mutating func jjs_base64String() -> String? {
        return ""
    }
    
    //MD5 ---- !!
    public func jjs_md5String() -> String {
        return ""
    }
    
    //---- !!
    public func jjs_md5Data() -> Data {
        return Data()
    }
    
    //---- !!
    public static func jjs_MD5StringFrom(source: String?) -> String? {
        if String.jjs_isEmpty(str: source) {
            return nil
        }
        return nil
    }
}
