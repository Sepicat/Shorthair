//
//  TTMarkdownParser.swift
//  Shorthair
//
//  Created by Harry Twan on 2019/2/23.
//  Copyright © 2019 Harry Twan. All rights reserved.
//

import UIKit
import MMMarkdown
import DTCoreText
import Atributika

//
// Workaround:
// http://nightfade.github.io/2015/06/26/ios-markdown-rendering/
// Parser -> HTML -> NSAttributedString -> TTTAttributionLabel
//
// Parser -> HTML -> Atributika -> TTTAttributionLabel
// https://github.com/psharanda/Atributika
//

public class TTMarkdownParser: NSObject {
    var htmlParser: MMMarkdown
    var dtCoreOptions: [NSAttributedString.DocumentReadingOptionKey: Any] {
        get {
            return [
                TTMarkdownParser.optionKey(DTUseiOS6Attributes): true,
                TTMarkdownParser.optionKey(DTIgnoreInlineStylesOption): true,
                TTMarkdownParser.optionKey(DTDefaultLinkDecoration): false,
                TTMarkdownParser.optionKey(DTDefaultLinkColor): UIColor.blue,
                TTMarkdownParser.optionKey(DTLinkHighlightColorAttribute): UIColor.red,
                TTMarkdownParser.optionKey(DTDefaultFontSize): 14,
                TTMarkdownParser.optionKey(DTDefaultFontFamily): "GurmukhiMN",
                TTMarkdownParser.optionKey(DTDefaultFontName): "GurmukhiMN",
            ]
        }
    }
    
    static func optionKey(_ rawValue: String) -> NSAttributedString.DocumentReadingOptionKey {
        return NSAttributedString.DocumentReadingOptionKey(rawValue: rawValue)
    }

    override public init() {
        self.htmlParser = MMMarkdown()
        super.init()
    }
    
    func HTML(from markdown: String) -> String? {
        return try? MMMarkdown.htmlString(withMarkdown: markdown, extensions: .gitHubFlavored)
    }
    
    func attributedString(from markdown: String) -> NSAttributedString? {
        guard let _html = HTML(from: markdown) else {
            return nil
        }
        
        let html = "<style>p, h1, h2 {margin-bottom: 0; padding-bottom: 2; font-family: GurmukhiMN, Consolas;}</style>\(_html)"
        
        guard let data = html.data(using: .utf16) else {
            return nil
        }

        let stringBuilder = DTHTMLAttributedStringBuilder(html: data, options: dtCoreOptions, documentAttributes: nil)
        

        stringBuilder?.willFlushCallback = { element in
            guard let _: DTHTMLElement = element else {
                return
            }
//            if element.name == "h1" || element.name == "h2" {
//                element.applyStyleDictionary(titleStyle)
//            }
        }

        guard let attributed = stringBuilder?.generatedAttributedString() else {
            return nil
        }

        return attributed
    }
}

extension TTMarkdownParser {
    
}
