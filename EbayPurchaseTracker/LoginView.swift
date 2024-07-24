//
//  LoginView.swift
//  EbayPurchaseTracker
//
//  Created by samira masri on 7/21/24.
//

import SwiftUI
 
struct LoginView: View {
    @State private var user: String = ""
    @State private var password: String = ""
    @State private var isCreateAccountViewPresented = false
    @State private var isPasswordCorrect: Bool = false
    @State private var showErrorAlert: Bool = false
    @State private var isLoggedIn: Bool = false
 
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    // Username field
                    TextField("Username", text: $user)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)
                        .padding(.horizontal, 25)
                        .autocapitalization(.none)
 
                    // Password field
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)
                        .padding(.horizontal, 25)
 
                    // New account button
                    Button(action: {
                        self.isCreateAccountViewPresented = true
                    }) {
                        Text("Create Account")
                            .foregroundColor(.blue)
                    }
                    .padding()
                    .sheet(isPresented: $isCreateAccountViewPresented) {
                        CreateAccountView()
                    }
 
                    Spacer()
 
                    // Login button
                    Button(action: {
                        // Handle login action
                        self.isLoggedIn = true
                    }) {
                        Text("Login")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .padding(.horizontal, 25)
                    }
 
                }
                .padding()
 
                // Navigation to InsideAppView upon successful login
                NavigationLink(destination: InsideAppView(), isActive: $isLoggedIn) {
                    EmptyView()
                }
            }
            .alert(isPresented: $showErrorAlert) {
                Alert(title: Text("Error"), message: Text("Login failed. Please check your credentials and try again."), dismissButton: .default(Text("OK")))
            }
        }
    }
}
 
struct CreateAccountView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @Environment(\.presentationMode) var presentationMode
 
    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
                .padding(.horizontal, 25)
                .autocapitalization(.none)
 
            SecureField("Password", text: $password)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
                .padding(.horizontal, 25)
 
            Button(action: {
                // Handle account creation
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Create Account")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal, 25)
            }
            .padding()
        }
        .padding()
    }
}
 
#Preview {
    LoginView()
}
 
