//
//  SearchVM.swift
//  MapView
//
//  Created by Paulo Orquillo on 11/04/23.
//

import MapKit

//needs to conform to NSObject and MKLocalSearchCompleterDelegate
final class SearchVM: NSObject, ObservableObject, MKLocalSearchCompleterDelegate {
    @Published private(set) var results: Array<AddressResult> = []
    @Published var searchableText = "" 

    private lazy var localSearchCompleter: MKLocalSearchCompleter = {
        let completer = MKLocalSearchCompleter()
        completer.delegate = self
        return completer
    }()
    
    func searchAddress(_ searchableText: String) {
        print(searchableText)
        guard searchableText.isEmpty == false else { return }
        localSearchCompleter.queryFragment = searchableText
    }
    
    // MKLocalSearchCompleterDelegate functions
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        Task { @MainActor in // is this same as dispatchqueue.main.async?
            results = completer.results.map {
                AddressResult(title: $0.title, subtitle: $0.subtitle)
            }
            
        }
    }
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print(error)
    }
}
