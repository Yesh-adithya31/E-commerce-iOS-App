//
//  OnBoardingPage.swift
//  e-clothing-app
//
//  Created by Ovini on 2024-03-18.
//

import SwiftUI



struct OnBoardingPage: View {
    @State var showLoginPage : Bool = false
    var body: some View {
        VStack{
            Image("onboardBG")
                .resizable()
                .aspectRatio(contentMode: .fit)
            VStack{
                Text("Find the best \nfashion style for you")
                    .font(.custom(Extensions.customFR, size: 33))
                    .fontWeight(.bold)
                    .foregroundColor(Color("FBlack"))
                    .multilineTextAlignment(.center)
                    .padding([.top, .leading, .trailing],10)
                Text("Get exclusive limited apparel that only you have! Made by famous brands.")
                    .font(.custom(Extensions.customFR, size: 18))
                    .foregroundColor(Color("FSubtitle"))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Button(action: {
                    showLoginPage = true
                }, label: {
                    Text("Get Started")
                        .font(.custom(Extensions.customFSB, size: 18))
                        .padding(.vertical, 18)
                        .frame(maxWidth: .infinity)
                        .background(Color("FGreen"))
                        .cornerRadius(/*@START_MENU_TOKEN@*/15.0/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color("WhiteBG"))
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                        .padding(.horizontal, 30)
                
                })
                
                
            }
            .padding(.vertical, 30.0)
            .background(Color("WhiteBG"))
            .cornerRadius(15)
            .offset(y: getRect().height < 750 ? 20 : 40)
            


        }
        .padding(.top, getRect().height < 750 ? 0 : 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color("BG")
        )
        .overlay {
            Group{
                if showLoginPage{
                    LoginPage()
                        .transition(.move(edge: .bottom))
                }
            }
        }
    }
}

#Preview {
    OnBoardingPage()
}


extension View {
    func getRect()-> CGRect {
        return UIScreen.main.bounds
    }
}
