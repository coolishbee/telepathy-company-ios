//
//  HomeView.swift
//  TelepathyCompany
//
//  Created by james on 3/25/25.
//

import SwiftUI

struct HomeView: View {
    let categories = [
        ("기업정보", "building.2.fill"),
        ("채용공고", "doc.plaintext"),
        ("개발자 포지션", "desktopcomputer"),
        ("디자이너 포지션", "paintbrush"),
        ("마케터 포지션", "megaphone")
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                
                // 집 유형 선택 버튼
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                    ForEach(categories, id: \.0) { category in
                        Button(action: {}) {
                            VStack {
                                Image(systemName: category.1)
                                    .font(.largeTitle)
                                    .foregroundColor(.blue)
                                Text(category.0)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                            }
                            .frame(maxWidth: .infinity, minHeight: 80)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                        }
                    }
                }
                .padding(.horizontal)
                
                // 직방에 집 내놓기 배너
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.orange)
                        .font(.title)
                    VStack(alignment: .leading) {
                        Text("직방에 집 내놓기")
                            .font(.headline)
                        Text("매매, 전세, 월세 관계없이 쉽고 빠르게")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
                .padding()
                .background(Color.orange.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal)
                
                // 부동산 최신 동향
                Text("부동산 최신 동향")
                    .font(.headline)
                    .padding(.horizontal)
                
                LazyVStack(spacing: 10) {
                    HStack {
                        Text("2월 서울 국평아파트 평균 14억3,895만원에 거래")
                        Spacer()
                        Text("25.3.17")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text("2025년 서울 아파트 거래 46%, 종전 최고가의 9...")
                        Spacer()
                        Text("25.3.10")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.horizontal)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    print("새로고침 버튼 탭됨")
                }) {
                    Image(systemName: "arrow.clockwise")
                }
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    print("메뉴 버튼 탭됨")
                }) {
                    Image(systemName: "line.3.horizontal")
                }
            }
        }
    }
    
}

#Preview {
    NavigationView{
        HomeView()
    }
}
