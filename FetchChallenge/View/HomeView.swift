//
//  ContentView.swift
//  FetchChallenge
//
//  Created by Akhil Anand Sirra on 13/06/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor.secondarySystemFill).ignoresSafeArea() // For not changing the background when keyboard is used
                MealListView()
                .navigationTitle("Desserts")
            }
        }
        .navigationViewStyle(StackNavigationViewStyle()) // To avoid sidebar on iPad
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
