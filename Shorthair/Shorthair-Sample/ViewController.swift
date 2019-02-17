//
//  ViewController.swift
//  Shorthair-Sample
//
//  Created by Harry Twan on 2019/2/15.
//  Copyright © 2019 Harry Twan. All rights reserved.
//

import UIKit
import Shorthair

class ViewController: UIViewController {
    
    lazy private var tableView: UITableView = {
        var tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 60.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.alpha = 0
        tableView.register(ShorLeftBubbleCell.self, forCellReuseIdentifier: "ShorLeftBubbleCell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initialViews()
    }
    
    private func initialViews() {
        view.addSubview(tableView)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.tableView.reloadData()
            self.tableView.alpha = 1
        }
    }
    
    private func initialLayouts() {
        
    }
}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ShorLeftBubbleCell", for: indexPath)
            as? ShorLeftBubbleCell {
            cell.selectionStyle = .none
            cell.updateViews()
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ViewController: UITableViewDelegate {}

