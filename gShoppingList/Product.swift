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
    var name = ""
    var type = ""
    var toBuy = false
    var addedBy = ""
    var addedOn = Date() // TODO: salvare un array con le ultime 10 date in cui il prodotto è stato aggiunto in modo da suggerire il prossimo acquisto
    
    init(name: String = "", type: String = "", toBuy: Bool = false, addedBy: String = "", addedOn: Date = Date()) {
        self.name = name
        self.type = type
        self.toBuy = toBuy
        self.addedBy = addedBy
        self.addedOn = addedOn
    }
}
