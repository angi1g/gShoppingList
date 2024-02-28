//
//  AddListView.swift
//  gListaSpesa
//
//  Created by angi1g on 22/02/24.
//

import SwiftUI
import SwiftData

struct ProductsView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Product.name) private var products: [Product]
    @State private var searchProduct = Product()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Group {
            TextField("Nome del prodotto", text: $searchProduct.name)
                .font(.title2)
            TextField("Genere del prodotto", text: $searchProduct.type)
                .font(.title3)
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
                            product.toBuy.toggle()
                            if product.toBuy {
                                product.addedOn = Date.now
                                // TODO: aggiungere anche addedBy
                            }
                            modelContext.insert(product)
                        }
                }
            }
            .onDelete(perform: deleteItems)
        }
        .listStyle(.plain)
        .toolbar {
            /* NON SERVE
            ToolbarItem(placement: .cancellationAction) {
                Button(role: .cancel) {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                }
            }*/
            ToolbarItem {
                Button(action: addItem) {
                    Label("Aggiungi", systemImage: "plus")
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
        newProduct.name = searchProduct.name.trimmingCharacters(in: .whitespacesAndNewlines)
        newProduct.type = searchProduct.type.trimmingCharacters(in: .whitespacesAndNewlines)
        newProduct.toBuy = true
        newProduct.addedOn = Date.now
        // TODO: aggiungere anche addedBy
        if !newProduct.name.isEmpty {
            modelContext.insert(newProduct)
        }
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
        ProductsView()
        .modelContainer(for: Product.self, inMemory: true)
    }
}
