//
//  TTMarkdownLabel.swift
//  Shorthair
//
//  Created by Harry Twan on 2019/2/23.
//  Copyright © 2019 Harry Twan. All rights reserved.
//

import UIKit
import TTTAttributedLabel

class TTMarkdownLabel: TTTAttributedLabel {
    override init(frame: CGRect) {
        
        super.init(frame: frame)
    }
    
    private func commonConfig() {
        self.delegate = self
        let linkAttributed: [AnyHashable : Any] = [
            kCTForegroundColorAttributeName: UIColor.blue,
            NSAttributedString.Key.underlineStyle: 0,
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Light", size: 15) as Any,
        ]
        linkAttributes = linkAttributed
        enabledTextCheckingTypes = 0
    }
    
    public func setDisplay(attributedString text: NSAttributedString) {
        var linksAndRange: [[AnyObject]] = [[]]
        setText(text) { mutableAttributedString -> NSMutableAttributedString? in
            return mutableAttributedString
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TTMarkdownLabel: TTTAttributedLabelDelegate {
}
