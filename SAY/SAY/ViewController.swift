//
//  ViewController.swift
//  SAY
//
//  Created by Антон Степанок on 15.03.2020.
//  Copyright © 2020 Антон Степанок. All rights reserved.
//

import UIKit

struct MessageItem {
    let label: String
    let date: String
}

class ViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        let cellNib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "CustomTableViewCell")
    }
    
    private var data: [MessageItem] = [
        MessageItem(label: "I'm a good programmer. I mean, it's the only thing I am good at. I mean, last year, I threw a Frisbee and it chipped my tooth.", date: "13 March 2019"),
        MessageItem(label: "I'm a good programmer. I mean, it's the only thing I am good at. I mean, last year, I threw a Frisbee and it chipped my tooth.", date: "13 March 2019"),
        MessageItem(label: "I'm a good programmer. I mean, it's the only thing I am good at. I mean, last year, I threw a Frisbee and it chipped my tooth.", date: "13 March 2019"),
        MessageItem(label: "I'm a good programmer. I mean, it's the only thing I am good at. I mean, last year, I threw a Frisbee and it chipped my tooth.", date: "13 March 2019"),
        MessageItem(label: "I'm a good programmer. I mean, it's the only thing I am good at. I mean, last year, I threw a Frisbee and it chipped my tooth.", date: "13 March 2019"),
        MessageItem(label: "I'm a good programmer. I mean, it's the only thing I am good at. I mean, last year, I threw a Frisbee and it chipped my tooth.", date: "13 March 2019"),
    ]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as! CustomTableViewCell
            
         let item = data[indexPath.row] //2.
            
        cell.message.layer.cornerRadius = 12
        cell.message.layer.masksToBounds = true
        cell.message.text = item.label //3.
        cell.date.text = item.date
        
            
         return cell //4.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
