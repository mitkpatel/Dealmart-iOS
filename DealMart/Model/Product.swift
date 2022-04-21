//
//  ContentView.swift
//  DealMart
//
//  Created by user215540 on 3/23/22.
//

import SwiftUI

// Product Model
struct Product: Identifiable,Hashable {
    var id = UUID().uuidString
    var type: ProductType
    var title: String
    var subtitle: String
    var description: String = ""
    var details: String = ""
    var price: String
    var productImage: String = ""
    var quantity: Int = 1
}

// Product Types
enum ProductType: String,CaseIterable{
    case Electronics = "Electronics"
    case Fashion = "Fashion"
    case Footware = "Footware"
    case Specs = "Eyeglasses"
    //case Specs = "Specs"
}


