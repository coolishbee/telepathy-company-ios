//
//  MapContentView.swift
//  TelepathyCompany
//
//  Created by james on 3/8/25.
//

import SwiftUI

struct MapContentView: View {
    @Binding var annotations: [CompanyAnnotation]?
    @Binding var showMapAlert: Bool
    var viewModel: CompaniesViewModel?
            
    
    var body : some View {
        ZStack {
            MapView(annotations: $annotations, viewModel: viewModel)
                .alert(isPresented: $showMapAlert) {
                    Alert(title: Text("Location access denied"),
                          message: Text("Your location is needed"),
                          primaryButton: .cancel(),
                          secondaryButton: .default(Text("Settings"),
                                                    action: { self.openDeviceSettings() }))
                }.edgesIgnoringSafeArea(.all)
            
            
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
