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
        var regexHeader: NSRegularExpression = regexp("^(?:(\\#{1,6})([^#].*))|(?:(\\#{6})(.+))$")
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
        // 移位增量
        var delta: Int = 0
        regex.regexHeader.enumerateMatches(in: str, range: NSRange(location: 0, length: str.count)) { result, flags, stop in
            guard let result = result else {
                return
            }
            let r = result.range
            let sharpResult: NSRange = result.range(at: 1)
            let descResult: NSRange = result.range(at: 2)
            let sharpLen = sharpResult.length
            let desc: NSMutableAttributedString = NSMutableAttributedString(string: (str as NSString).substring(with: descResult))
            desc.yy_setColor(.red, range: NSRange(location: 0, length: desc.length))
            
            let realR = NSRange(location: r.location - delta, length: r.length)
            text.replaceCharacters(in: realR, with: desc)

            let newDescR = NSRange(location: sharpResult.location - delta, length: descResult.length)
//            text.yy_removeDiscontinuousAttributes(in: newDescR)
//            text.yy_setColor(.red, range: newDescR)
//            text.yy_setFont(UIFont.systemFont(ofSize: 17), range: newDescR)
//            text.addAttributes([
//                NSAttributedString.Key.backgroundColor: UIColor.yellow,
//                NSAttributedString.Key.underlineColor: UIColor.gray,
//            ], range: newDescR)

            delta += sharpResult.length
            
//            text.replaceCharacters(in: realR, with: desc)
//            delta += sharpResult.length
//            text.addAttributes([
//                NSAttributedString.Key.strokeColor : UIColor.red,
//                NSAttributedString.Key.backgroundColor : UIColor.yellow,
//            ], range: realR)
//            text.yy_setColor(.red, range: realDescResult)
            
            
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
