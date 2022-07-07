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
    
    var productPriceArray: Array<String> = []
    var convert: Array<Float> = []
    var productArray = [Product]()
    var delegate2: delegateFilter?
    @IBOutlet weak var filterTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        filterTableView.delegate = self
        filterTableView.dataSource = self
        filterTableView.register(UINib(nibName: "FillterTableViewCell", bundle: nil), forCellReuseIdentifier: "filterCell")
        
        let filterBtn = UIBarButtonItem()
        filterBtn.image = UIImage(systemName: "line.3.horizontal.decrease")
        filterBtn.action = #selector(saveFilter)
        filterBtn.target = self
        navigationItem.rightBarButtonItem = filterBtn
        
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
    
}

extension FilterViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = filterTableView.dequeueReusableCell(withIdentifier: "filterCell", for: indexPath) as! FillterTableViewCell
        switch(indexPath.section){
        case 0:
            cell.fromPriceField.text = String(convert.min()!)
            cell.toPriceField.text = String(convert.max()!)
            cell.sliderPrice.maximumValue = convert.max()!
            cell.sliderPrice.minimumValue = convert.min()!
            return cell
        default: break
            
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch(section){
            case 1:
                return "Best Seller"
            default:
                return "Price"
        }
   
    }
    
}

extension FilterViewController{
    func saveFilterr(minnum: Float, maxnum: Float){
        self.minNum = minnum
        self.maxNum = maxnum
    }
    
    @objc func saveFilter(_ sender: UIButton){
        let cell = filterTableView.dequeueReusableCell(withIdentifier: "filterCell") as! FillterTableViewCell
//let minVlaue = self.minNum
     //   let maxValue = self.maxNum
        if let d = delegate2{
            d.filterPrice(minn: Float(minVlaue) , maxx: 170.0)
        }
        navigationController?.popViewController(animated: true)
    }
}
