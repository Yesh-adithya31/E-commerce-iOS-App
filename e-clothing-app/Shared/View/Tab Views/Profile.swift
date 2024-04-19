//
//  Profile.swift
//  e-clothing-app
//
//  Created by Yesh Adithya on 2024-03-29.
//

import SwiftUI

struct Profile: View {
    @StateObject var loginData: LoginPageViewModel = LoginPageViewModel()
    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false) {
                VStack{
                    Text("My Profile")
                        .font(.custom(Extensions.customFB, size: 28))
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                    
                    VStack(spacing: 15){
                        Image("Profile")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                            
                        Text((loginData.defaults.string(forKey: "userEmail") ?? ""))
                            .font(.custom(Extensions.customFSB, size: 16))
                        
                        HStack(alignment: .top ,spacing: 10){
                            Image(systemName: "envelope")
                                .foregroundColor(.gray)
                            
                            Text((loginData.defaults.string(forKey: "userEmail") ?? ""))
                                .font(.custom(Extensions.customFSB, size: 16))
                                .foregroundColor(Color("FGreen"))
                        }
                        .frame(maxWidth: .infinity)

                    }
                    .frame(maxWidth: .infinity)
                    .padding([.horizontal, .bottom])
                    .background(
                        Color.white.cornerRadius(12)
                    )
                    .padding()
                    .padding(.top, 40)
                    
                    CustomNavigationLink(title: "Edit Profile") {
                        Text("")
                            .navigationTitle("Edit Profile")
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
                            .background(
                                Color("BG").ignoresSafeArea()
                            )
                        
                    }
                    
                    CustomNavigationLink(title: "Order History") {
                        Text("")
                            .navigationTitle("Order History  ")
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
                            .background(
                                Color("BG").ignoresSafeArea()
                            )
                        
                    }
                    
                    Button {
                        LoginPageViewModel().logout()
                    } label: {
                        HStack{
                            Text("Logout")
                                .font(.custom(Extensions.customFSB, size: 17))
                                .foregroundColor(.red)
                            Spacer()
                        }
                        .foregroundColor(.black)
                        .padding()
                        .background(
                            Color.white.cornerRadius(12)
                        )
                        .padding(.horizontal)
                        .padding(.top, 10)
                    }

                    

                }
                .padding(.horizontal, 22)
                .padding(.vertical, 20)
            }
            .navigationBarHidden(true)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
            .background(
                Color("BG")
                    .ignoresSafeArea()
            )
        }
    }
    
    @ViewBuilder
    func CustomNavigationLink<Detail: View>(title: String, @ViewBuilder content : @escaping ()-> Detail)-> some View {
        NavigationLink {
            content()
        } label : {
            HStack{
                Text(title)
                    .font(.custom(Extensions.customFSB, size: 17))
                Spacer()
                Image(systemName: "chevron.right")
            }
            .foregroundColor(.black)
            .padding()
            .background(
                Color.white.cornerRadius(12)
            )
            .padding(.horizontal)
            .padding(.top, 10)
        }
    }
}

#Preview {
    Profile()
}
