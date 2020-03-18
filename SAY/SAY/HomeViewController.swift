//
//  ViewController.swift
//  SAY
//
//  Created by Антон Степанок on 15.03.2020.
//  Copyright © 2020 Антон Степанок. All rights reserved.
//

import UIKit
import WavesSDK
import WavesSDKCrypto
import WavesSDKExtensions
import Foundation
//import XCTest
import RxSwift

import Foundation
import CoreData

struct MessageItem {
    let id: String
    let label: String
    let date: String
}

class HomeViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    private var wavesService = WavesService()
    private var userId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMessages()
        
        tableView.dataSource = self
        let cellNib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "CustomTableViewCell")
    }
    
    private var data: [MessageItem] = []
//        MessageItem(id: "1", label: "I'm a good programmer. I mean, it's the only thing I am good at. I mean, last year, I threw a Frisbee and it chipped my tooth.", date: "13 March 2019"),
//        MessageItem(id: "2", label: "I'm a good programmer. I mean, it's the only thing I am good at. I mean, last year, I threw a Frisbee and it chipped my tooth.", date: "13 March 2019"),
//        MessageItem(id: "3", label: "I'm a good programmer. I mean, it's the only thing I am good at. I mean, last year, I threw a Frisbee and it chipped my tooth.", date: "13 March 2019"),
//        MessageItem(id: "4", label: "I'm a good programmer. I mean, it's the only thing I am good at. I mean, last year, I threw a Frisbee and it chipped my tooth.", date: "13 March 2019"),
//        MessageItem(id: "5", label: "I'm a good programmer. I mean, it's the only thing I am good at. I mean, last year, I threw a Frisbee and it chipped my tooth.", date: "13 March 2019"),
//        MessageItem(id: "6", label: "I'm a good programmer. I mean, it's the only thing I am good at. I mean, last year, I threw a Frisbee and it chipped my tooth.", date: "13 March 2019"),
//    ]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return data.count
    }
    
    private func loadMessages() -> Void {
        var messageList: [DataEntry]?
        wavesService.downloadMessages() { [weak self] dataEntries in
            messageList = dataEntries
            print("Checkpoint 3")
            print(messageList)
                  var messageItems = [MessageItem]()
                  if messageList != nil {
                      let messageList = messageList as! [DataEntry]
                      for msg in messageList{
                          let dateTextPair = msg.value.components(separatedBy: " // ")
                          let text = dateTextPair[1]
                        let date = Date(timeIntervalSince1970: Double(dateTextPair[0])!/1000.0 as! TimeInterval)
                          let dateFormatter = DateFormatter()
                          dateFormatter.dateFormat = "dd.MM.yyyy" //Specify your format that you want
                          let strDate = dateFormatter.string(from: date)
                          self?.data.append(MessageItem(id: msg.key, label: text, date: strDate))
                      }
                  }
            print("Checkpoint 5")
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        print("Checkpoint 4")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as! CustomTableViewCell
            
         let item = data[indexPath.row] //2.
        
        cell.delegate = self
        cell.messageItem = item
        cell.message.layer.cornerRadius = 12
        cell.message.layer.masksToBounds = true
        cell.message.text = item.label //3.
        cell.date.text = item.date
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
            
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

extension HomeViewController: MessageShareDelegate {
    func shareButtonPressed(messageItem: MessageItem) {
              let text = "https://rinta01.github.io/say-frontend/#" + (messageItem.id)
      
              // set up activity view controller
              let textToShare = [ text ]
              let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
              activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
      
              // exclude some activity types from the list (optional)
              activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
      
              // present the view controller
              self.present(activityViewController, animated: true, completion: nil)
    }
}
