//
//  LoginView.swift
//  EbayPurchaseTracker
//
//  Created by samira masri on 7/21/24.
//

import SwiftUI

struct LoginView: View {
    
    @State private var isCreateAccountViewPresented = false
    @State private var isPasswordCorrect: Bool = false
    @State private var showErrorAlert: Bool = false
    
    
    @State private var user: String = ""
    @State private var password: String = ""
    
    
    
    
    var body: some View {
        
        
        NavigationStack{
            ZStack{
                //location 1
                
                //--------------------------
                
                VStack{
                    //location 2
                    
                    //----------------------------
                    //username field
                    //----------------------------
                    //location 3
                    
                    
                    //----------------------------
                    //password field
                    //---------------------------
                    //location 4
                    
                    
                    //----------------------------
                    //new account button
                    //-------------------------
                    //location 5
                    
                    
                    //-------------------------
                    //spacers
                    //-----------------------
                    //location 6
                    
                    
                    //---------------------
                    //login button
                    //--------------------
                    //location 7
                    
                }// end VStack
                //------------------------
                //location 8
            }// end ZStack
            
            
        }
        
        
        
        
        
    }
}

#Preview {
    LoginView()
}
