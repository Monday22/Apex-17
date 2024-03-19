//
//  PredatorDetail.swift
//  Apex-17
//
//  Created by Anthony Lartey on 19/03/2024.
//

import SwiftUI
import MapKit

struct PredatorDetail: View {
    let predator: ApexPredator
    @State var postion: MapCameraPosition
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                ZStack(alignment: .bottomTrailing) {
                    // Background Image
                    Image(predator.type.rawValue)
                        .resizable()
                        .scaledToFit()
                        .overlay {
                            LinearGradient(stops: [Gradient.Stop(color: .clear, location: 0.8), Gradient.Stop(color: .black, location: 1)], startPoint: .top, endPoint: .bottom)
                        }
                    // Dino Image
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width / 1.5, height: geo.size.height / 3.0)
                        .scaleEffect(x: -1)
                        .shadow(color: .black, radius: 7.0)
                        .offset(y: 20)
                }
                VStack(alignment: .leading) {
                    // Dino Name
                    Text(predator.name)
                        .font(.largeTitle)
                    // Current Location
                    NavigationLink {
                        PredatorMap(position: .camera(MapCamera(centerCoordinate: predator.location, distance: 1000, heading: 250, pitch: 80)))
                    } label: {
                        Map(position: $postion) {
                            Annotation(predator.name, coordinate: predator.location) {
                                Image(systemName: "mappin.and.ellipse")
                                    .font(.largeTitle)
                                    .imageScale(.large)
                                    .symbolEffect(.pulse)
                            }
                            .annotationTitles(.hidden)
                        }
                        .frame(height: 125.0)
                        .overlay(alignment: .trailing) {
                            Image(systemName: "greaterthan")
                                .imageScale(.large)
                                .font(.title3)
                                .padding(.trailing, 5.0)
                        }
                        .overlay(alignment: .topLeading) {
                            Text("Current Location")
                                .padding([.leading, .bottom], 5.0)
                                .padding(.trailing, 8.0)
                                .background(Color.black.opacity(0.33))
                                .clipShape(.rect(bottomTrailingRadius: 15.0))
                        }
                        .clipShape(.rect(cornerRadius: 15.0))
                    }
                    // Appears In
                    Text("Appears In:")
                        .font(.title3)
                        .padding(.top)
                    ForEach(predator.movies, id: \.self) { movie in
                        Text("•" + movie)
                            .font(.subheadline)
                    }
                    // Move Moments
                    Text("Movie Moments")
                        .font(.title)
                        .padding(.top, 15.0)
                    ForEach(predator.movieScenes) { scene in
                        Text(scene.movie)
                            .font(.title2)
                            .padding(.vertical, 1.0)
                        Text(scene.sceneDescription)
                            .padding(.bottom, 15.0)
                        
                    }
                    // Link to WebPage
                    Text("Read More:")
                        .font(.caption)
                    Link(predator.link, destination: URL(string: predator.link)!)
                        .font(.caption)
                        .foregroundStyle(Color.blue)
                }
                .padding()
                .padding(.bottom)
                .frame(width: geo.size.width, alignment: .leading)
            }
            .ignoresSafeArea()
        }
        .toolbarBackground(.automatic)
    }
}

#Preview {
    NavigationStack {
        PredatorDetail(predator: Predators().apexPredators[2], postion: .camera(MapCamera(centerCoordinate: Predators().apexPredators[2].location, distance: 30000)))
            .preferredColorScheme(.dark)
    }
}
