//
//  ContentView.swift
//  DealMart
//
//  Created by user215540 on 3/24/22.
//

import SwiftUI
import Firebase

struct LoginPage: View {
    @StateObject var loginData: LoginPageModel = LoginPageModel()
    @State var alert = false
    @State var alertForError = false
    @State var error = ""
    
    var body: some View {
        
        VStack{
            
            Text("Welcome\nTo Dealmart")
                .font(.custom(customFont, size: 55).bold())
                .foregroundColor(.white)
                .frame(maxWidth: .infinity,alignment: .leading)
                .frame(height: getRect().height / 3.5)
                .padding()
                .background(
                
                    ZStack{
                        
                        // Login section
                        LinearGradient(colors: [
                        
                            Color("LoginCircle"),
                            Color("LoginCircle")
                                .opacity(0.8),
                            Color("Purple")
                        ], startPoint: .top, endPoint: .bottom)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                            .padding(.trailing)
                            .offset(y: 20)
                            .ignoresSafeArea()
                    }
                )
            
            ScrollView(.vertical, showsIndicators: false) {
                
                // Login form
                VStack(spacing: 15){
                    
                    Text(loginData.registerUser ? "Register" : "Login")
                        .font(.custom(customFont, size: 22).bold())
                        .frame(maxWidth: .infinity,alignment: .leading)
                    
                    CustomTextField(icon: "envelope", title: "Email", hint: "dealmart@gmail.com", value: $loginData.email, showPassword: .constant(false))
                        .padding(.top,30)
                    
                    CustomTextField(icon: "lock", title: "Password", hint: "dealmart", value: $loginData.password, showPassword: $loginData.showPassword)
                        .padding(.top,10)
                    
                    // Regsiter page - reenter password
                    if loginData.registerUser{
                        CustomTextField(icon: "envelope", title: "Re-Enter Password", hint: "123456", value: $loginData.re_Enter_Password, showPassword: $loginData.showReEnterPassword)
                            .padding(.top,10)
                    }
                    
                    Button {
                        if loginData.email != "" {
                            
                            Auth.auth().sendPasswordReset(withEmail: loginData.email) { (err) in
                                
                                if err != nil{
                                    
                                    self.error = err!.localizedDescription
                                    self.alertForError.toggle()
                                    return
                                }
                                
                                self.error = "RESET"
                                self.alertForError.toggle()
                            }
                        }
                        else{
                            
                            self.error = "Please enter valid email!"
                            self.alertForError.toggle()
                        }
                    } label: {
                        
                        Text("Forgot password?")
                            .font(.custom(customFont, size: 14))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Purple"))
                    }
                    .padding(.top,8)
                    .frame(maxWidth: .infinity,alignment: .leading)

                    // Login page button
                    Button {
                        if loginData.registerUser{
                            if loginData.email != ""{
                                
                                if loginData.password != "" {
                                
                                    if loginData.password == loginData.re_Enter_Password{
                                        
                                        Auth.auth().createUser(withEmail: loginData.email, password: loginData.password) { (res, err) in
                                            
                                            if err != nil{
                                            
                                                return
                                            }
                                            
                                            print("success")
                                            loginData.Register()
                                            UserDefaults.standard.set(true, forKey: "status")
                                            NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                                        }
                                    }
                                    else{
                                        self.error = "Password mismatch!"
                                        self.alertForError.toggle()
                                    }
                                        
                                    }
                                    else {
                                        self.error = "Please enter password!"
                                        self.alertForError.toggle()
                                    }
                            }
                            else{
                                print("toggle \(alert)")
                                self.error = "Please enter valid email!"
                                self.alertForError.toggle()
                            }
                            
                        }
                        else{
                            if loginData.email != "" && loginData.password != ""{
                                
                                Auth.auth().signIn(withEmail: loginData.email, password: loginData.password) { (res, err) in
                                    
                                    if err != nil{
                                        
                                        self.error = err!.localizedDescription
                                        self.alertForError.toggle()
                                        return
                                    }
                                    
                                    loginData.Login()
                                    print("success")
                                    UserDefaults.standard.set(true, forKey: "status")
                                    NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                                }
                            }
                            else{
                                
                                self.error = "Please fill all the fields properly"
                                self.alertForError
                                    .toggle()
                            }
                        }
                    } label: {
                        
                        Text("Login")
                            .font(.custom(customFont, size: 17).bold())
                            .padding(.vertical,20)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color("Purple"))
                            .cornerRadius(15)
                            .shadow(color: Color.black.opacity(0.07), radius: 5, x: 5, y: 5)
                    }
                    .padding(.top,25)
                    .padding(.horizontal)
                    
                    // Register create account button
                    
                    Button {
                        withAnimation{
                            loginData.registerUser.toggle()
                        }
                    } label: {
                        
                        Text(loginData.registerUser ? "Back to login" : "Create account")
                            .font(.custom(customFont, size: 14))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Purple"))
                    }
                    .padding(.top,8)
                }
                .padding(30)
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(
                Color.white
                    .clipShape(CustomCorners(corners: [.topLeft,.topRight], radius: 25))
                    .ignoresSafeArea()
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Purple"))
        
        // Clear the text field
        .onChange(of: loginData.registerUser) { newValue in
            
            loginData.email = ""
            loginData.password = ""
            loginData.re_Enter_Password = ""
            loginData.showPassword = false
            loginData.showReEnterPassword = false
        }
        if self.alertForError{
            
            ErrorView(alert: self.$alertForError, error: self.$error)
        }
    }
    
    
    @ViewBuilder
    func CustomTextField(icon: String,title: String,hint: String,value: Binding<String>,showPassword: Binding<Bool>)->some View{
        
        VStack(alignment: .leading, spacing: 12) {
            
            Label {
                Text(title)
                    .font(.custom(customFont, size: 14))
            } icon: {
                Image(systemName: icon)
            }
            .foregroundColor(Color.black.opacity(0.8))
            
            if title.contains("Password") && !showPassword.wrappedValue{
                SecureField(hint, text: value)
                    .padding(.top,2)
            }
            else{
                TextField(hint, text: value)
                    .padding(.top,2)
            }
            
            Divider()
                .background(Color.black.opacity(0.4))
        }
        // Show Button for password
        .overlay(
        
            Group{
                
                if title.contains("Password"){
                    Button(action: {
                        showPassword.wrappedValue.toggle()
                    }, label: {
                        Text(showPassword.wrappedValue ? "Hide" : "Show")
                            .font(.custom(customFont, size: 13).bold())
                            .foregroundColor(Color("Purple"))
                    })
                    .offset(y: 8)
                }
            }
            
            ,alignment: .trailing
        )
    }
}


struct TVShow: Identifiable {
    var id: String { name }
    let name: String
}

struct ErrorView : View {
    
    @State var color = Color.black.opacity(0.7)
    @Binding var alert : Bool
    @Binding var error : String
    
    var body: some View{
        
        GeometryReader{_ in
            
            VStack{
                
                HStack{
                    
                    Text(self.error == "RESET" ? "Message" : "Error")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(self.color)
                    
                    Spacer()
                }
                .padding(.horizontal, 25)
                
                Text(self.error == "RESET" ? "Password reset link has been sent successfully" : self.error)
                .foregroundColor(self.color)
                .padding(.top)
                .padding(.horizontal, 25)
                
                Button(action: {
                    
                    self.alert.toggle()
                    
                }) {
                    
                    Text(self.error == "RESET" ? "Ok" : "Cancel")
                        .foregroundColor(.black)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 120)
                }
                .background(Color("Purple"))
                .cornerRadius(10)
                .padding(.top, 25)
            }
            .padding(.vertical, 25)
            .frame(width: UIScreen.main.bounds.width - 70)
            .background(Color.white)
            .cornerRadius(15)
        }
        .background(Color.black.opacity(0.35).edgesIgnoringSafeArea(.all))
    }
}


struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
