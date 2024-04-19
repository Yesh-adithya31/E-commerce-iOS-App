//
//  MoreProductView.swift
//  e-clothing-app
//
//  Created by Yesh Adithya on 2024-03-29.
//

import SwiftUI

struct MoreProductView: View {
    var body: some View {
        VStack{
            Text("More Products")
                .font(.custom(Extensions.customFB, size: 24))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color("BG"))
    }
}

#Preview {
    MoreProductView()
}
