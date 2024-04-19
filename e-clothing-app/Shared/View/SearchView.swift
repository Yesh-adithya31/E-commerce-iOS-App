//
//  SearchView.swift
//  e-clothing-app
//
//  Created by Ovini on 2024-03-29.
//

import SwiftUI
import SDWebImageSwiftUI

struct SearchView: View {
    var animation: Namespace.ID
    @EnvironmentObject var homeVM: HomeViewModel
    @FocusState var startTF: Bool
    
    @EnvironmentObject var sharedData: SharedDataModel
    
    var body: some View {
        VStack(spacing: 0){
            HStack(spacing: 20){
                Button(action: {
                    withAnimation {
                        homeVM.searchActivated = false
                    }
                    homeVM.searchText = ""
                    sharedData.showSearchPage = false
                }, label: {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(Color.black.opacity(0.7))
                })
                
                HStack(spacing: 15, content: {
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.gray)
                    TextField("Search", text: $homeVM.searchText)
                        .focused($startTF)
                        .textCase(.lowercase)
                        .disableAutocorrection(true)
                })
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background(
                    Capsule()
                        .stroke(Color("FGreen"), lineWidth: 1.5)
                )
                .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                .padding(.top)
            }
            .padding([.horizontal])
        
            if let products = homeVM.searchProducts {
                if products.isEmpty {
                    VStack(spacing: 0){
                        Image("nofound")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.top, 60)
                        
                        Text("Item not found")
                            .font(.custom(Extensions.customFB, size: 22))
                    }
                    .padding()
                } else {
                    ScrollView(.vertical, showsIndicators: false){
                        VStack(spacing: 0){
                            Text("Found \(products.count) result")
                                .font(.custom(Extensions.customFB, size: 24))
                                .padding(.vertical)
                            
                            StaggeredGrid(column: 2, list:  products) { product in
                                ProductCardView(product: product)
                            }
                        }

                    }.padding(.horizontal)
                        .padding(.top)
                }
            }else {
                ProgressView()
                    .padding(.top, 30)
                    .opacity(homeVM.searchText == "" ? 0 : 1)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(
            Color("BG")
                .ignoresSafeArea()
        )
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                startTF = true
            }
        }
        
    }
    
    @ViewBuilder
    func ProductCardView(product: Product)-> some View{
        VStack(spacing: 10, content: {
            ZStack{
                if sharedData.showDetails{
                    WebImage(url: URL(string: product.image))
                        .resizable()
                        .indicator(.activity) // Activity indicator while loading
                        .scaledToFit() // Scale the image to fit the frame
                        .opacity(0)
                }else {
                    WebImage(url: URL(string: product.image))
                        .resizable()
                        .indicator(.activity) // Activity indicator while loading
                        .scaledToFit() // Scale the image to fit the frame
                        .matchedGeometryEffect(id: "\(product.id)SEARCH", in: animation)
                }
            }
                .frame(width: getRect().width / 3, height: getRect().height / 4) // Set desired frame size
            Text(product.title)
                .font(.custom(Extensions.customFSB, size: 18))
                .frame(maxWidth: getRect().width / 3, alignment: .center)
                .multilineTextAlignment(.center) // Adjust alignment as needed
                .lineLimit(4) // Allow unlimited lines
            
            Text(product.category.capitalized)
                .font(.custom(Extensions.customFR, size: 14))
                .frame(maxWidth: getRect().width / 3, alignment: .center)
                .foregroundColor(.gray)
            
            Text("Rs. "+String(format: "%.2f", product.price))
                .font(.custom(Extensions.customFB, size: 16))
                .frame(maxWidth: getRect().width / 3, alignment: .center)
                .foregroundColor(Color("FGreen"))
        })
        .padding(.horizontal, 20)
        .padding(.bottom, 22)
        .background(
            Color.white.cornerRadius(25)
        )
        .onTapGesture {
            withAnimation(.easeInOut) {
                sharedData.showSearchPage = true
                sharedData.detailProduct = product
                sharedData.showDetails = true
            }
        } 
    }
}

#Preview {
    HomePage()
}
