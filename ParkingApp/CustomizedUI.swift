//
//  CustomizedUI.swift
//  ParkingApp
//
//  Created by Rhulani Ndhlovu on 2021/01/24.
//

import Foundation
import UIKit

class CustomizeUI {
    
    func cornerRadius(for layer: CALayer, with radius: Int, on side: Side) {
        layer.cornerRadius = CGFloat(radius)
        
        switch side {
        case .rightSide:
            layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMaxYCorner]
        
        case .leftSide:
            layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMaxYCorner]
            
        case .allSides:
            layer.maskedCorners = [ .layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner ]
        }
        
    }
    
    func shadow(for layer: CALayer, with opacity: Float, with radius: Int) {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = .zero
        layer.shadowRadius = CGFloat(radius)
        
        layer.shadowPath = UIBezierPath(rect: layer.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}
