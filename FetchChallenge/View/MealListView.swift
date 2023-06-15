//
//  MealListView.swift
//  FetchChallenge
//
//  Created by Akhil Anand Sirra on 14/06/23.
//

import SwiftUI

import SwiftUI

struct MealListView: View {
    @StateObject private var viewModel = MealListViewModel()
    
    var body: some View {
        List(0..<viewModel.searchResults.count, id: \.self) { i in
            NavigationLink(destination: RecipeDetailView(mealID: viewModel.searchResults[i].id)) {
                MealListItem(meal: viewModel.searchResults[i])
            }
            .listRowSeparator(.hidden)
            .listRowBackground(
                RoundedRectangle(cornerRadius: 10)
                    .background(.clear)
                    .foregroundColor(Color(.systemBackground))
                
                    .padding(
                        EdgeInsets(
                            top: 5,
                            leading: 10,
                            bottom: 5,
                            trailing: 10
                        )
                    )
            )
        }
        .searchable(text: $viewModel.searchText)
        .listStyle(.plain)
        .task {
            await viewModel.fetchMealData()
        }.alert("", isPresented: $viewModel.hasError) {} message: {
            Text(viewModel.errorMessage)
        }
        
    }
}

struct MealListView_Previews: PreviewProvider {
    static var previews: some View {
        MealListView()
    }
}
