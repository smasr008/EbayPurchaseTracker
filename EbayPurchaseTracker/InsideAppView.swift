//
//  InsideAppView.swift
//  EbayPurchaseTracker
//
//  Created by samira masri on 7/21/24.
//

import SwiftUI
 
struct Purchase: Identifiable {
    let id = UUID()
    let itemName: String
    let price: String
    let purchaseDate: String
}
 
struct InsideAppView: View {
    @State private var purchases: [Purchase] = [
        Purchase(itemName: "Item 1", price: "$10", purchaseDate: "2024-07-21"),
        Purchase(itemName: "Item 2", price: "$20", purchaseDate: "2024-07-20")
    ]
    @State private var isAddPurchaseViewPresented = false
 
    var body: some View {
        NavigationView {
            List(purchases) { purchase in
                VStack(alignment: .leading) {
                    Text(purchase.itemName)
                        .font(.headline)
                    Text("Price: \(purchase.price)")
                    Text("Date: \(purchase.purchaseDate)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .navigationTitle("Recent Purchases")
            .navigationBarItems(trailing: Button(action: {
                self.isAddPurchaseViewPresented = true
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $isAddPurchaseViewPresented) {
                AddPurchaseView(purchases: $purchases)
            }
        }
    }
}
 
#Preview {
    InsideAppView()
}
