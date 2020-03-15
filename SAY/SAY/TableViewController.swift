//
//  TableViewController.swift
//  SAY
//
//  Created by Антон Степанок on 15.03.2020.
//  Copyright © 2020 Антон Степанок. All rights reserved.
//

import UIKit
import QuartzCore

struct MessageItem {
    let label: String
}


final class TableViewController: UIViewController, UITableViewDataSource {
    override func viewDidLoad() {
         super.viewDidLoad()
            setupTableView()
    
    
    }
        
    private var data: [MessageItem] = [
        MessageItem(label: "I'm a good programmer. I mean, it's the only thing I am good at. I mean, last year, I threw a Frisbee and it chipped my tooth."),
        MessageItem(label: "I'm a good programmer. I mean, it's the only thing I am good at. I mean, last year, I threw a Frisbee and it chipped my tooth."),
    ]
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as! CustomTableViewCell
            
         let item = data[indexPath.row] //2.
            
         
            cell.message.text = item.label //3.
        
            
         return cell //4.
    }
    
    private func setupTableView() {
        let cellNib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "CustomTableViewCell")
    }
}
