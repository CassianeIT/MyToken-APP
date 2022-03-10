//
//  CShape.swift
//  MyTokens
//
//  Created by Curitiba on 08/03/22.
//

import Foundation
import SwiftUI

struct CShape : Shape {
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topRight,.bottomLeft], cornerRadii: CGSize(width: 55, height: 55))
        
        return Path(path.cgPath)
    }
}
