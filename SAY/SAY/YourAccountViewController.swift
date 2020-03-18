//
//  YourAccountViewController.swift
//  SAY
//
//  Created by mac on 17.03.2020.
//  Copyright © 2020 Антон Степанок. All rights reserved.
//

import UIKit

struct InfoBox {
    let name: String
    let value: String
}

class YourAccountViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    imageView.layer.cornerRadius = imageView.frame.size.width/2

        // Do any additional setup after loading the view.
    }
    
    private var data: [InfoBox] = [
        InfoBox(name: "Public Key", value: "GTS7nZ9cvQzcLonrhFJHdsb27b"),
        InfoBox(name: "Seed", value: "Brown Fox Barely Barking Smoker"),
    ]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoBox", for: indexPath)
        let item = data[indexPath.row]
        
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = item.value
        
        return cell
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
