//
//  WavesApiService.swift
//  SAY
//
//  Created by Ilya Gromov on 17/03/2020.
//  Copyright © 2020 Антон Степанок. All rights reserved.
//
import UIKit
import WavesSDK
import WavesSDKCrypto
import WavesSDKExtensions
import Foundation
//import XCTest
import RxSwift

final class WavesService {

    let address = URL(string: "https://server.vlzhr.top/sayit/")
    let jsonDecoder = JSONDecoder()
    let crypto = WavesCrypto()
    let disposeBag: DisposeBag = DisposeBag()
    
    func downloadMessages(completion: @escaping ([DataEntry]?) -> Void) {
        guard let url = address else { return }
        print("Checkpoint 1")
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data else { return }
            print("Checkpoint 2")
            let dataEntries = try? self?.jsonDecoder.decode([DataEntry].self, from: data)
//            let returnData = String(data: data, encoding: .utf8)
            completion(dataEntries)
        }
        task.resume()
    }
    
    func publishMessage(seed: Seed, messageId: String, text: String) {

        let timestamp = Int64(Date().timeIntervalSince1970) * 1000
        guard let senderPublicKey = WavesCrypto.shared.publicKey(seed: seed) else { return }
        
        let mid = NodeService.Query.Transaction.InvokeScript.Arg.init(value: .string(messageId))
        let text = NodeService.Query.Transaction.InvokeScript.Arg.init(value: .string(text))

        var queryModel = NodeService.Query.Transaction.InvokeScript.init(chainId: "T",
                                                                         fee: 500000,
                                                                         timestamp: timestamp,
                                                                         senderPublicKey: senderPublicKey,
                                                                         feeAssetId: "WAVES",
                                                                         dApp: "3N9uzN2kjrwCnrmHAhw7m3FdKhkJ69SGL6F",
                                                                         call: .init(function: "say",args: [mid, text]),
                                                                         payment: [.init(amount: 1, assetId: "WAVES")])

        queryModel.sign(seed: seed)
        
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
    
    func generateUserSeed() -> String {
        let newSeed: Seed = crypto.randomSeed()
        return newSeed
    }
    
}
