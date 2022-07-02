//
//  Alert.swift
//  All-In
//
//  Created by Mohamed Makhlouf Ahmed on 03/07/2022.
//

import Foundation
import UIKit

class Alert {

    static func displayAlert(title: String, message: String) {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.lightGray
        //alert.view.tintColor = UIColor(hex: 0x1C1A26)
      //  self.present(alert, animated: true, completion: nil)

        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else {
            fatalError("keyWindow has no rootViewController")
            return
        }

        viewController.present(alert, animated: true, completion: nil)
    }

}
