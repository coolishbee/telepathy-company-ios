//
//  ContentView.swift
//  TelepathyCompany
//
//  Created by james on 1/30/25.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.5007, longitude: 127.0364),
        latitudinalMeters: 400, longitudinalMeters: 400)
    
    @State var isDetailPresented = false
    
    @ObservedObject var viewModel = CompaniesViewModel()
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        //appearance.backgroundColor = UIColor.bg
        
        //UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        
        NavigationView {
            TabView {
                Map(coordinateRegion: $region)
                    .ignoresSafeArea()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                MapContentView(annotations: $viewModel.annotiations, showMapAlert: $viewModel.showMapAlert, viewModel: viewModel)
                    .fullScreenCover(isPresented: $isDetailPresented){}
                    .ignoresSafeArea()
                    .tabItem{
                        Image(systemName: "map")
                        Text("Map")
                    }
//                MapView(annotations: $viewModel.annotiations, viewModel: viewModel)
//                    .alert(isPresented: $viewModel.showMapAlert) {
//                        Alert(title: Text("Location access denied"),
//                              message: Text("Your location is needed"),
//                              primaryButton: .cancel(),
//                              secondaryButton: .default(Text("Settings"),
//                                                        action: { self.openDeviceSettings() }))
//                    }.edgesIgnoringSafeArea(.all)
//                    .tabItem{
//                        Image(systemName: "map")
//                        Text("Map")
//                    }
                MyPagerView()
                    .tabItem {
                        Image(systemName: "person")
                        Text("Profile")
                    }
            }
        }
    }
}

//#Preview {
//    ContentView()
//}


