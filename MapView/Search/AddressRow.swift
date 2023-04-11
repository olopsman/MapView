//
//  AddressRow.swift
//  MapView
//
//  Created by Paulo Orquillo on 11/04/23.
//

import SwiftUI

struct AddressRow: View {
    let address: AddressResult
    var body: some View {
        NavigationLink {
            MapView()
        } label: {
            VStack(alignment: .leading) {
                Text(address.title)
                Text(address.subtitle)
                    .font(.caption)
            }
        }
        .padding(.bottom, 2)
    }
}

