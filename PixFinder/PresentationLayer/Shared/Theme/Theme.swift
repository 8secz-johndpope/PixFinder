//
//  Theme.swift
//  PixFinder
//
//  Created by Arinjoy Biswas on 12/6/20.
//  Copyright © 2020 Arinjoy Biswas. All rights reserved.
//

import UIKit

enum Theme {

    // MARK: - Colors

    private static let tealColor = UIColor.colorFrom(red: 58, green: 141, blue: 123)
    static let lightTealGrayColor = UIColor.colorFrom(red: 226, green: 232, blue: 230)
    static let lightOrangeGrayColor = UIColor.colorFrom(red: 51, green: 46, blue: 45)

    static let tintColor = UIColor(light: Theme.tealColor,
                                   dark: UIColor.orange)

    static let backgroundColor =  UIColor(light: UIColor.white,
                                          dark: Theme.lightOrangeGrayColor)

    static let secondaryBackgroundColor = UIColor(light: Theme.lightTealGrayColor,
                                               dark: UIColor.black)

    static let primaryTextColor = UIColor(light: .darkText,
                                          dark: .lightText)
}

private extension UIColor {
    static func colorFrom(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
    }
}

private extension UIColor {

    /// Creates a color object that generates its color data dynamically using the specified colors. For early SDKs creates light color.
    /// - Parameters:
    ///   - light: The color for light mode.
    ///   - dark: The color for dark mode.
    convenience init(light: UIColor, dark: UIColor) {
        if #available(iOS 13.0, tvOS 13.0, *) {
            self.init { traitCollection in
                if traitCollection.userInterfaceStyle == .dark {
                    return dark
                }
                return light
            }
        } else {
            self.init(cgColor: light.cgColor)
        }
    }
}

