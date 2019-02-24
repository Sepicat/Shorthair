//
//  ShorLeftBubbleTTCell.swift
//  Shorthair
//
//  Created by Harry Twan on 2019/2/23.
//  Copyright © 2019 Harry Twan. All rights reserved.
//

import UIKit
import Foundation
import SnapKit
import DTCoreText

public class TTShorLeftBubbleCell: UITableViewCell {
    
    public var showText: String = "*Before you start*, are you using the latest CocoaPods release? Yes, 1.5.3\n [X ] I've read and understood the [*CONTRIBUTING* guidelines and have done my best effort to follow](https://github.com/CocoaPods/CocoaPods/blob/master/CONTRIBUTING.md).\n# Report\n## What did you do?\nEdit `~/.cocapods/config.yaml` and added: \n hello **world**"

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
    
    lazy private var bubbleTextView: DTAttributedTextView = {
        var textView = DTAttributedTextView()
        return textView
    }()
    
    private var heightConstraint: Constraint? = nil
    
    public private(set) var cellHeight: CGFloat = 65
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialViews()
        initialLayouts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            make.bottom.equalToSuperview().offset(-20)
        }
        
        bubbleTextView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    public func updateViews() {
        let parser = TTMarkdownParser()
        guard let attributed = parser.attributedString(from: self.showText) else {
            return
        }
        bubbleTextView.attributedString = attributed

        let layouter = DTCoreTextLayouter(attributedString: attributed)
        let entireR = NSRange(location: 0, length: attributed.length)
        let currentRect = CGRect(x: 0, y: 0, width: CGFloat(bubbleTextView.frame.width - 20), height: CGFloat(CGFLOAT_HEIGHT_UNKNOWN))
        
        let layoutFrame = layouter?.layoutFrame(with: currentRect, range: entireR)
        guard let delta = layoutFrame?.frame.size.height else {
            return
        }

        // 更新 cell height
        cellHeight = 68.0 + delta
        heightConstraint?.update(offset: cellHeight)
    }
    
    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
