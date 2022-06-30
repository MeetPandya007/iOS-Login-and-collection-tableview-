//
//  ViewController.swift
//  QuantumDemo1

import UIKit

var customData = [["storeName" : "Cloths", "products" : [["imageName" : "12", "productName" : "Jeans", "strikedPrice" : "200", "price" : "100", "quantity" : "1"], ["imageName" : "12", "productName" : "Shirt", "strikedPrice" : "250", "price" : "150", "quantity" : "2"], ["imageName" : "13", "productName" : "Tshirt", "strikedPrice" : "300", "price" : "130", "quantity" : "1"]]], ["storeName" : "Fruits", "products" : [["imageName" : "13", "productName" : "Kiwi", "strikedPrice" : "220", "price" : "120", "quantity" : "1 KG"], ["imageName" : "12", "productName" : "Grapes", "strikedPrice" : "230", "price" : "140", "quantity" : "3 KG"], ["imageName" : "13", "productName" : "Apple", "strikedPrice" : "360", "price" : "170", "quantity" : "2 KG"]]]]

class CartViewController: UIViewController {

    
    @IBOutlet weak var tblCart: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
        tblCart.register(UINib(nibName: "CartCell", bundle: nil), forCellReuseIdentifier: "CartCell")
        tblCart.estimatedRowHeight = UITableView.automaticDimension
        tblCart.separatorStyle = .none
    }


}

extension CartViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as! CartCell
        cell.selectionStyle = .none
        cell.lblProductCount.text = "(\((customData[indexPath.row]["products"] as? [[String:Any]])?.count ?? 0)) Products"
        
        let attributedString = NSMutableAttributedString.init(string: customData[indexPath.row]["storeName"] as? String ?? "")
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range:
            NSRange.init(location: 0, length: attributedString.length));
        cell.lblStoreName.attributedText = attributedString
        cell.lblAmount.text = "Amount"
        cell.indexFromTable = indexPath.row
        
        cell.collectionViewItem.reloadData()
        
        return cell
    }
    
    @IBAction func btnBack(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "loggedIn")
        UserDefaults.standard.synchronize()
        self.navigationController?.popViewController(animated: true)
    }
}

