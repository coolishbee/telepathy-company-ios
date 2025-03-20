//
//  JobDetailView.swift
//  TelepathyCompany
//
//  Created by james on 3/19/25.
//

import SwiftUI
import ScalingHeaderScrollView

struct JobDetailView: View {
    @State var selectedJob: Job?
    @State var progress: CGFloat = 0
    @Environment(\.presentationMode) var presentationMode
    
    let selectedCompany: Company?
    private let minHeight = 110.0
    private let maxHeight = 372.0
    
    var body: some View {
        
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            ScalingHeaderScrollView {
                ZStack {
                    Color.white.edgesIgnoringSafeArea(.all)
                    largeHeader(progress: progress)
                }
                .padding(.top, -85)
            } content: {
                jobContentView
            }
            .height(min: minHeight, max: maxHeight)
            .collapseProgress($progress)
            .allowsHeaderGrowth()
            
            topButtons
            applyButton
        }
        .ignoresSafeArea()
    }
    
    private var topButtons: some View {
        VStack {
            HStack {
                Button("", action: { self.presentationMode.wrappedValue.dismiss() })
                    .buttonStyle(CircleButtonStyle(imageName: "arrow.backward"))
                    .padding(.leading, 17)
                    .padding(.top, 50)
                Spacer()
                Button("", action: { print("Info") })
                    .buttonStyle(CircleButtonStyle(imageName: "ellipsis"))
                    .padding(.trailing, 17)
                    .padding(.top, 50)
            }
            Spacer()
        }
    }
    
    private func largeHeader(progress: CGFloat) -> some View {
        ZStack {
            Image(selectedCompany?.img ?? "")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: maxHeight)
                .opacity(1 - progress)
            
            VStack {
                Spacer()
                
                ZStack(alignment: .leading) {

                    title
                        .padding(.leading, 10)
                        .padding(.top, -5.0)
                        .opacity(1 - max(0, min(1, (progress - 0.75) * 4.0)))

                    smallHeader
                        .padding(.leading, 70.0)
                        .opacity(progress)
                        .opacity(max(0, min(1, (progress - 0.75) * 4.0)))
                }
                .frame(height: 85.0)
            }
        }
    }
    
    private var title: some View {
        Text(selectedJob?.title ?? "nil")
            .frame(width: maxHeight, height: 70.0, alignment: .leading)
            .fontBold(color: .buttonText, size: 24)
    }
    
    private var smallHeader: some View {
        HStack(spacing: 12.0) {
            Image(selectedCompany?.img ?? "")
                .resizable()
                .frame(width: 40.0, height: 40.0)
                .clipShape(RoundedRectangle(cornerRadius: 6.0))

            Text(selectedJob?.title ?? "nil")
                .frame(width: 200.0, height: 40.0, alignment: .leading)
                .fontRegular(color: .buttonText, size: 17)
        }
    }
    
    private var jobContentView: some View {
        //VStack {
            //HStack {
                VStack(alignment: .leading, spacing: 20) {
                    jobInfo
                    Spacer()
                    skills
                    Spacer()
                    detailsHeader
                    detailsDesc
                    Spacer()
                    responsibilitiesHeader
                    responsibilitiesDesc
                    Spacer()
                    requirementsHeader
                    requirementsDesc
                    Spacer()
                    preferredHeader
                    preferredDesc
                    Color.clear.frame(height: 150)
                }
                .padding(.horizontal, 24)
            //}
        //}
    }
    
    private var jobInfo: some View {
        VStack(alignment: .leading) {
            HStack {
                companyName
                Spacer()
                likes
            }
            address
        }
    }
    
    private var companyName: some View {
        Text(selectedCompany?.name ?? "")
            .fontBold(color: .buttonText, size: 19)
    }
    
    private var likes: some View {
        HStack(alignment: .bottom , spacing: 5) {
            Image(systemName: "heart.fill")
                .foregroundColor(.red)
              
            likeCount
                .offset(y: 4)
        }
    }
    
    private var address: some View {
        Text(selectedCompany?.addr ?? "")
            .fontRegular(color: .appLightGray, size: 17)
    }
    
    private var likeCount: some View {
        Text("좋아요 5개")
            .fontRegular(color: .buttonText, size: 15)
    }
    
    private var skills: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Skills")
                .fontBold(color: .buttonText, size: 18)
            HStack {
                ForEach((0 ..< 3)) { col in
                    skillView(for: "Swift UI")
                }
            }
            HStack {
                ForEach((0 ..< 3)) { col in
                    skillView(for: "Flutter iOS")
                }
            }
        }
    }
    
    func skillView(for skill: String) -> some View {
        Text(skill)
            .padding(.vertical, 5)
            .padding(.horizontal, 14)
            .fontRegular(color: .blue, size: 16)
            .lineLimit(1)
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color.blue.opacity(0.08))
                    .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.blue))
            )
    }
    
    private var detailsHeader: some View {
        HStack {
            Text("Detail".localized())
                .fontBold(color: .buttonText, size: 22)
            Spacer()
        }
    }
    
    private var detailsDesc: some View {
        Text(selectedJob?.detail ?? "nil")
            .fontRegular(color: .buttonText, size: 15)
    }
    
    private var responsibilitiesHeader: some View {
        HStack {
            Text("Responsibilities".localized())
                .fontBold(color: .buttonText, size: 22)
            Spacer()
        }
    }
    
    private var responsibilitiesDesc: some View {
        Text(selectedJob?.responsibilities ?? "nil")
            .fontRegular(color: .buttonText, size: 15)
    }
    
    private var requirementsHeader: some View {
        HStack {
            Text("Requirements".localized())
                .fontBold(color: .buttonText, size: 22)
            Spacer()
        }
    }
    
    private var requirementsDesc: some View {
        Text(selectedJob?.requirements ?? "nil")
            .fontRegular(color: .buttonText, size: 15)
    }
    
    private var preferredHeader: some View {
        HStack {
            Text("Preferred Qualifications".localized())
                .fontBold(color: .buttonText, size: 22)
            Spacer()
        }
    }
    
    private var preferredDesc: some View {
        Text(selectedJob?.preferred ?? "nil")
            .fontRegular(color: .buttonText, size: 15)
    }
    
    private var applyButton: some View {
        VStack {
            Spacer()
            ZStack {
                VisualEffectView(effect: UIBlurEffect(style: .regular))
                    .frame(height: 180)
                    .padding(.bottom, -100)
                HStack {
                    Button("Apply".localized(), action: { print("Apply") })
                        .buttonStyle(HireButtonStyle())
                        .padding(.horizontal, 15)
                        .frame(width: 396, height: 60, alignment: .bottom)
                }
            }
        }
        .ignoresSafeArea()
        .padding(.bottom, 40)
    }
}
