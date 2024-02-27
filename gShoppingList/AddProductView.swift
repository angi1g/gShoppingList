//
//  AddListView.swift
//  gListaSpesa
//
//  Created by angi1g on 22/02/24.
//

import SwiftUI
import SwiftData

struct AddProductView: View {
    @Environment(\.modelContext) var modelContext
    @Query(filter: #Predicate<Product> { product in
        product.toBuy == false
    }) private var products: [Product]
    @State private var searchProduct = Product()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Group {
            TextField("Nome del prodotto", text: $searchProduct.name)
                .font(.title)
            TextField("Genere del prodotto", text: $searchProduct.type)
                .font(.title2)
        }
        .textFieldStyle(.roundedBorder)
        .overlay {
            RoundedRectangle(cornerRadius: 5)
                .stroke(.gray.opacity(0.5), lineWidth: 2)
        }
        .padding(.horizontal)
        
        Text("Lista dei Prodotti")
            .font(.title)
            .bold()
            .padding(.top)
        
        List {
            ForEach(products) { product in
                if showProduct(product: product) {
                    ProductNameView(product: product)
                        .onTapGesture {
                            product.toBuy = true
                            modelContext.insert(product)
                        }
                }
            }
            .onDelete(perform: deleteItems)
        }
        .listStyle(.plain)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button(role: .cancel) {
                    dismiss()
                } label: {
                    Text("Indietro")
                }
            }
            ToolbarItem {
                Button(action: addItem) {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(products[index])
            }
        }
    }
    
    private func addItem() {
        let newProduct = Product()
        newProduct.name = searchProduct.name
        newProduct.type = searchProduct.type
        modelContext.insert(newProduct)
        searchProduct.name = ""
        searchProduct.type = ""
    }
    
    private func showProduct(product: Product) -> Bool {
        if (searchProduct.name.trimmingCharacters(in: .whitespacesAndNewlines) == "" || product.name.contains(searchProduct.name)) && (searchProduct.type.trimmingCharacters(in: .whitespacesAndNewlines) == "" || product.type.contains(searchProduct.type)) {
            return true
        }
        return false
    }
}

#Preview {
    NavigationStack {
        AddProductView()
        .modelContainer(for: Product.self, inMemory: true)
    }
}
