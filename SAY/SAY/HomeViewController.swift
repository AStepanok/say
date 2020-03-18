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

struct MessageItem {
    let label: String
    let date: String
}

class HomeViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    public let disposeBag: DisposeBag = DisposeBag()
    private var wavesApiService = WavesApiService()
    private var userId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        loadMessages()
        
        let crypto = WavesCrypto()

        // generating the seed-phrase
//        let newSeed: Seed = crypto.randomSeed()
        let newSeed = "student draft picnic pass security short cook usual below prefer fashion curious scissors over opera"
        let address: String = crypto.address(seed: newSeed, chainId: "T")!
//        print(address)
        guard let senderPublicKey = WavesCrypto.shared.publicKey(seed: newSeed) else { return }
        
        testInvokeTx(seed: newSeed, publicKey: senderPublicKey)

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
    
    private func loadMessages() {
        // importing WavesCrypto part of SDK

        // creating a WavesCrypto object
        let crypto = WavesCrypto()

        // generating the seed-phrase
        let newSeed: Seed = crypto.randomSeed()
        // getting address of this seed-phrase
        // provide chosen network byte in the chainId field ("T" for the Testent, "W" for the Mainnet)
        let address: String = crypto.address(seed: newSeed, chainId: "T")!
        
//        let test = 1
//        wavesApiService.downloadMessages() { [weak self] block in
//        guard let block = block else { return }
//
//            let newVar = block
//        }
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
    
    func testInvokeTx(seed: Seed, publicKey: String) {

        let timestamp = Int64(Date().timeIntervalSince1970) * 1000

        let mid = NodeService.Query.Transaction.InvokeScript.Arg.init(value: .string("3"))
        let text = NodeService.Query.Transaction.InvokeScript.Arg.init(value: .string("Two assure edward whence the was. Who worthy yet ten boy denote wonder. Weeks views her sight old tears sorry. Additions can suspected its concealed put furnished. Met the why particular devonshire decisively considered partiality. Certain it waiting no entered is."))

        var queryModel = NodeService.Query.Transaction.InvokeScript.init(chainId: "T",
                                                                         fee: 500000,
                                                                         timestamp: timestamp,
                                                                         senderPublicKey: publicKey,
                                                                         feeAssetId: "WAVES",
                                                                         dApp: "3N9uzN2kjrwCnrmHAhw7m3FdKhkJ69SGL6F",
                                                                         call: .init(function: "say",args: [mid, text]),
                                                                         payment: [.init(amount: 1, assetId: "WAVES")])

        queryModel.sign(seed: seed)
        
        print(publicKey)
        print(queryModel)
        
        let send = NodeService.Query.Transaction.invokeScript(queryModel)
        
        WavesSDK.shared.services
            .nodeServices
            .transactionNodeService
            .transactions(query: send)
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { (tx) in
                print(tx)
            })
            .disposed(by: disposeBag)

    }

}
