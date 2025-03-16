//
//  ClusterAnnotationView.swift
//  TelepathyCompany
//
//  Created by james on 3/3/25.
//

import MapKit

class ClusterAnnotationView: MKAnnotationView {
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var annotation: MKAnnotation? {
        willSet {
            if let cluster = newValue as? MKClusterAnnotation {
                let renderer = UIGraphicsImageRenderer(size: CGSize(width: 40, height: 40))
                let count = cluster.memberAnnotations.count
                
                image = renderer.image { _ in
                    
                    UIColor.white.setFill()
                    UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 40, height: 40)).fill()
                    
                    UIColor.systemOrange.setFill()
                    UIBezierPath(ovalIn: CGRect(x: 1, y: 1, width: 38, height: 38)).fill()

                    let fontSize: CGFloat = 15
                    let attributes = [ NSAttributedString.Key.foregroundColor: UIColor.white,
                                       NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: fontSize)]
                    let text = "\(count)"
                    let textSize = text.size(withAttributes: attributes)
                    let textRect = CGRect(x: 20 - textSize.width / 2,
                                          y: 20 - textSize.height / 2,
                                          width: textSize.width,
                                          height: textSize.height)
                    text.draw(in: textRect, withAttributes: attributes)
                }
                
            }
        }
        didSet {
            let disclosureButton = UIButton(type: .detailDisclosure)
            disclosureButton.tintColor = UIColor.black
            rightCalloutAccessoryView = disclosureButton
        }
    }
        
}
