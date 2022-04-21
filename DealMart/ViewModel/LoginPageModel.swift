//
//  ContentView.swift
//  DealMart
//
//  Created by user215540 on 3/23/22.
//

import SwiftUI

class LoginPageModel: ObservableObject {
    
    // Login Properties
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showPassword: Bool = false
    
    // Register Properties
    @Published var registerUser: Bool = false
    @Published var re_Enter_Password: String = ""
    @Published var showReEnterPassword: Bool = false
    
    
    @AppStorage("log_Status") var log_Status: Bool = false
    
    
    func Login(){
       
        withAnimation{
            log_Status = true
        }
    }
    
    func Logout(){
       
        withAnimation{
            log_Status = false
        }
    }
    func Register(){
      
        withAnimation{
            log_Status = true
        }
    }
    
}


