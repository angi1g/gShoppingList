//
//  ProductNameView.swift
//  gShoppingList
//
//  Created by Barbara on 27/02/24.
//

import SwiftUI

struct ProductNameView: View {
    var product: Product
    
    var body: some View {
        if product.type == "" {
            Text("\(product.name)")
                .font(.title2)
        } else {
            Text("\(product.name) [\(product.type)]")
                .font(.title2)
        }
    }
}

#Preview {
    ProductNameView(product: Product(name: "Banana", type: "Frutta"))
}
