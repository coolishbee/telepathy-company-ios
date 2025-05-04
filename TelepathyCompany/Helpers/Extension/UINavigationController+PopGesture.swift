//
//  UINavigationController+PopGesture.swift
//  TelepathyCompany
//
//  Created by james on 3/22/25.
//

import UIKit

extension UINavigationController : @retroactive UINavigationControllerDelegate, @retroactive UIGestureRecognizerDelegate {
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
            return viewControllers.count > 1
    }

}
