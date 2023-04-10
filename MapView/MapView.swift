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
    var body: some View {
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
        .onAppear {
            Task {
                await viewModel.checkLocationServices()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
