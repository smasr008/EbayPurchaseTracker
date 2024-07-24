import SwiftUI

struct SearchView: View {
    @State private var searches: [Search] = []
    @State private var newSearch = Search()
    @State private var customSavedName: String = ""
    @State private var searchResults: [Auction] = []
    @State private var testAuctions: [Auction] = TestAuctionData.generateTestAuctions()
    @State private var selectedSearchID: UUID? = nil
    @State private var hasSearched: Bool = false
    @State private var showSearchForm: Bool = true

    var body: some View {
        VStack {
            if showSearchForm {
                Form {
                    Section(header: Text("Price Range")) {
                        TextField("Max Price:", value: $newSearch.maxPrice, format: .number)
                        TextField("Min Price:", value: $newSearch.minPrice, format: .number)
                    }
                    
                    Section(header: Text("Purchase Date Range")) {
                        Toggle("Specify Purchase Date(s)", isOn: $newSearch.specifyPurchaseDates)
                        
                        if newSearch.specifyPurchaseDates {
                            DatePicker("Earliest Date:", selection: Binding(
                                get: { newSearch.earliestDate ?? Date() },
                                set: { newSearch.earliestDate = $0 }
                            ), displayedComponents: .date)
                            
                            DatePicker("Latest Date:", selection: Binding(
                                get: { newSearch.latestDate ?? Date() },
                                set: { newSearch.latestDate = $0 }
                            ), displayedComponents: .date)
                        }
                    }
                    
                    Section(header: Text("Name and Keywords")) {
                        TextField("Name Includes:", text: $newSearch.nameIncludes)
                        Toggle("Search Descriptions?", isOn: $newSearch.searchDescriptions)
                    }
                    
                    Section(header: Text("Delivery")) {
                        VStack {
                            RadioButtonField(
                                title: "Delivered",
                                isSelected: newSearch.hasArrived == true,
                                onSelect: {
                                    newSearch.hasArrived = true
                                }
                            )
                            RadioButtonField(
                                title: "Delivery Pending",
                                isSelected: newSearch.hasArrived == false,
                                onSelect: {
                                    newSearch.hasArrived = false
                                }
                            )
                            
                            RadioButtonField(
                                title: "All",
                                isSelected: newSearch.hasArrived == nil,
                                onSelect: {
                                    newSearch.hasArrived = nil
                                }
                            )
                            
                        }
                    }
                    
                    Button(action: {
                        searchResults = testAuctions.filter { auction in
                            newSearch.matches(auction: auction)
                        }
                        
                        hasSearched = true
                    }) {
                        Text("Run Search")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        newSearch = Search()
                        customSavedName = ""
                        hasSearched = false
                        showSearchForm = true
                    }) {
                        Text("Clear Search")
                            .foregroundColor(.blue)
                    }
                    
                    Section(header: Text("Saved Searches")) {
                        Picker("Select a Saved Search", selection: $selectedSearchID) {
                            Text("None").tag(UUID?.none)
                            ForEach(searches) { search in
                                Text(search.savedName ?? "Unnamed Search").tag(search.id as UUID?)
                            }
                        }
                        .onChange(of: selectedSearchID) { newValue in
                            if let selectedID = newValue, let selectedSearch = searches.first(where: { $0.id == selectedID }) {
                                newSearch = selectedSearch
                                customSavedName = selectedSearch.savedName ?? ""
                            }
                        }
                    }
                }
            }
            
            if hasSearched {
                if searchResults.isEmpty {
                    Text("Sorry, no auctions matched your search criteria.")
                        .foregroundColor(.gray)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .center)
                } else {
                    List {
                        ForEach(searchResults) { auction in
                            VStack(alignment: .leading) {
                                Text("Item Name: \(auction.itemName)")
                                Text("Price: \(auction.price, specifier: "%.2f")")
                                Text("Seller: \(auction.sellerName)")
                                Text("Date: \(auction.date)")
                                Text("Has Arrived: \(auction.hasArrived ? "Yes" : "No")")
                                Text("Description: \(auction.descriptions)")
                            }
                        }
                    }
                }
            }
            
            if hasSearched {
                Button(action: {
                    showSearchForm.toggle()
                }) {
                    Text(showSearchForm ? "Collapse Search Form" : "Expand Search Form")
                        .frame(maxWidth: .infinity)
                        .padding(10)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
        }
        .navigationTitle("Search")
    }
}

struct RadioButtonField: View {
    let title: String
    let isSelected: Bool
    let onSelect: () -> Void

    var body: some View {
        HStack {
            Text(title)
            Spacer()
            if isSelected {
                Image(systemName: "checkmark.circle.fill")
            } else {
                Image(systemName: "circle")
            }
        }
        .onTapGesture {
            onSelect()
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
