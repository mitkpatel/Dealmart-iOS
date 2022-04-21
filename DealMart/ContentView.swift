//
//  ContentView.swift
//  DealMart
//
//  Created by user215540 on 3/23/22.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("log_Status") var log_Status: Bool = false
    @State var splashAnimation: Bool = false
    @Environment(\.colorScheme) var scheme
    @State var removeSplashScreen: Bool = false
    
    var body: some View {
        
        ZStack{
            
            Group{
                if log_Status{
                    MainPage()
                }
                else{
                    WalkThroughPage()
                }
            }
            
            
            if !removeSplashScreen{
                
                Color("Purple")
                    .ignoresSafeArea()
                Image("icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
                    .scaleEffect(splashAnimation ? 35 : 1)
                VStack{
                    Text("DealMart")
                        .tracking(5)
                        .padding(.top,200)
                        .font(.system(size: 40))
                        .foregroundColor(.red)
                }
                .padding(.vertical,70)
                .padding(.horizontal,90)
            }
        }
        
        .preferredColorScheme(splashAnimation ? nil : .light)
        .onAppear {
            
            // Animating with slight delay of 0.4s...
            // for smooth animation...
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                
                withAnimation(.easeInOut(duration: 0.4)){
                    splashAnimation.toggle()
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    
                    removeSplashScreen = true
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
