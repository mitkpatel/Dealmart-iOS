//
//  WalkThroughPage.swift
//  DealMart
//
//  Created by user215540 on 3/25/22.
//

import SwiftUI

struct WalkThroughPage: View {
    @AppStorage("currentPage") var currentPage = 1
    var body: some View {
     
        if currentPage > totalPages{
            OnBoardingPage()
        }
        else{
            WalkthroughScreen()
        }
    }
}

struct WalkThroughPage_Previews: PreviewProvider {
    static var previews: some View {
        WalkThroughPage()
    }
}

struct WalkthroughScreen: View {
    
    @AppStorage("currentPage") var currentPage = 1
    
    var body: some View{
        
        ZStack{
            
            if currentPage == 1{
                ScreenView(image: "discount", title: "Save Money", detail: "Here you can get the products at \nreasonable price compare to market.", bgColor: Color("color1"))
                    .transition(.scale)
            }
            
            if currentPage == 2{
            
                ScreenView(image: "Welcome", title: "Get Best Deals", detail: "Find the best offers and discounts on the new arrivals.", bgColor: Color("color2"))
                    .transition(.scale)
            }
            
            if currentPage == 3{
                
                ScreenView(image: "wishlist", title: "Easy to wishlist", detail: "Save the products in the wishlist to check\n on them at later.", bgColor: Color("color3"))
                    .transition(.scale)
            }
            
        }
        .overlay(
        
            Button(action: {
                withAnimation(.easeInOut){
                    
                    if currentPage <= totalPages{
                        currentPage += 1
                    }
                }
            }, label: {
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(width: 60, height: 60)
                    .background(Color.white)
                    .clipShape(Circle())
            
                // Circlular Slider
                    .overlay(
                    
                        ZStack{
                            
                            Circle()
                                .stroke(Color.black.opacity(0.04),lineWidth: 4)
                                
                            
                            Circle()
                                .trim(from: 0, to: CGFloat(currentPage) / CGFloat(totalPages))
                                .stroke(Color.white,lineWidth: 4)
                                .rotationEffect(.init(degrees: -90))
                        }
                        .padding(-15)
                    )
            })
            .padding(.bottom,20)
            
            ,alignment: .bottom
        )
    }
}

struct ScreenView: View {
    
    var image: String
    var title: String
    var detail: String
    var bgColor: Color
    
    @AppStorage("currentPage") var currentPage = 1
    
    var body: some View {
        VStack(spacing: 20){
            
            HStack{
                
                if currentPage == 1{
                    Text("Shop with\nDealmart")
                        .font(.title)
                        .fontWeight(.semibold)
                        .kerning(1.4)
                }
                else{
                    Button(action: {
                        withAnimation(.easeInOut){
                            currentPage -= 1
                        }
                    }, label: {
                        
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .padding(.vertical,10)
                            .padding(.horizontal)
                            .background(Color.black.opacity(0.4))
                            .cornerRadius(10)
                    })
                }
                
                Spacer()
                
                Button(action: {
                    withAnimation(.easeInOut){
                        currentPage = 4
                    }
                }, label: {
                    Text("Skip")
                        .fontWeight(.semibold)
                        .kerning(1.2)
                })
            }
            .foregroundColor(.black)
            .padding()
            
            Spacer(minLength: 0)
            
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.top)
            
            Text(detail)
                .fontWeight(.semibold)
                .kerning(1.3)
                .multilineTextAlignment(.center)

            Spacer(minLength: 120)
        }
        .background(bgColor.cornerRadius(10).ignoresSafeArea())
    }
}

var totalPages = 3

