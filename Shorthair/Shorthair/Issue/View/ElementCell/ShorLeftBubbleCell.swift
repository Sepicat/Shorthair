//
//  ShorLeftBubbleCell.swift
//  Shorthair
//
//  Created by Harry Twan on 2019/2/15.
//  Copyright © 2019 Harry Twan. All rights reserved.
//

import UIKit
import SnapKit
import YYText

public class ShorLeftBubbleCell: UITableViewCell {
    
    public var updateTable: () -> Void = {}
    
    public var showText: String = "Before you start, are you using the latest CocoaPods release? Yes, 1.5.3\r\n [X ] I've read and understood the [*CONTRIBUTING* guidelines and have done my best effort to follow](https://github.com/CocoaPods/CocoaPods/blob/master/CONTRIBUTING.md).\n\n# Report\n\n## What did you do?\nEdit ~/.cocapods/config.yaml and added:"
    
    private var bakView: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor.gray
        return view
    }()
    
    lazy private var avatarImageView: UIImageView = {
        var imageView = UIImageView(image: UIImage(named: "logo-icon.png"))
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        return imageView
    }()
    
    lazy private var loginLabel: UILabel = {
        var label = UILabel()
        label.text = "Sepicat"
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 10)
        label.numberOfLines = 1
        return label
    }()
    
    lazy private var bubbleView: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 8
        return view
    }()
    
    lazy private var bubbleTextView: YYTextView = {
        var textView = YYTextView()
        textView.textColor = .black
        textView.font = UIFont.systemFont(ofSize: 12)
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()

    private var heightConstraint: Constraint? = nil
    
    public private(set) var cellHeight: CGFloat = 65

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialViews()
        initialLayouts()
    }
    
    private func initialViews() {
        addSubview(bakView)
        bakView.addSubview(avatarImageView)
        bakView.addSubview(loginLabel)
        bakView.addSubview(bubbleView)
        bubbleView.addSubview(bubbleTextView)
    }
    
    private func initialLayouts() {
        
        bakView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            heightConstraint = make.height.equalTo(cellHeight).priority(.high).constraint
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.width.height.equalTo(40)
            make.top.equalToSuperview().offset(10)
            make.bottom.lessThanOrEqualToSuperview().offset(-20)
        }
        
        loginLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView)
            make.left.equalTo(avatarImageView.snp.right).offset(10)
        }
        
        bubbleView.snp.makeConstraints { make in
            make.left.equalTo(loginLabel)
            make.top.equalTo(loginLabel.snp.bottom).offset(6)
            make.right.equalToSuperview().offset(-20)
            make.bottom.lessThanOrEqualToSuperview().offset(-20)
        }
        
        bubbleTextView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(7)
            make.right.equalToSuperview().offset(-7)
            make.top.equalToSuperview().offset(4)
            make.bottom.equalToSuperview().offset(-7)
        }
    }
    
    public func updateViews() {
        let attributedText = NSAttributedString(string: showText)
        let size = CGSize(width: bubbleView.frame.width - 14, height: CGFloat.greatestFiniteMagnitude)
        let layout = YYTextLayout(containerSize: size, text: attributedText)
        let height = ceil(layout?.textBoundingSize.height ?? 40.0)
        let parser = ShorMarkdownParser()
        bubbleTextView.attributedText = attributedText
        bubbleTextView.textParser = parser
        heightConstraint?.update(offset: 65.0 + height)
        cellHeight = 65.0 + height
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
