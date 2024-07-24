//
//  LoginView.swift
//  userAuth
//
//  Created by Caleb Nartey on 7/23/24.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @State private var isCreateAccountViewPresented = false
    @State private var isPasswordCorrect: Bool = false
    @State private var showErrorAlert: Bool = false
    
    @State private var email: String = ""
    @State private var password: String = ""

    
    var body: some View {
        
        NavigationStack{
            //----------------
            ZStack{
                
                VStack{
                    // location 2
                    Text("Login")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                    
                    Spacer()
                    Spacer()
                    
                    //--------------
                    // Email Field
                    //--------------
                    // location 3
                    HStack{
                        
                        Image(systemName: "mail")
                            .foregroundColor(.white)
                        TextField("Email", text:$email)
                            .foregroundColor(.white)
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
                                .foregroundColor(.white)
                        
                        ).padding()
                        
                    
                    //--------------
                    // Password Field
                    //--------------
                    // location 4
                    HStack{
                        
                        Image(systemName: "lock")
                            .foregroundColor(.white)
                        TextField("Password", text:$password)
                            .foregroundColor(.white)
                            .font(.title)
                            .fontWeight(.bold)
                        
                    }.padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 2)
                                .foregroundColor(.white)
                        ).padding()
                    
                    //--------------
                    // New Account Button
                    //--------------
                    // location 5
                    Button(action: {
                        isCreateAccountViewPresented.toggle()
                    }) {
                        Text("Create Account")
                    }.foregroundColor(.white)
                        .font(.title)
                        .sheet(isPresented: $isCreateAccountViewPresented){
                            NewAccountView()
                        }

                    //--------------
                    // Spacers
                    //--------------
                    // location 6
                    Spacer()
                    Spacer()
                    
                    //--------------
                    // Login Button
                    //--------------
                    // location 7
                    Button( action: {
                        
                        Auth.auth().signIn(withEmail: email, password: password){ authResult, error in
                            
                            if let error = error{
                                print(error)
                                email = ""
                                password = ""
                                showErrorAlert.toggle()
                            }
                            
                            if let authResult = authResult{
                                isPasswordCorrect = true
                            }
                            
                        }// end sign In
                        
                        isPasswordCorrect = true
                        
                    }){
                        Text("Login")
                            .foregroundColor(.white)
                            .font(.title)
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(Color.black)
                                    .foregroundColor(.black)
                                    .opacity(0.5)
                            ).padding(.horizontal)
                            .alert(isPresented: $showErrorAlert, content:{
                                Alert(title: Text("Error login please  check email and password"))
                            })
                    }
                    .padding()
                    .padding(.top)
                    
                    }//end VStack
                    //---------------
                    // location 8
                
    
            }//end VStack
            //-----------
            // location 9
            NavigationLink(destination: InsideAppView(), isActive: $isPasswordCorrect){
                EmptyView()
            }
            
        }//end Navigation Stack
        // location 10
        
        
        
        
    }//end body
}//end LoginView

struct LoginView_Previews: PreviewProvider{
    static var previews: some View{
        LoginView()
    }
}
