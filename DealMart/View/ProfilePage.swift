//
//  ContentView.swift
//  DealMart
//
//  Created by user215540 on 4/5/22.
//

import SwiftUI
import Firebase
import FirebaseStorage

struct ProfilePage: View {
    
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    @StateObject var loginData: LoginPageModel = LoginPageModel()
    @State var shown = false
    @State var shouldShowImagePicker = false
    @State var image: UIImage?
    
    var body: some View {
        
        NavigationView{
            
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack{
                    
                    Text("My Profile")
                        .font(.custom(customFont, size: 28).bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(spacing: 15){
                        
                        Image("profile-man")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                            .offset(y: -30)
                            .padding(.bottom,-30)
                        
                        Button(action: {
                            self.shown.toggle()
                        }) {
                            
                            Text("Change Image")
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 250)
                        }
                        .background(Color("Purple"))
                        .cornerRadius(10)
                        .padding(.top, 1)
                        .sheet(isPresented: $shown) {
                            imagePicker1(shown: self.$shown)
                        }
                        
                        Text("Mit Patel")
                            .font(.custom(customFont, size: 16))
                            .fontWeight(.semibold)
                        
                        HStack(alignment: .top, spacing: 10) {
                            
                            Image(systemName: "location.north.circle.fill")
                                .foregroundColor(.blue)
                                .rotationEffect(.init(degrees: 180))
                            
                            Text("Address: 21 Founttainhead Road\nM1A 1W5\nNotrh York, Ontario")
                                .font(.custom(customFont, size: 15))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding([.horizontal,.bottom])
                    .background(
                    
                        Color.white
                            .cornerRadius(12)
                    )
                    .padding()
                    .padding(.top,40)
                    
                    
                    
                    // Navigation Links
                    
                    CustomNavigationLink(title: "Edit Profile") {
                        
                        Text("")
                            .navigationTitle("Edit Profile")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("HomeBG").ignoresSafeArea())
                    }
                    
                    
                    CustomNavigationLink(title: "Shopping address") {
                        
                        Text("")
                            .navigationTitle("Shopping address")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("HomeBG").ignoresSafeArea())
                    }
                    
                    CustomNavigationLink(title: "Order history") {
                        
                        Text("")
                            .navigationTitle("Order history")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("HomeBG").ignoresSafeArea())
                    }
                    
                    CustomNavigationLink(title: "Cards") {
                        
                        Text("")
                            .navigationTitle("Cards")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("HomeBG").ignoresSafeArea())
                    }
                    
                    CustomNavigationLink(title: "Settings") {
                       // NavigationLink(destination: SettingList())
                        var settingItem: [Setting] = [
                            Setting(id: 1, name: "Language"),
                            Setting(id: 2, name: "Notifications"),
                            Setting(id: 3, name: "Help"),
                            Setting(id: 4, name: "Rate Us")
                        ]
                        NavigationView{
                            List(settingItem){
                                setting in ListRow(eachSettingItem: setting)
                            }.navigationBarTitle(Text("Settings"))
                        }
                    
                    }
                }
                .padding(.horizontal,22)
                .padding(.vertical,20)
                
                Button(action: {
                    
                    try! Auth.auth().signOut()
                    UserDefaults.standard.set(false, forKey: "status")
                    NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                    loginData.Logout()
                    
                }) {
                    
                    Text("Log out")
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 50)
                }
                .background(Color("Purple"))
                .cornerRadius(10)
                .padding(.top, 0)
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
            
                Color("HomeBG")
                    .ignoresSafeArea()
            )
            
        }
    }
    
    @ViewBuilder
    func CustomNavigationLink<Detail: View>(title: String,@ViewBuilder content: @escaping ()->Detail)->some View{
        
        
        NavigationLink {
            content()
        } label: {
            
            HStack{
                
                Text(title)
                    .font(.custom(customFont, size: 17))
                    .fontWeight(.semibold)
                
                Spacer()
                
                Image(systemName: "chevron.right")
            }
            .foregroundColor(.black)
            .padding()
            .background(
            
                Color.white
                    .cornerRadius(12)
            )
            .padding(.horizontal)
            .padding(.top,10)
        }
    }
}

struct ListRow: View{
    var eachSettingItem: Setting
    var body: some View{
        HStack{
            Text(eachSettingItem.name)
            
            Spacer()
            Image(systemName: "chevron.right")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.black)
                .frame(width: 60, height: 60)
                .background(Color.white)
                .clipShape(Circle())
        }
    }
}

struct imagePicker1: UIViewControllerRepresentable {
    
    func makeCoordinator() -> Coordinator {
        return imagePicker1.Coordinator(parent1: self)
    }
    
    @Binding var shown: Bool

    func makeUIViewController(context: UIViewControllerRepresentableContext<imagePicker1>) ->
        UIImagePickerController {
            let imagepic = UIImagePickerController()
            imagepic.sourceType = .photoLibrary
            imagepic.delegate = context.coordinator
            return imagepic
        }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<imagePicker1>) {
        
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var parent: imagePicker1!
        
        init(parent1: imagePicker1) {
            parent = parent1
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.shown.toggle()
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let image = info[.originalImage] as! UIImage
            let storage = Storage.storage()
            storage.reference().child("temp").putData(image.jpegData(compressionQuality: 0.35)!, metadata: nil) {
                (_, err) in
                
                if err != nil {
                    print((err?.localizedDescription)!)
                    return
                }
                print("Successfully Uploaded")
            }
            parent.shown.toggle()
        }
    }
}


struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
    }
}
