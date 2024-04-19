//
//  ProductDetailView.swift
//  e-clothing-app
//
//  Created by Yesh Adithya on 2024-03-30.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductDetailView: View {
    var animation: Namespace.ID
    var product:Product
    @EnvironmentObject var sharedData: SharedDataModel
    @EnvironmentObject var homeVM: HomeViewModel
    
    var body: some View {
        VStack{
            VStack{
                HStack {
                    Button {
                        withAnimation(.easeInOut) {
                            sharedData.showDetails = false
                        }
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                             .foregroundColor(Color.black.opacity(0.7))
                    }
                    
                    Spacer()
                    
                    Button {
                        addToLiked()
                    } label: {
                        Image("Liked")
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                            .foregroundColor(isLiked() ? .red : Color.black.opacity(0.7))
                    }

                }
                .padding()
                
                WebImage(url: URL(string: product.image))
                    .resizable()
                    .indicator(.activity) // Activity indicator while loading
                    .scaledToFit() // Scale the image to fit the frame
                    .matchedGeometryEffect(id: "\(product.id)\(sharedData.showSearchPage ? "SEARCH": "IMAGE")", in: animation)
                    .frame(maxWidth: .infinity) // Set desired frame size
                    .padding(.horizontal)
            }
            .frame(height: getRect().height / 2.7)
            
            ScrollView(.vertical, showsIndicators: false){
                VStack(alignment: .leading, spacing: 15, content: {
                    Text(product.title)
                        .font(.custom(Extensions.customFSB, size: 20))
                    
                    Text("Rs. "+String(format: "%.2f", product.price))
                        .font(.custom(Extensions.customFSB, size: 20))
                    
                    Text(product.category)
                        .font(.custom(Extensions.customFSB, size: 18))
                        .foregroundColor(.gray)

                    Text("Description")
                        .font(.custom(Extensions.customFSB, size: 16))
                    
                    
                    Text(product.description)
                        .font(.custom(Extensions.customFR, size: 15))
                    
                    Text("Reviews")
                        .font(.custom(Extensions.customFSB, size: 14))
                    
                    Text(String(format: "%.2f", product.ratingRate)+" Ratings")
                        .font(.custom(Extensions.customFSB, size: 20))
                    
                    Text(String(product.ratingCount)+" Reviews")
                        .font(.custom(Extensions.customFSB, size: 14))
                        .foregroundColor(.gray)
                    
                    Button(action: {
                        addToCart()
                    }, label: {
                        Text("\(isAddedToCart() ? "Already added to Cart" : "Add to Cart")")
                            .font(.custom(Extensions.customFB, size: 20))
                            .foregroundColor(.white)
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity)
                            .background(Color("FGreen").cornerRadius(15))
                    })
                })
                .padding([.horizontal, .bottom], 20)
                .padding(.top, 25)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color("BG")
                    .clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 25))
                    .ignoresSafeArea()
            )
        }
        .animation(.easeInOut, value: sharedData.likedProducts)
        .animation(.easeInOut, value: sharedData.cartProducts)
        .background(
            Color("WhiteBG").ignoresSafeArea()
        )
    }
    
    func isAddedToCart()-> Bool{
        return sharedData.cartProducts.contains{ product in
            return self.product.id == product.id
        }
    }
    
    func isLiked()-> Bool{
        return sharedData.likedProducts.contains{ product in
            return self.product.id == product.id
        }
    }
    
    func addToCart(){
        if let index = sharedData.cartProducts.firstIndex(where: { product in
            return self.product.id == product.id
        }){
            sharedData.cartProducts.remove(at: index)
        }else{
            sharedData.cartProducts.append(product)
        }
    }
    
    func addToLiked (){
        if let index = sharedData.likedProducts.firstIndex(where: { product in
            return self.product.id == product.id
        }){
            sharedData.likedProducts.remove(at: index)
        }else{
            sharedData.likedProducts.append(product)
        }
    }
}

#Preview {
    ContentView()
}
