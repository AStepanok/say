//
//  WavesApiService.swift
//  SAY
//
//  Created by Ilya Gromov on 17/03/2020.
//  Copyright © 2020 Антон Степанок. All rights reserved.
//
import WavesSDKCrypto

final class WavesApiService {

    let address = URL(string: "https://server.vlzhr.top/sayit/")
    let jsonDecoder = JSONDecoder()
    
    func downloadMessages(completion: @escaping ([Block]?) -> Void) {
        guard let url = address else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data else { return }
            let messageList = try? self?.jsonDecoder.decode([Block].self, from: data)
            let returnData = String(data: data, encoding: .utf8)
            completion(messageList)
        }
        task.resume()
        
        
    }
    
}
