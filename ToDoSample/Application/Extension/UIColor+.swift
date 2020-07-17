//
//  UIColor+.swift
//  ToDoSample
//
//  Created by Naoki Kameyama on 2020/07/08.
//  Copyright © 2020 Naoki Kameyama. All rights reserved.
//

import UIKit

// MARK: - Theme colors

extension UIColor {
    // よく使う色指定
    static let theme = UIColor.hex(str: "FF416C")
    static let second = UIColor.hex(str: "FF4B2B")

    static let customBlack = UIColor.hex(str: "333333")
    static let customGray = UIColor.hex(str: "D0D6DE")
    static let customGrayLight = UIColor.hex(str: "EAEEF3")
}

extension UIColor {
    // 16進数の色指定からUIColorを変換してくれるextensiton
    static func hex(str hexStr: String, alpha: CGFloat = 1) -> UIColor {
        let hexStr = hexStr.replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: hexStr as String)
        var color: UInt64 = 0
        if scanner.scanHexInt64(&color) {
            let red = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let green = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let blue = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red: red, green: green, blue: blue, alpha: alpha)
        } else {
            print("invalid hex string")
            return UIColor.white
        }
    }
}
