//
//  AddPurchaseView.swift
//  EbayPurchaseTracker
//
//  Created by samira masri on 7/24/24.
//

import SwiftUI
 
struct AddPurchaseView: View {
    @Binding var purchases: [Purchase]
    @State private var itemName: String = ""
    @State private var price: String = ""
    @State private var purchaseDate: String = ""
    @Environment(\.presentationMode) var presentationMode
 
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Item Details")) {
                    TextField("Item Name", text: $itemName)
                    TextField("Price", text: $price)
                    TextField("Purchase Date", text: $purchaseDate)
                }
 
                Button(action: {
                    let newPurchase = Purchase(itemName: itemName, price: price, purchaseDate: purchaseDate)
                    purchases.append(newPurchase)
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Add Purchase")
                }
            }
            .navigationTitle("Add Purchase")
            .navigationBarItems(trailing: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Cancel").bold()
            })
        }
    }
}
 
#Preview {
    AddPurchaseView(purchases: .constant([Purchase(itemName: "Item 1", price: "$10", purchaseDate: "2024-07-21")]))
}
 
