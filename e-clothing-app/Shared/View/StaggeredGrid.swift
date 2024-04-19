//
//  StaggeredGrid.swift
//  e-clothing-app
//
//  Created by Yesh Adithya on 2024-03-29.
//

import SwiftUI

struct StaggeredGrid<Content: View,T: Identifiable>: View where T: Hashable {
    var content: (T) -> Content
    var list:[T]
    
    var column: Int
    var showIndicator: Bool
    var spacing:CGFloat
    
    init(column: Int ,showIndicator: Bool = false, spacing: CGFloat = 10 ,list: [T], @ViewBuilder content: @escaping (T)-> Content) {
        self.content = content
        self.list = list
        self.showIndicator = showIndicator
        self.spacing = spacing
        self.column = column
    }
    
    func setUpList()->[[T]]{
        var gridArray:[[T]] = Array(repeating: [], count: column)
        var currentIndex:Int = 0
        for object in list{
            gridArray[currentIndex].append(object)
            
            if(currentIndex == (column - 1)){
                currentIndex = 0
            }else{
                currentIndex += 1
            }
        }
        
        return gridArray
    }
    
    var body: some View {

        HStack(alignment: .top, spacing: 20){
            ForEach(setUpList(), id: \.self){columnsData in
                LazyVStack(spacing: spacing, content: {
                    ForEach(columnsData){object in
                        content(object)
                    }
                })
            }
        }
        .padding(.vertical)
    }
}

#Preview {
    HomePage()
}
