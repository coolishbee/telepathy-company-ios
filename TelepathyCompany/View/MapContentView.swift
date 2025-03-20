//
//  MapContentView.swift
//  TelepathyCompany
//
//  Created by james on 3/8/25.
//

import SwiftUI

struct MapContentView: View {
    
    @ObservedObject private var viewModel = CompaniesViewModel()
    
    @State var isDetailPresented = false
    
    var body : some View {
        ZStack {
            MapView(annotations: $viewModel.annotiations, viewModel: viewModel)
                .alert(isPresented: $viewModel.showMapAlert) {
                    Alert(title: Text("Location access denied"),
                          message: Text("Your location is needed"),
                          primaryButton: .cancel(),
                          secondaryButton: .default(Text("Settings"),
                                                    action: { self.openDeviceSettings() }))
                }
                .edgesIgnoringSafeArea(.all)
            
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

extension MapContentView {
    func openDeviceSettings() {
        guard let url = URL.init(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func clearSelectedAnnotation() {
        //self.viewModel.selectedAnnotation = nil
        //self.viewModel.selectedAnnotations = nil
    }
}
