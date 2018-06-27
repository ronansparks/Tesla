//
//  UIFont.swift
//  Tesla
//
//  Created by Ronan on 6/26/18.
//  Copyright © 2018 Ronan. All rights reserved.
//

import UIKit

enum FontSize: CGFloat {
    case large = 32
    case big = 24
    case middle = 20
    case small = 16
}

enum FontWeight: String {
    case light
    case book
    case bold
}

extension UIFont {
    static func setGotham(_ size: FontSize, weight: FontWeight = .book) -> UIFont {
        var fontName: String
        switch weight {
        case .light:
            fontName = "gotham-light"
        case .book:
            fontName = "gotham-book"
        case .bold:
            fontName = "gotham-bold"
        }
        return UIFont(name: fontName, size: size.rawValue)!
    }
}
