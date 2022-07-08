//
//  FillterTableViewCell.swift
//  All-In
//
//  Created by Marwa on 05/07/2022.
//

import UIKit

class FillterTableViewCell: UITableViewCell{
    var minmumValue: Float = 0.0
    var maxmumValue: Float = 0.0
    
    @IBOutlet weak var toLbl: UILabel!
    @IBOutlet weak var fromLbl: UILabel!
    @IBOutlet weak var sliderPrice: UISlider!
    @IBOutlet weak var fromPriceField: UITextField!
    @IBOutlet weak var toPriceField: UITextField!
    var changePrice: (()->())?
    override func awakeFromNib() {
        super.awakeFromNib()
        print(self.sliderPrice.value)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
     
        
    }
    
    @IBAction func fromPrice(_ sender: Any) {
        
        
    }
    @IBAction func toPrice(_ sender: UITextField) {
   
    }
    @IBAction func sliderPrice(_ sender: UISlider) {
    /*    self.fromPriceField.text = String( self.sliderPrice.value)
        self.minmumValue = self.sliderPrice.value
        print(self.minmumValue)*/
        
        changePrice?()
        
    }
   /* func getting(){
    let filter = FilterViewController()
    filter.minNum = self.minmumValue
    print(filter.minNum)
    filter.saveFilterr(minnum: self.minmumValue, maxnum: 170.0)
    filter.maxNum = self.sliderPrice.maximumValue
        
    }*/
}
