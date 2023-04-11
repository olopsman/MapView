//
//  MapView.swift
//  MapView
//
//  Created by Paulo Orquillo on 11/04/23.
//

import SwiftUI
import MapKit

struct MapView: View {
    @StateObject var viewModel = MapViewVM()
    private let address: AddressResult
    init(address: AddressResult) {
        self.address = address
    }
    var body: some View {
        //MAP using userlocation
//        Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
        //MAP using search matches
        Map(coordinateRegion: $viewModel.region, annotationItems: viewModel.annotationItems, annotationContent: { item in
            MapMarker(coordinate: item.coordinate)
        })
        .ignoresSafeArea()
        .onAppear {
//            Task {
//                await viewModel.checkLocationServices()
//            }

                 viewModel.getPlace(from: address)
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView()
//    }
//}
