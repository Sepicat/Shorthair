//
//  ShorMarkdownParser.swift
//  Shorthair
//
//  Created by Harry Twan on 2019/2/16.
//  Copyright © 2019 Harry Twan. All rights reserved.
//

import UIKit
import YYText

func regexp(_ string: String) -> NSRegularExpression {
    if let res = try? NSRegularExpression(pattern: string, options: .anchorsMatchLines) {
        return res
    }
    return NSRegularExpression()
}

public class ShorMarkdownParser: NSObject {
    
    public struct Config {
        var fontSize: CGFloat
        var headerFontSize: CGFloat
    }
    
    public struct Regex {
        var regexHeader: NSRegularExpression = regexp("^(((\\#{1,6})([^#].*))|((\\#{6})(.+)))$")
        var regexLink: NSRegularExpression = regexp("!?\\[([^\\[\\]]+)\\](\\(([^\\(\\)]+)\\)|\\[([^\\[\\]]+)\\])")
    }
    
    public var themeConfig: Config
    
    public var regex: Regex = Regex()
    
    public override init() {
        themeConfig = Config(fontSize: 12, headerFontSize: 15)
        super.init()
        initialFonts()
        initialRegex()
    }
}

// Release
extension ShorMarkdownParser {
    private func initialFonts() {
        
    }
    
    private func initialRegex() {
        
    }
}

extension ShorMarkdownParser: YYTextParser {
    
    public func checkSymbol(_ symbol: String, str: String) -> (Int, Int) {
        var tot = 0
        for i in 0 ..< str.count {
            let currentChar = String(str[str.index(str.startIndex, offsetBy: i)])
            if symbol == currentChar {
                tot += 1
            }
            if currentChar != "\n" && currentChar != symbol && currentChar != " " {
                return (tot, i)
            }
        }
        return (-1, -1)
    }
    
    public func parseText(_ text: NSMutableAttributedString?, selectedRange: NSRangePointer?) -> Bool {
        guard let text = text, text.length != 0 else {
            return false
        }
        let str = text.string
        text.yy_removeDiscontinuousAttributes(in: NSRange(location: 0, length: text.length))
        regex.regexHeader.enumerateMatches(in: str, range: NSRange(location: 0, length: str.count)) { result, flags, stop in
            guard let r = result?.range else {
                return
            }
            let startIntex = str.index(str.startIndex, offsetBy: r.location - 1)
            let endIntex = str.index(str.startIndex, offsetBy: r.location + r.length)
            let subStr = String(str[startIntex ..< endIntex])
            let (sharpLen, whiteLen) = checkSymbol("#", str: subStr)
            print(sharpLen, whiteLen)
            text.yy_setColor(.red, range: NSRange(location: r.location + sharpLen, length: r.length - sharpLen))
//            let range = Range(r)
//            let whiteLen = self.lengthOfBeginWhite(in: str, range: r)
//            var sharpLen = self.lengthOfBegin(char: unichar("#") ?? unichar(bitPattern: 0), in: str, range: NSRange(location: r.location + whiteLen, length: r.length - whiteLen))
//            if sharpLen > 6 {
//                sharpLen = 6
//            }
//            let (sharpLen, whiteLen) = checkSymbol("#", str: )
//
//            text.yy_setColor(.gray, range: NSRange(location: r.location, length: ))
//            text.yy_setColor(.red, range: NSRange(location: r.location + whiteLen + sharpLen, length: r.length - whiteLen - sharpLen))
        }
        
        return true
    }
}

extension String {
    //获取子字符串
    func substingInRange(r: Range<Int>) -> String? {
        if r.lowerBound < 0 || r.upperBound > self.characters.count{
            return nil
        }
        let startIndex = self.index(self.startIndex, offsetBy:r.lowerBound)
        let endIndex   = self.index(self.startIndex, offsetBy:r.upperBound)
        return self.substring(with:startIndex..<endIndex)
    }
}
