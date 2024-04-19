//
//  HomePage.swift
//  e-clothing-app
//
//  Created by Yesh Adithya on 2024-03-18.
//

import SwiftUI

struct HomePage: View {
    @ObservedObject var homeVM = HomeViewModel()
    @State var currentTab: Tab = .Home
    @StateObject var sharedData: SharedDataModel = SharedDataModel()
    @Namespace var animation
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        VStack{
            TabView(selection: $currentTab,
                    content:  {
                Home(animation: animation).tag(Tab.Home).environmentObject(sharedData)
                LikedPage().tag(Tab.Liked).environmentObject(sharedData)
                Profile().tag(Tab.Profile)
                CartPage().tag(Tab.Cart).environmentObject(sharedData)
            })
            .navigationBarBackButtonHidden(true)
            // Custom Tab Bar
            HStack(spacing: 0) {
                ForEach(Tab.allCases, id: \.self) { tab in
                    Button(action: {
                        // Implement action for the button here
                        currentTab = tab
                    }) {
                        Image(tab.rawValue)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                            .background(
                                Color("FGreen")
                                    .opacity(0.2)
                                    .cornerRadius(15)
                                    .blur(radius: 5)
                                    .padding(-7)
                                    .opacity(currentTab == tab ? 1 : 0)
                            )
                            .frame(maxWidth: .infinity)
                            .foregroundColor(currentTab == tab ? Color("FGreen"): Color.black.opacity(0.2))
                    }
                    
                }
            }
            .padding([.horizontal,.bottom])

        }
        .background(Color("BG").ignoresSafeArea())
        .overlay {
            ZStack{
                if let product = sharedData.detailProduct,sharedData.showDetails{
                    ProductDetailView(animation: animation, product: product)
                        .environmentObject(sharedData)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
                }
            }
        }
    }
}

#Preview {
    HomePage()
}


enum Tab: String, CaseIterable {
    case Home = "Home"
    case Cart = "Cart"
    case Liked = "Liked"
    case Profile = "Profile"
}
