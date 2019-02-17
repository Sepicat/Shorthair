//
//  ShorBubbleView.swift
//  Shorthair
//
//  Created by Harry Duan on 2019/2/15.
//  Copyright © 2019 Harry Twan. All rights reserved.
//

import UIKit
import YYText

public class ShorBubbleTextView: UIView {
    
    lazy private var messageTextLabel: YYLabel = {
        let label = YYLabel()
        return label
    }()
    
    var layout: YYTextLayout? {
        get {
            return messageTextLabel.textLayout
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialViews()
        initialLayouts()
    }
    
    private func initialViews() {
        addSubview(messageTextLabel)
    }
    
    private func initialLayouts() {
        messageTextLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    public func updateLayouts(width: CGFloat) {
        let _text = NSAttributedString(string: "Before you start, are you using the latest CocoaPods release? Yes, 1.5.3\r\n [X ] I've read and understood the [*CONTRIBUTING* guidelines and have done my best effort to follow](https://github.com/CocoaPods/CocoaPods/blob/master/CONTRIBUTING.md).\n\n# Report\n\n## What did you do?\nEdit ~/.cocapods/config.yaml and added:")
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let layout = YYTextLayout(containerSize: size, text: _text)
        messageTextLabel.attributedText = _text
        messageTextLabel.textLayout = layout
        messageTextLabel.sizeToFit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
