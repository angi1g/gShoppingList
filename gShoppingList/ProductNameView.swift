//
//  ProductNameView.swift
//  gShoppingList
//
//  Created by angi1g on 27/02/24.
//

import SwiftUI

struct ProductNameView: View {
    var product: Product
    
    var body: some View {
        HStack {
            if product.toBuy {
                Image(systemName: "cart")
                    .font(.title2)
            }
            Text(product.name)
                .font(.title2)
            if product.type != "" {
                Text("(\(product.type))")
                    .font(.title3)
            }
        }
    }
}

#Preview {
    ProductNameView(product: Product(name: "Banana", type: "Frutta", toBuy: true))
}
