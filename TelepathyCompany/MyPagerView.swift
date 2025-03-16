//
//  MyPagerView.swift
//  TelepathyCompany
//
//  Created by james on 2/2/25.
//

import SwiftUI
import ScalingHeaderScrollView

let defaultDescription = """
Lorem ipsum dolor sit amet consectetur adipiscing elit donec, gravida commodo hac non mattis augue duis vitae inceptos, laoreet taciti at vehicula cum arcu dictum. Cras netus vivamus sociis pulvinar est erat, quisque imperdiet velit a justo maecenas, pretium gravida ut himenaeos nam. Tellus quis libero sociis class nec hendrerit, id proin facilisis praesent bibendum vehicula tristique, fringilla augue vitae primis turpis.

Sagittis vivamus sem morbi nam mattis phasellus vehicula facilisis suscipit posuere metus, iaculis vestibulum viverra nisl ullamcorper lectus curabitur himenaeos dictumst malesuada tempor, cras maecenas enim est eu turpis hac sociosqu tellus magnis. Sociosqu varius feugiat volutpat justo fames magna malesuada, viverra neque nibh parturient eu nascetur, cursus sollicitudin placerat lobortis nunc imperdiet. Leo lectus euismod morbi placerat pretium aliquet ultricies metus, augue turpis vulputa
te dictumst mattis egestas laoreet, cubilia habitant magnis lacinia vivamus etiam aenean.

Sagittis vivamus sem morbi nam mattis phasellus vehicula facilisis suscipit posuere metus, iaculis vestibulum viverra nisl ullamcorper lectus curabitur himenaeos dictumst malesuada tempor, cras maecenas enim est eu turpis hac sociosqu tellus magnis. Sociosqu varius feugiat volutpat justo fames magna malesuada, viverra neque nibh parturient eu nascetur, cursus sollicitudin placerat lobortis nunc imperdiet. Leo lectus euismod morbi placerat pretium aliquet ultricies metus, augue turpis vulputa
te dictumst mattis egestas laoreet, cubilia habitant magnis lacinia vivamus etiam aenean.

Sagittis vivamus sem morbi nam mattis phasellus vehicula facilisis suscipit posuere metus, iaculis vestibulum viverra nisl ullamcorper lectus curabitur himenaeos dictumst malesuada tempor, cras maecenas enim est eu turpis hac sociosqu tellus magnis. Sociosqu varius feugiat volutpat justo fames magna malesuada, viverra neque nibh parturient eu nascetur, cursus sollicitudin placerat lobortis nunc imperdiet. Leo lectus euismod morbi placerat pretium aliquet ultricies metus, augue turpis vulputa
te dictumst mattis egestas laoreet, cubilia habitant magnis lacinia vivamus etiam aenean.
"""

struct MyPagerView: View {

    
    @State private var currentIndex = 0
    private let colors: [ImageResource] = [.interpark, .jobplanet, .krafton, .neowiz]
    
    
    let tabs = ["회사 소개", "리뷰", "정보"]
    @State private var selectedTab = 0

    var body: some View {
        
        ZStack(alignment: .topLeading) {
            ScalingHeaderScrollView {
                VStack(spacing: 0){
                    ImagePageView()
                    //customTabBar
                    tabBar
                }
                .padding(.top, -40)
                
            } content: {

                content
            }
            .edgesIgnoringSafeArea(.top)
                        
        }
        
        
    }
    
//    private var tabBar: some View {
//        ZStack{
//            Picker("Tabs", selection: $selectedTab) {
//                ForEach(0..<tabs.count, id: \.self) { index in
//                    Text(tabs[index])
//                        .tag(index)
//                }
//            }
//            .pickerStyle(SegmentedPickerStyle()) // iOS 기본 세그먼트 스타일 적용
//            .padding(.horizontal)
//            .background(Color(.systemBackground)) // 기존 디자인 유지
//            
//        }
//    }
    
    private var tabBar: some View {
        HStack {
            ForEach(0..<tabs.count, id: \.self) { index in
                Text(tabs[index])
                    .foregroundColor(selectedTab == index ? .buttonText : .gray)
                    .fontWeight(selectedTab == index ? .bold : .regular)
                    .padding([.vertical])
                    .frame(maxWidth: .infinity)
                    .overlay(
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(selectedTab == index ? .buttonText : .bg),
                        alignment: .bottom)
                    .onTapGesture {
                        selectedTab = index
                    }
            }
        }
        .padding([.horizontal, .bottom])
        .background(Color(.systemBackground))
    }
    
    private var content: some View {
        ZStack{
            TabView(selection: $selectedTab) {
                ForEach(0..<tabs.count, id: \ .self) { index in
//                    Text(tabs[index])
//                        .font(.largeTitle)
//                        .frame(maxWidth: .infinity, maxHeight: .infinity)
//                        .background(Color.blue.opacity(0.2))
//                        .tag(index)
                    Text(tabs[index] + "\n" + defaultDescription)
                        .padding()
                }
            }
            .edgesIgnoringSafeArea(.all)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            //.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }
}

#Preview {
    MyPagerView()
}


