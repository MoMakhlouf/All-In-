//
//  Views.swift
//  All-In
//
//  Created by Mohamed Makhlouf Ahmed on 03/07/2022.
//

import Foundation
import UIKit

extension UIImageView{
    
    func makeCircularImage(){
        layer.borderWidth = 1
        layer.masksToBounds = false
        layer.borderColor = UIColor.clear.cgColor
        layer.cornerRadius  = self.frame.height / 2
        clipsToBounds = true
    }
}


extension UIView{
  
    func makeCornerRauisView(){
        let cornerRadius: CGFloat = 15.0

        layer.cornerRadius = cornerRadius
                layer.masksToBounds = false
            layer.shadowColor = UIColor.black.cgColor
                layer.shadowOffset = CGSize(width: 0, height: 5)
      layer.frame.inset(by: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
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
