//
//  LikedPage.swift
//  e-clothing-app
//
//  Created by Yesh Adithya on 2024-03-30.
//

import SwiftUI
import SDWebImageSwiftUI

struct LikedPage: View {
    @EnvironmentObject var sharedData: SharedDataModel
    @State var showDeleteOption: Bool = false
    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false){
                VStack{
                    HStack{
                        Text("Favourites")
                            .font(.custom(Extensions.customFB, size: 28))
                        Spacer()
                        Button{
                            withAnimation {
                                showDeleteOption.toggle()
                            }
                        } label: {
                            Image("delete")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 35, height: 35)
                        }
                        .opacity(sharedData.likedProducts.isEmpty ? 0 : 1)
                    }
                    
                    if sharedData.likedProducts.isEmpty{
                        Group{
                            Image("search")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding()
                                .padding(.top, 35)
                            
                            Text("No favourite yet.")
                                .font(.custom(Extensions.customFSB, size: 25))
                            
                            Text("Hit the like button on each product page to add favourite ones.")
                                .font(.custom(Extensions.customFR, size: 18))
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                                .padding(.top, 10)
                                .multilineTextAlignment(.center)
                        }
                    } else {
                        VStack(spacing: 15){
                            ForEach(sharedData.likedProducts){product in
                                HStack(spacing: 0){
                                    if showDeleteOption{
                                        Button {
                                            sharedData.deleteProduct(product: product)
                                        } label: {
                                            Image(systemName: "minus.circle.fill")
                                                .font(.title2)
                                                .foregroundColor(.red)
                                        }
                                        .padding(.trailing)

                                    }
                                    CardView(product: product)
                                }
                            }
                        }
                        .padding(.top, 25)
                        .padding(.horizontal)
                    }
                }
                .padding()
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color("BG")
                    .ignoresSafeArea()
            )
        }
    }
    
    @ViewBuilder
    func CardView(product: Product)-> some View {
        HStack(spacing: 15){
            WebImage(url: URL(string: product.image))
                .resizable()
                .indicator(.activity) // Activity indicator while loading
                .scaledToFit() // Scale the image to fit the frame
                .frame(width: 100, height: 100)
            
            VStack(spacing: 8){
                Text(product.title)
                    .font(.custom(Extensions.customFSB, size: 18))
                    .lineLimit(1)
                
                Text(product.category)
                    .font(.custom(Extensions.customFSB, size: 17))
                    .foregroundColor(Color("FGreen"))

                Text("\(String(format: "%.2f", product.ratingRate)) Ratings")
                    .font(.custom(Extensions.customFSB, size: 13))
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            Color("WhiteBG")
                .cornerRadius(15)
                .ignoresSafeArea()
        )
    }
    

}

#Preview {
    LikedPage()
}
