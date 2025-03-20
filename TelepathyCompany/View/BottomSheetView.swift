//
//  BottomSheetView.swift
//  TelepathyCompany
//
//  Created by james on 3/3/25.
//

import SwiftUI

struct BottomSheetView: View {
    //@State var jobs: [Job]
    @Binding var selectedAnnotation: CompanyAnnotation?
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.bgColor.ignoresSafeArea()
            
            Button(action: {
                //selectedAnnotation = nil
                isPresented = true
            }, label: {
                HStack(spacing: 16) {
                    Image(selectedAnnotation?.company.img ?? "profileAvatar")
                        .resizable()
                        .frame(width: 150, height: 100)
                    
                    VStack(alignment: .leading) {
                        Text(selectedAnnotation?.company.name ?? "unknown")
                            .foregroundColor(.buttonTextColor)
                            .fontBold(size: 20)
                        
                        Text(selectedAnnotation?.company.type ?? "unknown")
                            .foregroundColor(.buttonTextColor)
                            .fontRegular(size: 16)
                        
                        Text(selectedAnnotation?.company.addr ?? "unknown")
                            .foregroundColor(.buttonTextColor)
                            .fontRegular(size: 15)
                    }
                    //.frame(height: 100)
                }
                .padding(.all, 20)
            })
        }
    }
}
