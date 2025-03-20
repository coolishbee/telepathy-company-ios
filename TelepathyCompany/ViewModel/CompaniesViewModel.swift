//
//  CompaniesViewModel.swift
//  TelepathyCompany
//
//  Created by james on 3/3/25.
//

import SwiftUI
import MapKit
import Combine

class CompaniesViewModel: ObservableObject {
    
    private var subscriptions = Set<AnyCancellable>()
            
    var isRefreshed = false
    var regionTuple: (lati: Double, lng: Double)?
    
    @Published var showMapAlert = false
    @Published var annotiations: [CompanyAnnotation]?
    @Published var isSelectedAnnotation: Bool = false
    @Published var isSelectedAnnotations: Bool = false
    @Published var selectedCompany: Company?
    
    var selectedAnnotation: CompanyAnnotation? {
        didSet {
            self.selectedCompany = self.selectedAnnotation?.company
            isSelectedAnnotation = self.selectedCompany != nil
        }
    }
    
    var selectedAnnotations: [CompanyAnnotation]? {
        didSet {
            if let selectedAnnotations = selectedAnnotations, !selectedAnnotations.isEmpty {
                isSelectedAnnotations = true
            } else {
                isSelectedAnnotations = false
            }
        }
    }
        
    var selectedCompanies: [Company] {
        guard let annotations = self.selectedAnnotations else {
            return []
        }
        var companies: [Company] = []
        for annotation in annotations {
            companies.append(annotation.company)
        }
        return companies
    }
        
    var companies: [Company]? {
        didSet {
            refreshAnnotations()
        }
    }
    
    func requestCompaniesAPI() {
        //network io
        //print("requestCompaniesAPI")
        
        self.isRefreshed = true
        
        NetworkingService.fetchCompanyList()
            .receive(on: DispatchQueue.main)
            .sink { response in
                switch response {
                case .finished:()
                case .failure(let error):
                    print("\(error)")
                }
            } receiveValue: { [weak self] data in
                
                let decoder = JSONDecoder()
                do {
                    let companies = try decoder.decode([Company].self, from: data)
                    self?.companies = companies
                } catch let error {
                    print("decode error: ", error)
                }
                
            }.store(in: &subscriptions)
    }
    
    private func refreshAnnotations() {
        guard let companies = self.companies else {
            self.annotiations = nil
            return
        }
        
        let companyAnnotations = CompanyAnnotation.make(from: companies)
        if !companyAnnotations.isEmpty {
            self.annotiations = companyAnnotations
        } else {
            self.annotiations = nil
        }
    }
    
    //improve
    func select(company: Company) {
        
    }
}
