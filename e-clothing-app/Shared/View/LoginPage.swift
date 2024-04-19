//
//  LoginPage.swift
//  e-clothing-app
//
//  Created by Ovini on 2024-03-18.
//

import SwiftUI
import AlertToast

struct LoginPage: View {
    @StateObject var loginData: LoginPageViewModel = LoginPageViewModel()
    
    var body: some View {
        VStack{
            VStack{
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
                Text(loginData.registerUser ? "Create new Account" : "Welcome Back")
                    .font(.custom(Extensions.customFB, size: 35))
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .frame(height: getRect().height/4)
            .background(
                ZStack{
                    LinearGradient(colors: [Color("FGreen"),Color("FGreen").opacity(0.8),Color("BG")], startPoint: .top, endPoint: .bottom)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity, alignment: .topTrailing)
                        .padding(.trailing)
                        .offset(y: -25)
                        .ignoresSafeArea()
                    
                    Circle()
                        .strokeBorder(Color.black.opacity(0.3), lineWidth: 3)
                        .frame(width: 50, height: 50)
                        .blur(radius: 2)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity, alignment: .bottomTrailing)
                        .padding(20)
                    
                    Circle()
                        .strokeBorder(Color.black.opacity(0.3), lineWidth: 3)
                        .frame(width: 25, height: 30)
                        .blur(radius: 2)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity, alignment: .topLeading)
                        .padding(.leading,30)
                }
            )
            
            ScrollView(.vertical,  showsIndicators: false) {
                VStack(spacing: 15, content: {
                    Text(loginData.registerUser ? "Looks like you don't have an account" : "Log in to your account using email \nor social networks")
                        .font(.custom(Extensions.customFSB, size: 18))
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundColor(Color("FGreen"))
                    
                    // Custom Text Field
                    // Email Field
                    CustomTextField(icon: "envelope.fill", title: "Email", hint: "user@gmail.com", value: $loginData.email, showPassword: $loginData.showPasword)
                        .padding(.top, 30)
                    // Password Field
                    CustomTextField(icon: "lock.fill", title: "Password", hint: "123456", value: $loginData.password, showPassword: $loginData.showPasword)
                        .padding(.top, 10)
                    // IF user click register User Show Confirm Password
                    if loginData.registerUser {
                        CustomTextField(icon: "lock.fill", title: "Confirm Password", hint: "123456", value: $loginData.re_Enter_password, showPassword: $loginData.showReEnterPasword)
                            .padding(.top, 10)
                    }
                    // Forget Password
                    Button(action: {}, label: {
                        Text("Forget Password?")
                            .font(.custom(Extensions.customFSB, size: 14))
                            .foregroundColor(Color("FGreen"))
                    })
                    .padding(.top, 8)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    //Login Button
                    Button(action: {
                        loginData.verify()
                    }, label: {
                        Text(loginData.registerUser ? "Register" : "Login")
                            .font(.custom(Extensions.customFSB, size: 14))
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(Color("WhiteBG"))
                            .background(Color("FGreen"))
                            .cornerRadius(15)
                            .shadow(color: Color.black.opacity(0.07), radius: 5, x: 5, y: 5)
                    })
                    .padding(.top, 25)
                    .padding(.horizontal)

                    //Register Button
                    // Forget Password
                    Button(action: {
                        withAnimation{
                            loginData.registerUser.toggle()
                        }
                    }, label: {
                        Text(loginData.registerUser ? "Back to Login" : "Create account")
                            .font(.custom(Extensions.customFSB, size: 14))
                            .foregroundColor(Color("FGreen"))
                    })
                    .padding(.top, 8)
                    
                })
                .padding(30)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color("WhiteBG")
                .clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 25))
                .ignoresSafeArea()
            )
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("BG"))
        .onChange(of: loginData.registerUser){
            loginData.email = ""
            loginData.password = ""
            loginData.re_Enter_password = ""
            loginData.showPasword = false
            loginData.showReEnterPasword = false
        }
        .toast(isPresenting: $loginData.showToast) {
            // Customize your toast message here
            AlertToast(type: .regular, title: loginData.showErrorMessage)
        }
    }
    
    // Text Field View Builder
    
    @ViewBuilder
    func CustomTextField(icon: String, title: String, hint: String, value: Binding<String>, showPassword: Binding<Bool>)-> some View {
        VStack(alignment: .leading, spacing: 12) {
            Label{
                Text(title)
                    .font(.custom(Extensions.customFR, size: 14))
            } icon: {
                Image(systemName: icon)
                    .foregroundColor(Color("FGreen"))
            }
            .foregroundColor(Color("GrayBG"))
            
            if title.contains("Password") && !showPassword.wrappedValue{
                SecureField(hint, text: value)
                    .padding(.top, 2)
            }else{
                TextField(hint, text: value)
                    .padding(.top, 2)
            }
             
            Divider()
                .background(Color.black.opacity(0.4))
        }
        // Showing Button for Password Fields
        .overlay(
            Group{
                if title.contains("Password"){
                    Button(action: {
                        showPassword.wrappedValue.toggle()
                    }, label: {
                        Image(systemName: showPassword.wrappedValue ? "eye.fill": "eye.slash.fill")
                            .foregroundColor(Color("FGreen"))
                    })
                    .offset(y: 8)
                }
            }
            , alignment: .trailing
        )
    }
}

#Preview {
    LoginPage()
}
