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
    
    @State var isDetailPresented = false
    @StateObject private var viewModel = CompaniesViewModel()
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        //appearance.backgroundColor = UIColor.bg
        
        //UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        
        
        ZStack{
            TabView {
                NavigationView {
                    HomeView()
                }
                .tabItem{
                    Image(systemName: "house")
                    Text("Home")
                }
                    
                MapContentView(viewModel: viewModel)
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
            
            GeometryReader { geometry in
                VStack {
                    if viewModel.isSelectedAnnotation {
                        BottomSheetView(selectedAnnotation: $viewModel.selectedAnnotation,
                                        isPresented: $isDetailPresented)
                        .onDisappear() {
                            self.viewModel.selectedAnnotation = nil
                        }
                        .padding(.top, geometry.size.height * 0.8)
                        .transition(.opacity.combined(with: .move(edge: .bottom)))
                    }
                }
                .animation(.interactiveSpring(), value: viewModel.isSelectedAnnotation)
                .fullScreenCover(isPresented: $isDetailPresented) {
                    CompanyDetailView(selectedCompany: viewModel.selectedCompany,
                                      selectedAnnotation: $viewModel.selectedAnnotation)
                    .onDisappear() {
                        print("onDisappear!!!")
                    }
                }
            }
        }

        
    }
}

//#Preview {
//    ContentView()
//}


