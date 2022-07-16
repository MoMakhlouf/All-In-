//
//  FilterViewController.swift
//  All-In
//
//  Created by Marwa on 05/07/2022.
//

import UIKit

class FilterViewController: UIViewController {
    var minNum: Float = 0.0
    var maxNum: Float = 0.0
    var lastValue: Float = 0.0
    
    var productPriceArray: Array<String> = []
    var convert: Array<Float> = []
    var productArray = [Product]()
    var productType = [String]()
    var delegate2: delegateFilter?
    @IBOutlet weak var filterTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        filterTableView.delegate = self
        filterTableView.dataSource = self
        filterTableView.register(UINib(nibName: "FillterTableViewCell", bundle: nil), forCellReuseIdentifier: "filterCell")
        
        filterTableView.register(UINib(nibName: "ProductTypeTableViewCell", bundle: nil), forCellReuseIdentifier: "productType")
        
        let filterBtn = UIBarButtonItem()
        filterBtn.image = UIImage(systemName: "line.3.horizontal.decrease")
        filterBtn.action = #selector(saveFilter)
        filterBtn.target = self
        navigationItem.rightBarButtonItem = filterBtn
        
        for product in productArray{
            if (!productType.contains(product.product_type)){
                productType.append(product.product_type)
            }
        }
    }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FilterViewController: UITableViewDelegate{
  /*  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
     /*   var height:CGFloat = CGFloat()
        if indexPath.section == 0{
            if indexPath.row == 0{
                height = 200
            }
        }
        else{
            height = 100
        }*/
        return 200.0
    }*/
    
}

extension FilterViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      /*  switch(section){
        case 0:
            return 1
        case 1:
            return productType.count
        default:
            break
        }*/
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = filterTableView.dequeueReusableCell(withIdentifier: "filterCell", for: indexPath) as! FillterTableViewCell
   
        switch(indexPath.section){
        case 0:
            cell.fromLbl.text = String(convert.min()! * 20)
            cell.toLbl.text = String(convert.max()! * 20)
            cell.sliderPrice.maximumValue = convert.max()! * 20
            cell.sliderPrice.minimumValue = convert.min()! * 20
            if lastValue != 0.0{
            cell.sliderPrice.value = lastValue
            cell.fromLbl.text = String(lastValue)
            }
            cell.changePrice = { [weak self] in
                guard let self = self else {return}
                self.minNum = cell.sliderPrice.value
               
            }
            return cell
      /*  case 1:
            let cell1 = filterTableView.dequeueReusableCell(withIdentifier: "productType", for: indexPath) as! ProductTypeTableViewCell
            cell1.productTypeName.text = productType[indexPath.row]
         /*   cell1.productType = { [weak self] in
                guard let self = self else {return}
                cell1.checkMarkBtn(UITableViewCell.AccessoryType.checkmark)
            }*/
            cell1.accessoryType = UITableViewCell.AccessoryType.checkmark
            return cell1*/
        default: break
            
        }
        
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch(section){
          /*  case 1:
                return "Product Type"*/
            default:
                return "Price"
        }
   
    }
    
}

extension FilterViewController{
    @objc func saveFilter(_ sender: UIButton){
        if let d = delegate2{
            d.filterPrice(minn: minNum , maxx: convert.max()! * 20)
        }
        navigationController?.popViewController(animated: true)
    }
}
