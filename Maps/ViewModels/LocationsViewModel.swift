//
//  LocationsViewModel.swift
//  Maps
//
//  Created by Dhruv Suhird on 08/04/24.
//

import Foundation
import SwiftUI
import MapKit

// Our observable object class
class LocationViewModel: ObservableObject{
    @Published var locations: [Location]
    
    @Published var mapLocation: Location{
        didSet{
            updateMapRegion(location: mapLocation)
        }
    }
    
    // Current region on Map
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapspan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    // Show list of locations
    @Published var showlocationList: Bool = false
    
    // Show location detail via sheet
    @Published var sheetLocation: Location? = nil
    
    init(){
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        
        self.updateMapRegion(location: locations.first!)
    }
    
    private func updateMapRegion(location: Location){
        withAnimation(.easeInOut){
            mapRegion = MKCoordinateRegion(center: location.coordinates, span: mapspan)
        }
    }
    
    func togglelocationlist(){
        withAnimation(.easeInOut){
            showlocationList.toggle()
        }
    }
    
    func showNextlocation(location: Location){
        withAnimation(.easeInOut){
            mapLocation = location
            showlocationList = false
        }
    }
    
    func nextButtonPressed(){
        guard let currentIndex = locations.firstIndex(where: {$0 == mapLocation}) else{
            return
        }
        
        let nextIndex = currentIndex + 1
        
        guard locations.indices.contains(nextIndex) else{
            guard let firstLocation = locations.first else{return}
            showNextlocation(location: firstLocation)
            return
        }
        
        let nextLocation = locations[nextIndex]
        showNextlocation(location: nextLocation)
    }
}
