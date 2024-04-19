//
//  Home.swift
//  e-clothing-app
//
//  Created by Yesh Adithya on 2024-03-28.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI

struct Home: View {
    var animation: Namespace.ID
    @EnvironmentObject var sharedData: SharedDataModel
    @StateObject var homeVM = HomeViewModel()
    @State private var selectedCategory: String = "All" // Initially "All"
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(spacing: 15, content: {
                ZStack{
                    if homeVM.searchActivated {
                        SearchBar()
                    }else {
                        SearchBar()
                            .matchedGeometryEffect(id: "SEARCH", in: animation)
                    }
                }
                .frame(width: getRect().width / 1.2 )
                .padding(.horizontal)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        homeVM.searchActivated = true
                    }
                }
                
                Text("Let's Find your \nExclusive Outfit")
                    .font(.custom(Extensions.customFB, size: 28))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                    .padding(.horizontal, 25)
                Text("Top Categories")
                    .font(.custom(Extensions.customFB, size: 18))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 25)
                    .padding(.bottom,5)
                // Top Category List
                ScrollView(.horizontal, showsIndicators: false){
                    if !homeVM.uniqueCategories.isEmpty {
                        HStack(spacing: 18, content: {
                            // Product Categories
                            ForEach(homeVM.uniqueCategories.sorted(), id:  \.self){category in
                                Button {
                                    withAnimation {
                                        selectedCategory = category
                                        homeVM.filterByCategory(category: selectedCategory)
                                    }
                                } label: {
                                    Text(category.capitalized)
                                        .font(.custom(Extensions.customFSB, size: 15))
                                        .fontWeight(.semibold)
                                        .foregroundColor(selectedCategory == category ? Color("WhiteBG") : Color("FBlack"))
                                        .padding(.vertical, 10)
                                        
                                }    
                                .padding(.horizontal, 15)
                                .background(
                                    Capsule()
                                        .foregroundColor(selectedCategory == category ? Color("FGreen") : Color("WhiteBG"))
                                )

                            }
                            
                        })
                        .padding(.horizontal,25)
                    } else {
                        ProgressView()
                            .padding(.leading, 25)
                        // Show loading indicator while data is being fetched
                        }
                    }.padding(.top,5)
                
                HStack(spacing: 25, content: {
                    Text("Popular Products")
                        .font(.custom(Extensions.customFB, size: 18))
                        .frame(width: getRect().width / 2, alignment: .leading)
                        .padding(.horizontal, 25)
                    
                    Button(action: {
                        homeVM.showMoreProductOnCategory.toggle()
                    }, label: {
                        Text("View All")
                            .font(.custom(Extensions.customFR, size: 14))
                            .foregroundColor(Color("FGreen"))
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.horizontal, 25)
                    })
                    

                })
                .padding(.top,15)
                

                //Product Page
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing: 25, content: {
                        if !homeVM.products.isEmpty {
                            ForEach(homeVM.filterProducts){product in
                                ProductCardView(product: product)
                            }
                        } else {
                            ProgressView()
                                .frame(maxWidth: .infinity, alignment: .center)
                            // Show loading indicator while data is being fetched
                            }
                    })
                    .padding(.horizontal,25)
                }
                .padding(.top, 10)
            })
            .padding(.vertical)

            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("BG"))
        .onAppear {
            homeVM.fetchData()
        }
        .sheet(isPresented: $homeVM.showMoreProductOnCategory) {
            MoreProductView()
        }
        .overlay {
            ZStack{
                if homeVM.searchActivated{
                    SearchView(animation: animation)
                        .environmentObject(homeVM)
                }
            }
        }
    }
    
    @ViewBuilder
    func SearchBar()-> some View {
        HStack(spacing: 15, content: {
            Image(systemName: "magnifyingglass")
                .font(.title2)
                .foregroundColor(.gray)
            TextField("Search", text: .constant(""))
                .disabled(true)
        })
        .padding(.vertical, 12)
        .padding(.horizontal)
        .background(
            Capsule()
                .stroke(Color.black.opacity(0.5), lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
        )
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
                        .matchedGeometryEffect(id: "\(product.id)IMAGE", in: animation)
                }
            }
            .frame(width: getRect().width / 5, height: getRect().height / 5) // Set desired frame size
            Text(product.title)
                .font(.custom(Extensions.customFSB, size: 18))
                .frame(maxWidth: getRect().width / 3, alignment: .leading)
                .multilineTextAlignment(.center) // Adjust alignment as needed
                .lineLimit(4) // Allow unlimited lines
            
            Text(product.category.capitalized)
                .font(.custom(Extensions.customFR, size: 14))
                .frame(maxWidth: getRect().width / 3, alignment: .leading)
                .foregroundColor(.gray)
            
            Text("Rs. "+String(format: "%.2f", product.price))
                .font(.custom(Extensions.customFB, size: 16))
                .frame(maxWidth: getRect().width / 3, alignment: .leading)
                .foregroundColor(Color("FGreen"))
        })
        .padding(.horizontal, 20)
        .padding(.bottom, 22)
        .background(
            Color.white.cornerRadius(25)
        )
        .onTapGesture {
            withAnimation(.easeInOut) {
                sharedData.detailProduct = product
                sharedData.showDetails = true
            }
        }
    }
}

#Preview {
     HomePage()
}
