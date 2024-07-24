//
//  NewAccountView.swift
//  userAuth
//
//  Created by Caleb Nartey on 7/23/24.
//

import SwiftUI
import FirebaseAuth


struct NewAccountView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack{
            //--------------
            // location 1
            Text("New Account")
                .font(.largeTitle)
            
            Spacer()
            
            //--------------
            // Email Field
            //--------------
            // location 2
            HStack{
                
                Image(systemName: "mail")
                    .foregroundColor(.gray)
                TextField("Email", text:$email)
                    .foregroundColor(.gray)
                    .font(.title)
                    .fontWeight(.bold)
                
                if(email.count != 0){
                    Image(systemName: email.isValidEmail() ? "checkmark" : "xmark")
                        .frame(width: 30)
                        .fontWeight(.bold)
                        .foregroundColor(email.isValidEmail() ? .green : .red)
                }

            }.padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.black)
                    
                ).padding()
            
            //--------------
            // Password Field
            //--------------
            // location 3
            
            HStack{
                
                Image(systemName: "lock")
                    .foregroundColor(.gray)
                TextField("Password", text:$password)
                    .foregroundColor(.gray)
                    .font(.title)
                    .fontWeight(.bold)
   
            }.padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.black)
                    
                ).padding()
            
            //--------------
            // Cancel Create Account Button
            //--------------
            // location 4
            
            HStack{
                
                Spacer()
                
                Button(action: {
                    
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                        .foregroundColor(.gray)
                        .font(.title)
                }
                
                Spacer()
                //-------------
                
                Button(action: {
                    Auth.auth().createUser(withEmail: email, password: password){
                        authResult, error in
                        
                        if let error = error{
                            print(error)
                            
                            return
                        }
                        
                        if let authResult = authResult{
                            print("\(authResult.user.uid)")
                        }
                    }
                    
                    presentationMode.wrappedValue.dismiss()
                }){
                    Text("Create Account")
                        .foregroundColor(.gray)
                        .font(.title)
                }
                
                Spacer()
                
            }// end HStack
            
            //--------------
            // location 5
            
            Spacer()
        }// end VStack
    }// end body
}// end view

#Preview {
    NewAccountView()
}

