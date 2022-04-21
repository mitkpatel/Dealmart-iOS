//
//  ContentView.swift
//  DealMart
//
//  Created by user215540 on 3/25/22.
//

import SwiftUI

class SharedDataModel: ObservableObject {
    
    // Detail Product Data
    @Published var detailProduct: Product?
    @Published var showDetailProduct: Bool = false
    @Published var fromSearchPage: Bool = false
    
    @Published var likedProducts: [Product] = []
    @Published var cartProducts: [Product] = []
    
    // Calculating Total price
    func getTotalPrice()->String{
        
        var total: Int = 0
        
        cartProducts.forEach { product in
            
            let price = product.price.replacingOccurrences(of: "$", with: "") as NSString
            
            let quantity = product.quantity
            let priceTotal = quantity * price.integerValue
            
            total += priceTotal
        }
        
        return "$\(total)"
    }
}
