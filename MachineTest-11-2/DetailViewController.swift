//
//  DetailViewController.swift
//  MachineTest-11-2
//
//  Created by Mac on 06/03/23.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var pricelabel: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var category: UILabel!
    
    var product: Product?
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = String(product!.title)
        idLabel.text = "Id: \(String(product!.id))"
        pricelabel.text = "Price: \(String(product!.price))"
        descLabel.text = String(product!.description)
        ratingLabel.text = "Rating:\(String(product!.rating))"
        category.text = "Category:\(String(product!.category))"
        
        let url = URL(string: product!.thumbnail)
        img.sd_setImage(with: url!)
        img.layer.cornerRadius = 30
        img.layer.borderWidth = 6
    }

}
