//
//  FillterTableViewCell.swift
//  All-In
//
//  Created by Marwa on 05/07/2022.
//

import UIKit

class FillterTableViewCell: UITableViewCell{

    
    @IBOutlet weak var toLbl: UILabel!
    @IBOutlet weak var fromLbl: UILabel!
    @IBOutlet weak var sliderPrice: UISlider!
    @IBOutlet weak var fromPriceField: UITextField!
    @IBOutlet weak var toPriceField: UITextField!
    var changePrice: (()->())?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func fromPrice(_ sender: Any) {
        
        
    }
    @IBAction func toPrice(_ sender: UITextField) {
   
    }
    @IBAction func sliderPrice(_ sender: UISlider) {
        self.fromPriceField.text = String( self.sliderPrice.value)
        changePrice?()
        
    }
}
