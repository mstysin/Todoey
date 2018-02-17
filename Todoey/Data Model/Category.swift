//
//  Category.swift
//  Todoey
//
//  Created by mstysin on 1/30/18.
//  Copyright © 2018 Stysin Technoogies. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
   @objc dynamic var name: String = ""
    let items = List<Item>()
}
