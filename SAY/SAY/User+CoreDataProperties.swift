//
//  User+CoreDataProperties.swift
//  SAY
//
//  Created by Ilya Gromov on 18/03/2020.
//  Copyright © 2020 Антон Степанок. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var seed: String?
    @NSManaged public var name: String?

}
