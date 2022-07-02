//
//  Alert.swift
//  SportsApp
//
//  Created by Mohamed Makhlouf Ahmed on 23/06/2022.
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



//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if segue.identifier == "detailsSegue"{
//            let detailsVc = segue.destination as? LeaguesViewController
//            detailsVc?.leagueImage = leagues[tableView.indexPathForSelectedRow!.row].strBadge ?? ""
//            detailsVc?.leagueName = leagues[tableView.indexPathForSelectedRow!.row].strLeague
//            detailsVc?.leagueID = leaguesArray[tableView.indexPathForSelectedRow!.row].idLeague
//            print("aaaa\(leaguesArray[tableView.indexPathForSelectedRow!.row].idLeague)")
//
//        }
//    }


//cell.favoriteName.text = leagues[indexPath.row].leagueName
//        cell.favoriteImage.sd_setImage(with: URL(string: leagues[indexPath.row].leagueImage!), placeholderImage: UIImage(named: "sportsCorener"))
