//
//  Product.swift
//  gShoppingList
//
//  Created by angi1g on 26/02/24.
//

import Foundation
import SwiftData

@Model
class Product {
    @Attribute(.unique) var name = ""
    var type = ""
    var toBuy = false
    var addedBy = ""
    var addedOn = Date()
    
    init(name: String = "", type: String = "", toBuy: Bool = false, addedBy: String = "", addedOn: Date = Date()) {
        self.name = name
        self.type = type
        self.toBuy = toBuy
        self.addedBy = addedBy
        self.addedOn = addedOn
    }
}
