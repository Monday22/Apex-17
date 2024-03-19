//
//  PredatorMap.swift
//  Apex-17
//
//  Created by Anthony Lartey on 19/03/2024.
//

import SwiftUI
import MapKit

struct PredatorMap: View {
    let predators = Predators()
    @State var satellite: Bool = false
    @State var position: MapCameraPosition
    var body: some View {
        Map(position: $position) {
            ForEach(predators.apexPredators) { predator in
                Annotation(predator.name, coordinate: predator.location) {
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100.0, height: 100.0)
                        .shadow(color: .white, radius: 3.0)
                        .scaleEffect(x: -1.0)
                }
            }
        }
        .mapStyle(satellite ? .imagery(elevation: .realistic) : .standard(elevation: .realistic))
        .overlay(alignment: .bottomTrailing) {
            Button {
                satellite.toggle()
            } label: {
                Image(systemName: satellite ? "globe.americas.fill" : "globe.americas")
                    .font(.largeTitle)
                    .imageScale(.large)
                    .padding(3.0)
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 7.0))
                    .shadow(radius: 3.0)
                    .padding()
            }
        }
        .toolbarBackground(.automatic)
    }
}
#Preview {
    PredatorMap(position: .camera(MapCamera(centerCoordinate: Predators().apexPredators[2].location, distance: 1000.0, heading: 250.0, pitch: 80.0)))
        .preferredColorScheme(.dark)
}
