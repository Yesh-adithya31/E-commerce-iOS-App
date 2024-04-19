//
//  CartPage.swift
//  e-clothing-app
//
//  Created by Yesh Adithya on 2024-03-30.
//

import SwiftUI
import SDWebImageSwiftUI

struct CartPage: View {
    @EnvironmentObject var sharedData: SharedDataModel
    @State var showDeleteOption: Bool = false
    var body: some View {
        NavigationView{
            VStack(spacing: 10 ){
                ScrollView(.vertical, showsIndicators: false){
                    VStack{
                        HStack{
                            Text("Cart")
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
                            .opacity(sharedData.cartProducts.isEmpty ? 0 : 1)
                        }
                        
                        if sharedData.cartProducts.isEmpty{
                            Group{
                                Image("bg4")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding()
                                    .padding(.top, 35)
                                
                                Text("No items added.")
                                    .font(.custom(Extensions.customFSB, size: 25))
                                
                                Text("Hit the add button on each product page to add to cart ones.")
                                    .font(.custom(Extensions.customFR, size: 18))
                                    .foregroundColor(.gray)
                                    .padding(.horizontal)
                                    .padding(.top, 10)
                                    .multilineTextAlignment(.center)
                            }
                        } else {
                            VStack(spacing: 15){
                                ForEach($sharedData.cartProducts){$product in
                                    HStack(spacing: 0){
                                        if showDeleteOption{
                                            Button {
                                                sharedData.deleteCartProduct(product: product)
                                            } label: {
                                                Image(systemName: "minus.circle.fill")
                                                    .font(.title2)
                                                    .foregroundColor(.red)
                                            }
                                            .padding(.trailing)

                                        }
                                        CardView(product: $product)
                                    }
                                }
                            }
                            .padding(.top, 25)
                            .padding(.horizontal)
                        }
                    }
                    .padding()
                }
                
                if !sharedData.cartProducts.isEmpty{
                    Group{
                        HStack{
                            Text("Total")
                                .font(.custom(Extensions.customFSB, size: 14))
                            Spacer()
                            Text("\(sharedData.getTotalPrice())")
                                .font(.custom(Extensions.customFB, size: 18))
                                .foregroundColor(Color("FGreen"))
                        }
                        
                        Button {
                            
                        } label: {
                            Text("Checkout")
                                .font(.custom(Extensions.customFB, size: 18))
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .frame(maxWidth: .infinity)
                                .background(Color("FGreen"))
                                .cornerRadius(15)
                                .shadow(color: Color.black.opacity(0.05),radius:  5, x: 5, y: 5)
                        }
                        .padding(.vertical)

                    }
                    .padding(.horizontal,25)
                }
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color("BG")
                    .ignoresSafeArea()
            )
        }
    }
    
}

#Preview {
    CartPage()
}
