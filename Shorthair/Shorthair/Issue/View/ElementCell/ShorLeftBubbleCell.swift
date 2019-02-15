//
//  ShorLeftBubbleCell.swift
//  Shorthair
//
//  Created by Harry Twan on 2019/2/15.
//  Copyright © 2019 Harry Twan. All rights reserved.
//

import UIKit
import SnapKit

public class ShorLeftBubbleCell: UITableViewCell {
    
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
        label.text = "Desgard"
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
    }
    
    private func initialLayouts() {
        
        bakView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
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
            
            let height = Float.random(in: 40..<200)
            make.height.greaterThanOrEqualTo(height)
            make.bottom.lessThanOrEqualToSuperview().offset(-20)
        }
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
