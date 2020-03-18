//
//  UserRepository.swift
//  SAY
//
//  Created by Ilya Gromov on 18/03/2020.
//  Copyright © 2020 Антон Степанок. All rights reserved.
//

import Foundation
import CoreData

final class UserRepository {
    static var coreDataHelper = CoreDataHelper()
    static var wavesService = WavesService()
    
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
        newUser.name = "New User"
        coreDataHelper.saveContext()
        return newUser
    }
}
