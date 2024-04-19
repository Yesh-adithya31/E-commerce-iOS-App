//
//  CustomCorners.swift
//  e-clothing-app
//
//  Created by Yesh Adithya on 2024-03-18.
//

import SwiftUI

struct CustomCorners: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius ))
        return Path(path.cgPath )
    }
}
