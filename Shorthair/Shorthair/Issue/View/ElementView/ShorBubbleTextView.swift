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
    
    lazy private var textLabel: YYLabel = {
        let label = YYLabel()
        label.text = "Before you start, are you using the latest CocoaPods release? Yes, 1.5.3\r\n [X ] I've read and understood the [*CONTRIBUTING* guidelines and have done my best effort to follow](https://github.com/CocoaPods/CocoaPods/blob/master/CONTRIBUTING.md).\n\n# Report\n\n## What did you do?\nEdit ~/.cocapods/config.yaml and added:"
        label.numberOfLines = 10
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialViews()
        initialLayouts()
    }
    
    private func initialViews() {
        addSubview(textLabel)
    }
    
    private func initialLayouts() {
        textLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    public func updateLayouts(width: CGFloat) {
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
