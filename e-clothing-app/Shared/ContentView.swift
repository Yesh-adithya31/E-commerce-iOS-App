//
//  ContentView.swift
//  e-clothing-app
//
//  Created by Ovini on 2024-03-17.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("log_status") var log_status: Bool = false
    var body: some View {
        Group{
            if log_status {
                HomePage()
            }else {
                OnBoardingPage()
            }
        }
    }
}

#Preview {
    ContentView()
}
