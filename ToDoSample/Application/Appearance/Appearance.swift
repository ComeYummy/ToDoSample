//
//  Appearance.swift
//  ToDoSample
//
//  Created by Naoki Kameyama on 2020/07/08.
//  Copyright © 2020 Naoki Kameyama. All rights reserved.
//

import FontAwesome_swift
import UIKit

struct Appearance {

    // ナビゲーションバーの色指定
    static let navigationBarTintColor = UIColor.theme
    static let navigationBarTitleColor = UIColor.customBlack
    static let navigationBarBarTintColor = UIColor.white

    // 文字色
    static let normalColor = UIColor.customBlack
    static let themeColor = UIColor.theme
    
    static let highLightedAlpha: CGFloat = 0.5
    static let disabledAlpha: CGFloat = 0.5
    static let highlightedColor = UIColor.theme.withAlphaComponent(highLightedAlpha)
    static let disabledColor = UIColor.customBlack.withAlphaComponent(disabledAlpha)

    // AppDelegateで呼ぶApperanceの初期設定
    static func initialSetup() {
        // tabbar
        UITabBar.appearance().tintColor = .theme

        // navbar
        let backImage = UIImage.fontAwesomeIcon(name: .arrowLeft, style: .solid, textColor: .customBlack, size: CGSize(width: 32, height: 32))
        UINavigationBar.appearance().backIndicatorImage = backImage
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = backImage
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().tintColor = navigationBarTintColor // ナビゲーションバーのアイテムの色
        UINavigationBar.appearance().barTintColor = navigationBarBarTintColor // ナビゲーションバーの背景色
        UINavigationBar.appearance().titleTextAttributes = textAttributes(UIFont.systemFont(ofSize: 17), color: navigationBarTitleColor) // title文字の色

        // bar button item
        UIBarButtonItem.appearance().setTitleTextAttributes(textAttributes(17, color: themeColor), for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes(textAttributes(17, color: highlightedColor), for: .highlighted)
        UIBarButtonItem.appearance().setTitleTextAttributes(textAttributes(17, color: disabledColor), for: .disabled)

    }

    // 文字装飾の設定
    static func textAttributes(_ size: CGFloat, color: UIColor? = nil, alignment: NSTextAlignment? = nil, lineHeightDelta: CGFloat = 0, style: NSMutableParagraphStyle? = nil, kerning: CGFloat = 0.8) -> [NSAttributedString.Key: Any] {
        textAttributes(UIFont.systemFont(ofSize: size),
                       color: color,
                       alignment: alignment,
                       lineHeightDelta: lineHeightDelta,
                       style: style,
                       kerning: kerning)
    }

    // 文字装飾の設定
    static func textAttributes(_ font: UIFont, color: UIColor? = nil, alignment: NSTextAlignment? = nil, lineHeightDelta: CGFloat = 0, style: NSMutableParagraphStyle? = nil, kerning: CGFloat = 0.8) -> [NSAttributedString.Key: Any] {
        var pstyle = style
        var attrs: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.kern: kerning
        ]

        if let color = color {
            attrs[NSAttributedString.Key.foregroundColor] = color
        }

        if lineHeightDelta > 0 {
            if pstyle == nil {
                pstyle = NSMutableParagraphStyle()
            }
            pstyle?.minimumLineHeight = font.lineHeight + lineHeightDelta
            pstyle?.maximumLineHeight = font.lineHeight + lineHeightDelta
        }

        if let alignment = alignment {
            if pstyle == nil {
                pstyle = NSMutableParagraphStyle()
            }
            pstyle?.alignment = alignment
        }

        if let pstyle = pstyle {
            attrs[NSAttributedString.Key.paragraphStyle] = pstyle
        }

        return attrs
    }
}
