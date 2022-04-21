//
//  ContentView.swift
//  DealMart
//
//  Created by user215540 on 3/25/22.
//

import SwiftUI

let customFont = "Raleway-Regular"

struct OnBoardingPage: View {
    
    @State var showLoginPage: Bool = false
    var body: some View {
        
        VStack(alignment: .leading){
            
            Text("Let's shop\nTogether")
                .font(.custom(customFont, size: 55))
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Image("splash1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.vertical,60)
            Button {
                withAnimation{
                    showLoginPage = true
                }
            } label: {
             
                Text("Get started")
                    .font(.custom(customFont, size: 18))
                    .fontWeight(.semibold)
                    .padding(.vertical,18)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                    .foregroundColor(Color("Purple"))
            }
            .padding(.horizontal,30)
            .offset(y: getRect().height < 750 ? 20 : 40)
            
            Spacer()
        }
        .padding()
        .padding(.top,getRect().height < 750 ? 0 : 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
        
            Color("Purple")
        )
        .overlay(
        
            Group{
                if showLoginPage{
                    LoginPage()
                        .transition(.move(edge: .bottom))
                }
            }
        )
    }
}

struct OnBoardingPage_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingPage()
    }
}

extension View{
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
}
