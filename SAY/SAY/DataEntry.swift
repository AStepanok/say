//
//  Block.swift
//  SAY
//
//  Created by Ilya Gromov on 18/03/2020.
//  Copyright © 2020 Антон Степанок. All rights reserved.
//

import Foundation

struct DataEntry: Decodable {
    let type: String
    let value: String
    let key: String
}
