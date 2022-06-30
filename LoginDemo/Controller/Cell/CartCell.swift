//
//  CartCell.swift
//  QuantumDemo1


import UIKit

class CartCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var lblProductCount: UILabel!
    @IBOutlet weak var lblStoreName: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var btnDeleteCart: UIButton!
    @IBOutlet weak var btnCheckOut: UIButton!
    @IBOutlet weak var collectionViewItem: UICollectionView!
    
    var Amount = 0
    var indexFromTable : Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionViewItem.delegate = self
        collectionViewItem.dataSource = self
        bgView.dropShadow()

        self.collectionViewItem.register(UINib(nibName: "ItemCell", bundle: nil), forCellWithReuseIdentifier: "ItemCell")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension CartCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (customData[indexFromTable ?? 0]["products"] as? [[String:Any]])?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        let dict = (customData[indexFromTable ?? 0]["products"] as? [[String:Any]])?[indexPath.row]
        
        if let value = dict?["strikedPrice"] as? String {
            let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: "₹\(value)")
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSRange(location: 0, length: attributeString.length))
            cell.lblDiscountedPrice.attributedText = attributeString
        }
        
        if let value = dict?["price"] as? String {
            cell.lblActualPrice.text = "₹\(value)"
            Amount += Int(value) ?? 0
        }
        
        if let value = dict?["productName"] as? String {
            cell.lblName.text = value
        }
        
        if let value = dict?["quantity"] as? String {
            cell.lblQty.text = value
        }
        
        if let value = dict?["imageName"] as? String {
            cell.imgProduct.image = UIImage(named: value)
        }
        
        lblAmount.text = "₹\(Amount)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 230)
    }
    
}


extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        layer.shadowRadius = 2
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
