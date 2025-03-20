//
//  JobListCell.swift
//  TelepathyCompany
//
//  Created by james on 3/19/25.
//

import SwiftUI

struct JobListCell: View {
    let job: Job
    
    var body: some View {
        HStack(spacing: 10) {
            
            VStack(alignment: .leading) {
                Text(job.title)
                    .foregroundColor(Color.hex("#0C0C0C"))
                    .fontBold(size: 20)
                Text("Android | Kotlin | REST API")
                    .foregroundColor(Color.black.opacity(0.4))
                    .fontBold(size: 17)
                Text("상시")
                    .foregroundColor(Color.black.opacity(0.4))
                    .fontBold(size: 17)
            }
            .frame(height: 100)
            
            Spacer()
            
            Button("") {
                print("Like")
            }
            .buttonStyle(CircleButtonStyle(imageName: "heart.fill", foreground: .red))
            
        }
        //.padding(.horizontal, 10)
    }
}
