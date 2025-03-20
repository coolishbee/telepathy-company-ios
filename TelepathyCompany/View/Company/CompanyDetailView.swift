//
//  CompanyDetailView.swift
//  TelepathyCompany
//
//  Created by james on 3/16/25.
//

import SwiftUI
import ScalingHeaderScrollView

struct CompanyDetailView: View {
    @State var selectedCompany: Company?
    @State private var scrollToTop: Bool = false
    @Binding var selectedAnnotation: CompanyAnnotation?
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView(content: {
            ZStack {
                ScalingHeaderScrollView {
                    Image(selectedCompany?.img ?? "nil")
                        .resizable()
                        .scaledToFill()
                    
                } content: {
                    companyDetailContentView
                        .padding(.top, 20)
                }
                .allowsHeaderCollapse()
                .scrollToTop(resetScroll: $scrollToTop)
                
                topButtons
            }
            .ignoresSafeArea()
        })
        
    }
    
    private var topButtons: some View {
        VStack {
            HStack(spacing: 16) {
                Button("") {
                    self.presentationMode.wrappedValue.dismiss()
                    self.selectedAnnotation = nil
                }
                .buttonStyle(CircleButtonStyle(imageName: "arrow.backward"))
                .padding(.leading, 16)
                
                Spacer()
                Button("") {
                    print("Share")
                    scrollToTop = true
                }
                .buttonStyle(CircleButtonStyle(imageName: "arrowshape.turn.up.forward.fill"))

                Button("") {
                    print("Like")
                }
                .buttonStyle(CircleButtonStyle(imageName: "heart.fill", foreground: .red))
                .padding(.trailing, 16)
            }
            Spacer()
        }
        .padding(.top, 45)
        .ignoresSafeArea()
    }
    
    private var companyDetailContentView: some View {
        VStack(alignment: .leading, spacing: 20) {
            contentHeader
            details
            introDesc
            Color.clear.frame(height: 10)
            welfareHeader
            welfareDesc
            Color.clear.frame(height: 10)
            jobList
        }
        .padding(.horizontal, 24)
    }
    
    private var contentHeader: some View {
        VStack(spacing: 0) {
            HStack {
                companyName
                Spacer()
                stars
            }
            address
        }
    }
    
    private var details: some View {
        VStack(spacing: -2) {
            introHeader
            tagDesc
            badges
        }
        .padding(.top, 30)
    }
    
    //MARK: in contentHeader
    private var companyName: some View {
        Text(selectedCompany?.name ?? "nil")
            .fontBold(color: .buttonText, size: 24)            
    }
    
    private var stars: some View {
        HStack(alignment: .center , spacing: 8) {
            Image("Star")
                .offset(y: -3)
            Text("4.9")
                .fontBold(color: .buttonText, size: 18)
        }
    }
    
    private var address: some View {
        HStack(spacing: 6.5) {
            Image(systemName: "mappin")
                .foregroundColor(.blue)
                .frame(width: 11, height: 14)
            Text(selectedCompany?.addr ?? "nil")
                .fontRegular(color: .blue, size: 16)
            Spacer()
        }
    }
    //end contentHeader
    
    //MARK: in details
    private var introHeader: some View {
        HStack {
            Text("Intro".localized())
                .fontBold(color: .buttonText, size: 22)
            Spacer()
        }
    }
    
    private var tagDesc: some View {
        HStack {
            Text("IT, 컨텐츠 • 9년차 (2016) • 51~300명")
                .fontRegular(color: .appGray, size: 16)
            Spacer()
        }
    }
    
    private var badges: some View {
        ScrollView(.horizontal) {
            HStack {
                badgeView(image: "cup.and.saucer", title: "Cafeteria")
                badgeView(image: "bus", title: "Shuttle bus")
                badgeView(image: "lightrail", title: "Station area")
                badgeView(image: "figure.strengthtraining.traditional", title: "Fitness")
            }
        }
        .padding(.top, 20)
    }
    
    private func badgeView(image: String, title: String) -> some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(Color.black.opacity(0.04))
            .overlay(
                VStack {
                    Image(systemName: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 21)
                    Text(title)
                        .fontRegular(color: .appGray, size: 12)
                }
                .padding(.top, 21)
            )
            .frame(width: 80, height: 80)
    }
        
    private var introDesc: some View {
        Text(selectedCompany?.intro ?? "nil")
            .fontRegular(color: .appGray, size: 16)
            .padding(.top, 32)
    }
    //end details

    private var welfareHeader: some View {
        HStack {
            Text("Welfare".localized())
                .fontBold(color: .buttonText, size: 22)
            Spacer()
        }
    }
    
    private var welfareDesc: some View {
        Text(selectedCompany?.welfare ?? "nil")
            .fontRegular(color: .buttonText, size: 15)
    }
    
    private var jobList: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            Spacer()
            
            Text("Jobs".localized())
                .fontBold(color: .buttonText, size: 22)

            ScrollView{
                ForEach(selectedCompany?.jobs ?? []) { job in
                    NavigationLink(destination: JobDetailView(selectedJob: job,
                                                              selectedCompany: selectedCompany).navigationBarBackButtonHidden()) {
                        JobListCell(job: job)
                    }
                }
            }
            
            
            Color.white.frame(height: 15)
        }
    }
}
