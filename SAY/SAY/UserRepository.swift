//
//  UserRepository.swift
//  SAY
//
//  Created by Ilya Gromov on 18/03/2020.
//  Copyright © 2020 Антон Степанок. All rights reserved.
//

import Foundation
import CoreData

protocol NumOfMessagesDelegate: class {
     // you can add parameters if you want to pass. something to controller
    func NumOfMessagesUpdated(numOfMessages: Int)
}

final class UserRepository {
    static var coreDataHelper = CoreDataHelper()
    static var wavesService = WavesService()
    public static weak var delegate: NumOfMessagesDelegate?
    
    public static var numberOfMessages: Int = 0
    
    public static func getUser() -> User? {
        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        do {
            let fetchedResults = try coreDataHelper.context.fetch(fetchRequest)
            if fetchedResults.count == 0 {
                guard let newUser = createUser() else {return nil}
                return newUser
            }
            else {
                return fetchedResults[0]
            }
            }
        catch {
            print("Something went worng")
            return nil
        }
    }

    private static func createUser() -> User? {
        // Random seed for real operation
//        let newSeed = wavesService.generateUserSeed()
        // Default seed for testing purposes
        let newSeed = "student draft picnic pass security short cook usual below prefer fashion curious scissors over opera"
        guard let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: coreDataHelper.context) as? User else { return nil }
        newUser.seed = newSeed
        newUser.name = "Vladimir Zhur"
        coreDataHelper.saveContext()
        return newUser
    }
    
    public static func setNumberOfMessages(num: Int){
        numberOfMessages = num
        delegate?.NumOfMessagesUpdated(numOfMessages: num)
    }
}
