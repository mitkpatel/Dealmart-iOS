//
//  ContentView.swift
//  DealMart
//
//  Created by user215540 on 3/28/22.
//

import SwiftUI

struct MoreProductsView: View {
   
    var body: some View {
        var homeViewModel = HomeViewModel()
        var productList = homeViewModel.listAllProducts()
        var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
        
        NavigationView{
             ScrollView{
                 LazyVGrid(columns: gridItemLayout, spacing: 20){
                     ForEach((productList), id: \.self){
                         item in
                         VStack{
                             Image(item.productImage)
                                 .resizable()
                                 .frame(width:200, height:200)
                                 .padding()
                             Text(item.title)
                         }
                         
                     }
                 }
             }
           
        }.navigationBarTitle("More Products")
        
       
      //  Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct MoreProductsView_Previews: PreviewProvider {
    static var previews: some View {
        MoreProductsView()
    }
}
