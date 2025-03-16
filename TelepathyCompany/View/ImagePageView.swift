//
//  ImagePageView.swift
//  TelepathyCompany
//
//  Created by james on 2/1/25.
//

import SwiftUI

struct ImagePageView: View {
    @State private var currentIndex = 0
    private let colors: [ImageResource] = [.interpark, .jobplanet, .krafton]
        
    
    var body: some View {
        
        
        TabView(selection: $currentIndex) {
            ForEach(0..<colors.count, id: \.self) { index in
                Image(colors[index])
                    .resizable()
                    //.aspectRatio(contentMode: .fill)
                    .scaledToFill()
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .frame(height: 280)
        
        
    }
}

#Preview {
    ImagePageView()
}
