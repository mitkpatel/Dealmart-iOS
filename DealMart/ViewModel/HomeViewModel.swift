//
//  ContentView.swift
//  DealMart
//
//  Created by user215540 on 3/24/22.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {

    @Published var productType: ProductType = .Electronics
    
    // Sample items
    @Published var products: [Product] = [
    
        Product(type: .Electronics, title: "Apple Airpods", subtitle: "2nd Generation: White", description: "Effortless setup, easy access to Siri, easily share audio between two sets of AirPods on your iPhone, iPad or Apple TV.", details: "Apple AirPods with wired charging case.", price: "$120.99",productImage: "AppleAirpods"),
        Product(type: .Electronics, title: "Logitech Mouse", subtitle: "Wired Gaming Mouse", description: "G203 2nd Gen Wired gaming Mouse.", details: "Logitech G203 2nd Gen Wired Gaming Mouse, 8000 DPi, Rainbow optical Effect LIGHTSYNC RGB, 6 Programmable Buttons.", price: "$39.13", productImage: "Mouse"),
        Product(type: .Electronics, title: "Canon Camera", subtitle: "EOS M50 Mark II:Black", description: "Canon Mirrorless Camera.", details: "Mirrorless Camera with 15-45mm IS STM Lens Kit.", price: "$949", productImage: "Camera"),
        
        Product(type: .Fashion, title: "Dress for Women", subtitle: "Red", description: "Get the designer dress for women", details: "Beautiful red dress with floral design", price: "$839.10", productImage: "fashion1"),
        Product(type: .Fashion, title: "Professional style", subtitle: "Pink", description: "Get an elegant professional look", details: " Pink Professional look for Women", price: "$800", productImage: "fashion2"),
        Product(type: .Fashion, title: "Collar Flared Dress", subtitle: "Yellow", description: "Get a smart look with the collar flared dress", details: "Collar Flared Yellow Dress for women", price: "$520", productImage: "fashion3"),
        Product(type: .Fashion, title: "Mini Dress", subtitle: "Black", description: "Black Floral Button up mini dress", details: "Black Mini Dress for Women", price: "699", productImage: "fashion4"),
        
        Product(type: .Footware, title: "Shoes for Women", subtitle: "Sky Blue", description: "Get a classy look", details: "Available with 50% OFF when you purchase a product of $500", price: "$299", productImage: "footwear1"),
        Product(type: .Footware, title: "High Heel", subtitle: "Gold color", description: "Gold metallic leather high heel.", details: "Made of pure leather", price: "$990", productImage: "footwear2"),
        Product(type: .Footware, title: "Shoes for Men", subtitle: "Black", description: "Classy look with comfort", details: "Most popular in the market", price: "$999", productImage: "footwear3"),
        Product(type: .Footware, title: "Walking Shoe for Men", subtitle: "Casual Fashion Walking Shoe", description: "X Ray Footwear Men's Brighton Low Top Casual Walking Shoe Sneaker", details: "Casual Walking Shoe", price: "$399", productImage: "footwear4"),
        
        Product(type: .Specs, title: "Eyeglasses for women", subtitle: "A15 - Brown", description: "Get your eyeglasses at affordable rate", details: "Available with amazing discounts.", price: "$199", productImage: "eyeglasses1"),
        Product(type: .Specs, title: "Ray-Ban Eyeglasses", subtitle: "M1", description: "Ray-Ban RB5228", details: "Available when you purchase any new product or $100 or more", price: "$159", productImage: "eyeglasses2"),
        Product(type: .Specs, title: "Eyeglasses", subtitle: "Pink", description: "Pink eyeglasses for women.", details: "Get your eyeglasses at affordable rate", price: "$199", productImage: "eyeglasses3"),
    ]
    
    @Published var filteredProducts: [Product] = []
    @Published var showMoreProductsOnType: Bool = false
    @Published var searchText: String = ""
    @Published var searchActivated: Bool = false
    @Published var searchedProducts: [Product]?
    
    var searchCancellable: AnyCancellable?
    
    init(){
        filterProductByType()
        
        searchCancellable = $searchText.removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: { str in
                if str != ""{
                    self.filterProductBySearch()
                }
                else{
                    self.searchedProducts = nil
                }
            })
    }
    
    func listAllProducts() -> [Product]{
        
     /*   DispatchQueue.global(qos: .userInteractive).async {
            
            let results = self.products
                .lazy
                .filter { product in
                    
                    return product.type == self.productType
                }
                .prefix(4)
            
            DispatchQueue.main.async {
                
                self.filteredProducts = results.compactMap({ product in
                    return product
                })
            }
        }*/
        
       /* var image = ""
        var title = ""
        for product in products{
            image = product.productImage
            title = product.title
        */
        
        return products
    }
    
    func filterProductByType(){
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            let results = self.products
                .lazy
                .filter { product in
                    
                    return product.type == self.productType
                }
                .prefix(4)
            
            DispatchQueue.main.async {
                
                self.filteredProducts = results.compactMap({ product in
                    return product
                })
            }
        }
    }
    
    func filterProductBySearch(){
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            let results = self.products
                .lazy
                .filter { product in
                    return product.title.lowercased().contains(self.searchText.lowercased())
                }
            
            DispatchQueue.main.async {
                
                self.searchedProducts = results.compactMap({ product in
                    return product
                })
            }
        }
    }
}
