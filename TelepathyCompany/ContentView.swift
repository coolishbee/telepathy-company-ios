//
//  ContentView.swift
//  TelepathyCompany
//
//  Created by james on 1/30/25.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
//    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.5007, longitude: 127.0364),
//                                                   latitudinalMeters: 400, longitudinalMeters: 400)
    
    //@State var isDetailPresented = false
    
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
            ZStack{
                TabView {
                    MapContentView()
                        //.fullScreenCover(isPresented: $isDetailPresented){}
                        .ignoresSafeArea()
                        .tabItem{
                            Image(systemName: "map")
                            Text("Map")
                        }
                    MyPagerView()
                        .tabItem {
                            Image(systemName: "person") //house
                            Text("Profile") //Home
                        }
                }
            }
            
        }
    }
}

//#Preview {
//    ContentView()
//}


