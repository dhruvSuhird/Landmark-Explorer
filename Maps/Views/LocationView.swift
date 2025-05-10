//
//  LocationView.swift
//  Maps
//
//  Created by Dhruv Suhird on 08/04/24.
//

import SwiftUI
import MapKit

struct LocationView: View {
    
    // A view that expects to find a LocationViewModel object
    // in the environment, and shows its score.
    @EnvironmentObject private var vm: LocationViewModel
    let maxwidthForIpad: CGFloat = 700
    
    var body: some View {
        ZStack{
            mapLayer
                .ignoresSafeArea()
            
            VStack(spacing: 0){
                header
                    .padding()
                    .frame(maxWidth: maxwidthForIpad)
                
                Spacer()
                
                locationPreviewStack
            }
        }
        .sheet(item: $vm.sheetLocation, onDismiss: nil) {location in
            LocationDetailView(location: location)
        }
    }
}

#Preview {
    LocationView()
        .environmentObject(LocationViewModel())
}

extension LocationView{
    
    private var header: some View{
        VStack {
            Button(action: vm.togglelocationlist, label: {
                Text(vm.mapLocation.name + ", " + vm.mapLocation.cityName)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                            .rotationEffect(Angle(degrees: vm.showlocationList ? 180 : 0))
                        
                    }
            })
            
            if(vm.showlocationList){
                LocationListView()
            }
        }
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0.0, y: 15)
    } 
    
    private var mapLayer: some View{
        Map(coordinateRegion: $vm.mapRegion, 
            annotationItems: vm.locations,
            annotationContent: { location in
            MapAnnotation(coordinate: location.coordinates) {
                    MapAnnotationView()
                    .scaleEffect(vm.mapLocation == location ? 1:0.7)
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    .onTapGesture {
                        vm.showNextlocation(location: location)
                    }
                
                }
            }
        )
    }
    
    private var locationPreviewStack: some View{
        ZStack{
            ForEach(vm.locations) { location in
                if vm.mapLocation == location {
                    LocationPreviewView(location: location)
                        .shadow(color: Color.black.opacity(0.3), radius: 20)
                        .padding()
                        .frame(maxWidth: maxwidthForIpad)
                        .frame(maxWidth: .infinity)
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)))
                }
            }
        }
    }
}
