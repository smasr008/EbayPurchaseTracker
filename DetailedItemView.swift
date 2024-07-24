//
//  DetailedItemView.swift
//  Purchase-Tracker
//
//  Created by Abraham Correa on 7/17/24.
//


//Code to be inserted in main file
//==================================================================
//1. State var for sheet toggle
//@State private var isDetailedItemViewPresented = false
//
//2. Button to pull up detailed item view
//Button(action: {
//    isDetailedItemViewPresented.toggle()
//}) {
//    Image("image path here")
//}.sheet(isPresented: $isDetailedItemViewPresented){
//        DetailedItemView()
//    }
//==================================================================

import SwiftUI

struct DetailedItemView: View {
    var item: Item
    var body: some View{
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20){
                    Spacer()
                    Text(item.name)
                        .font(.title)
                        .fontWeight(.bold)
                    item.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(12)
                    Text(item.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                    Spacer()
                }
                .padding()
            }
            .navigationBarTitle("Item Details", displayMode: .inline)
        }
    }
}




struct Item {
    var name: String
    var image: Image
    var description: String
}


//Example
struct DetailedItemView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedItemView(item: Item(name: "Bicycle", image: Image(systemName: "bicycle"), description: "this bike is perfect for both city streets and rugged trails. It comes with hydraulic disc brakes for reliable stopping power in any weather, new puncture-resistant tires, and minimal cosmetic wear. Includes a kickstand and water bottle holder, making it a great choice for both commuting and leisurely rides."))
    }
}

