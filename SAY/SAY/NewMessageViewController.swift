//
//  NewMessageViewController.swift
//  SAY
//
//  Created by Антон Степанок on 15.03.2020.
//  Copyright © 2020 Антон Степанок. All rights reserved.
//

import UIKit

class NewMessageViewController: UIViewController {

    private var wavesService = WavesService()
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        let text = textView.text ?? ""
        if text.count == 0 { return }
        
        // Always a User
        let user = UserRepository.getUser() as! User
        let userSeed = user.seed ?? ""
        if userSeed.count == 0 { return }
        let mid = UserRepository.numberOfMessages + 1
        wavesService.publishMessage(seed: userSeed, messageId: String(mid), text: text)
        let alertController = UIAlertController(title: "Forever and ever", message:
              "Your message is on its way to blockchain", preferredStyle: .alert)
          alertController.addAction(UIAlertAction(title: "Thanks", style: .default))
          self.present(alertController, animated: true, completion: nil)
        textView.text = "Do you wish to do it one more time?"
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
