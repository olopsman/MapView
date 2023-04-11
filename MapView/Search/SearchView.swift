//
//  SearchView.swift
//  MapView
//
//  Created by Paulo Orquillo on 11/04/23.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel = SearchVM()
    @FocusState private var isFocusedTextField: Bool
    var backgroundColor: Color = Color.init(uiColor: .systemGray6)
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0){
                TextField("Search", text: $viewModel.searchableText)
                .padding()
                .autocorrectionDisabled()
                .focused($isFocusedTextField)
                .font(.title)
                .onReceive(
                    viewModel.$searchableText.debounce(for: .seconds(1), scheduler: DispatchQueue.main)
                ) {
                    viewModel.searchAddress($0)
                }
                .background(Color.init(uiColor: .systemBackground))
                .overlay {
                    ClearButton(text: $viewModel.searchableText)
                                                .padding(.trailing)
                                                .padding(.top, 8)
                }
                .onAppear {
                    isFocusedTextField = true
                }

                List(self.viewModel.results, id: \.self) { address in
                    AddressRow(address: address)
                                            .listRowBackground(backgroundColor)
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }
            .background(backgroundColor)
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
