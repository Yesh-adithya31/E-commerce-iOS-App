//
//  HomeViewModel.swift
//  e-clothing-app
//
//  Created by Ovini on 2024-03-28.
//

import Foundation
import Firebase
import Combine

class HomeViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var filterProducts: [Product] = []
    @Published var uniqueCategories: Set<String> = []
    @Published var showMoreProductOnCategory : Bool = false
    
    @Published var searchText: String = ""
    @Published var searchActivated: Bool = false
    
    @Published var searchProducts: [Product]?
    
    
    let ref = Database.database().reference().child("products")
    
    var searchCancellable: AnyCancellable?
    
    init(){
        searchCancellable = $searchText.removeDuplicates().debounce(for: 0.5, scheduler: RunLoop.main).sink(receiveValue: { str in
            if str != ""{
                self.filterProductBySearch()
            }else{
                self.searchProducts = nil
            }
        })
    }
    
    func fetchData() {
        ref.observe(.value) { snapshot in
            var fetchedProducts: [Product] = []
            var uniqueCategories: Set<String> = ["All"]
            
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let dict = snapshot.value as? [String: Any] {
                    let id = snapshot.key
                    if let title = dict["title"] as? String,
                       let description = dict["description"] as? String,
                       let category = dict["category"] as? String,
                       let image = dict["image"] as? String,
                       let price = dict["price"] as? Double,
                       let ratingDict = dict["rating"] as? [String: Any],
                       let ratingCount = ratingDict["count"] as? Int,
                       let ratingRate = ratingDict["rate"] as? Double  {
                        let product = Product(id: id, title: title, description: description, category: category, image: image, price: price, ratingCount: ratingCount, ratingRate: ratingRate, quantity: 1)
                        fetchedProducts.append(product)
                        uniqueCategories.insert(category)
                    }
                }
            }
            DispatchQueue.main.async {
                self.products = fetchedProducts
                self.filterProducts = Array(fetchedProducts.prefix(8))
                self.uniqueCategories = uniqueCategories
            }
        }
    }
    
    func filterByCategory(category: String) {
        DispatchQueue.global(qos: .userInteractive).async {
            let results: [Product]
            if category == "All" {
                results = self.products
            } else {
                results = self.products.lazy.filter { product in
                    return product.category == category
                }
            }
            
            DispatchQueue.main.async {
                self.filterProducts = Array(results.prefix(4))
            }
        }
    }
    
    func filterProductBySearch() {
        DispatchQueue.global(qos: .userInteractive).async {
            let results: [Product]
                results = self.products.lazy.filter { product in
                    return product.title.lowercased().contains(self.searchText.lowercased())
                }
            
            
            DispatchQueue.main.async {
                self.searchProducts = Array(results)
            }
        }
    }
}
