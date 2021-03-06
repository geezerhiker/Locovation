//
//  ContentView.swift
//  Shared
//
//  Created by Andy Ibanez on 3/13/21.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
  @StateObject var locationViewModel = LocationViewModel()
//  @StateObject var elevationViewModel = ElevationViewModel()
  
  var body: some View {
    switch locationViewModel.authorizationStatus {
    case .notDetermined:
      AnyView(RequestLocationView())
        .environmentObject(locationViewModel)
    case .restricted:
      ErrorView(errorText: "Location use is restricted.")
    case .denied:
      ErrorView(errorText: "The app does not have location permissions. Please enable them in settings.")
    case .authorizedAlways, .authorizedWhenInUse:
      TrackingView()
        .environmentObject(locationViewModel)
//        .environmentObject(elevationViewModel)
    default:
      Text("Unexpected status")
    }
  }
}

struct RequestLocationView: View {
  @EnvironmentObject var locationViewModel: LocationViewModel
  
  var body: some View {
    VStack {
      Image(systemName: "location.circle")
        .resizable()
        .frame(width: 100, height: 100, alignment: .center)
        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
      Button(action: {
        locationViewModel.requestPermission()
      }, label: {
        Label("Allow tracking", systemImage: "location")
      })
      .padding(10)
      .foregroundColor(.white)
      .background(Color.blue)
      .clipShape(RoundedRectangle(cornerRadius: 8))
      Text("We need your permission to track you.")
        .foregroundColor(.gray)
        .font(.caption)
    }
  }
}

struct ErrorView: View {
  var errorText: String
  
  var body: some View {
    VStack {
      Image(systemName: "xmark.octagon")
        .resizable()
        .frame(width: 100, height: 100, alignment: .center)
      Text(errorText)
    }
    .padding()
    .foregroundColor(.white)
    .background(Color.red)
    .clipShape(RoundedRectangle(cornerRadius: 12))
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
