//
//  LocationListView.swift
//  Maps
//
//  Created by Dhruv Suhird on 11/04/24.
//

import SwiftUI

struct LocationListView: View {
    
    @EnvironmentObject private var vm: LocationViewModel
    
    var body: some View {
        List{
            ForEach(vm.locations){location in
                Button{
                    vm.showNextlocation(location: location)
                } label: {
                    listrowView(location: location)
                }
                
                .padding(.vertical, 4)
                .listRowBackground(Color.clear)
            }
            .listStyle(PlainListStyle())
        }
    }
}
    
#Preview {
    LocationListView()
        .environmentObject(LocationViewModel())
}
    
    
extension LocationListView{
        
    private func listrowView(location: Location) -> some View{
        HStack{
            if let imageName = location.imageNames.first{
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 45, height: 45)
                    .cornerRadius(10)
            }
            
            VStack(alignment: .leading){
                Text(location.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(location.cityName)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        
    }
}
    

