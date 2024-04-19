//
//  CardView.swift
//  e-clothing-app
//
//  Created by Yesh Adithya on 2024-03-30.
//

import SwiftUI
import SDWebImageSwiftUI

struct CardView: View {
    @Binding var product: Product
    var body: some View {
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

                HStack(spacing: 10){
                    Text("Quantity")
                        .font(.custom(Extensions.customFR, size: 14))
                        .foregroundColor(.gray)
                    
                    Button {
                        product.quantity = (product.quantity > 0 ? (product.quantity - 1) : 0)
                    } label: {
                        Image(systemName: "minus")
                            .font(.caption)
                            .foregroundColor(.white)
                            .frame(width: 20, height: 20)
                            .background(.black)
                            .cornerRadius(4)
                    }
                    
                    Text("\(product.quantity)")
                        .font(.custom(Extensions.customFR, size: 14))
                        .foregroundColor(.gray)
                    
                    Button {
                        product.quantity += 1

                    } label: {
                        Image(systemName: "plus")
                            .font(.caption)
                            .foregroundColor(.white)
                            .frame(width: 20, height: 20)
                            .background(.black)
                            .cornerRadius(4)
                    }
                }
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

