//
//  Views.swift
//  SportsApp
//
//  Created by Mohamed Makhlouf Ahmed on 23/06/2022.
//

import Foundation
import UIKit

extension UIImageView{
    
    func makeCircular(){
        layer.borderWidth = 1
        layer.masksToBounds = false
        layer.borderColor = UIColor.clear.cgColor
        layer.cornerRadius  = self.frame.height / 2
        clipsToBounds = true
    }
}


extension UIView{
  
    func make(){
        let cornerRadius: CGFloat = 15.0

        layer.cornerRadius = cornerRadius
                layer.masksToBounds = false
            layer.shadowColor = UIColor.black.cgColor
                layer.shadowOffset = CGSize(width: 0, height: 5)
      layer.frame.inset(by: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
    }
}


extension UIView{
    func makeCorner(){
        let cornerRadius: CGFloat = 7.0
        layer.cornerRadius = cornerRadius
                layer.masksToBounds = false
    }
}

extension UIImageView{
    func makeImageCorner(){
        layer.borderWidth = 1
        layer.masksToBounds = false
        layer.borderColor = UIColor.clear.cgColor
        layer.cornerRadius  = 7
        clipsToBounds = true

    }
    
  
    
    
    
}
