//
//  AddressResult.swift
//  MapView
//
//  Created by Paulo Orquillo on 11/04/23.
//

import Foundation

struct AddressResult: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let subtitle: String
}
