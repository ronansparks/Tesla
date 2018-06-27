//
//  UIColor.swift
//  Tesla
//
//  Created by Ronan on 6/27/18.
//  Copyright © 2018 Ronan. All rights reserved.
//

import UIKit

extension UIColor {
    // default is black
    convenience init(_ hexString: String, alpha: CGFloat = 1) {
        if !hexString.contains("#") {
            print("no '#' detected in \(hexString)")
            self.init(red: 0, green: 0, blue: 0, alpha: 1)
            return
        }
        
        let subString = hexString[String.Index.init(encodedOffset: 1)...]
        if subString.count != 6 {
            print("\(hexString) should contain 6 digits")
            self.init(red: 0, green: 0, blue: 0, alpha: 1)
            return
        }
        
        var hexValue: UInt32 = 0
        guard Scanner(string: String(subString)).scanHexInt32(&hexValue) else {
            print("invalid number in \(subString)")
            self.init(red: 0, green: 0, blue: 0, alpha: 1)
            return
        }
        
        let divisor = CGFloat(255)
        let red = CGFloat((hexValue & 0xFF0000) >> 16) / divisor
        let green = CGFloat((hexValue & 0xFF00) >> 8) / divisor
        let blue = CGFloat(hexValue & 0xFF) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    static func themeBackgroundColor() -> UIColor {
        return UIColor("#FFFFFF")
    }
    
    static func themeLightGray() -> UIColor {
        return UIColor("#F7F7F7")
    }
    
    static func themeDarkGray() -> UIColor {
        return UIColor("#333333")
    }
    
    static func themeGreen() -> UIColor {
        return UIColor("#47B359")
    }
    
    static func themeRed() -> UIColor {
        return UIColor("#CC0000")
    }
    
    static func themeYellow() -> UIColor {
        return UIColor("#FFEA00")
    }
 }
