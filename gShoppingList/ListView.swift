//
//  ContentView.swift
//  gShoppingList
//
//  Created by angi1g on 26/02/24.
//

import SwiftUI
import SwiftData

struct ListView: View {
    @Environment(\.modelContext) var modelContext
    @Query(filter: #Predicate<Product> { product in
        product.toBuy == true
    }) private var products: [Product]
    @State private var sheetIsPresented = false
    
    var body: some View {
        NavigationStack {
            Text("Lista della Spesa")
                .font(.title)
                .bold()
            List {
                ForEach(products) { product in
                    ProductNameView(product: product)
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        sheetIsPresented.toggle()
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
            }
            .listStyle(.plain)
            .sheet(isPresented: $sheetIsPresented) {
                NavigationStack {
                    ProductsView()
                }
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        for index in offsets {
            products[index].toBuy = false
        }
    }
}

#Preview {
    ListView()
        .modelContainer(for: Product.self, inMemory: true)
}
