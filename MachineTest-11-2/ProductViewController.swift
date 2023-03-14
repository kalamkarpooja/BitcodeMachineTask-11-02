//
//  ProductViewController.swift
//  MachineTest-11-2
//
//  Created by Mac on 06/03/23.
//

import UIKit
import SDWebImage
class ProductViewController: UIViewController {
    @IBOutlet weak var productTableView: UITableView!
    var detailVC : DetailViewController = DetailViewController()
    var products = [Product]()
    override func viewDidLoad() {
        super.viewDidLoad()
         jsonParsing()
        tableView()
    }
    func tableView(){
        productTableView.dataSource = self
        productTableView.delegate = self
        let uinib = UINib(nibName: "ProductTableViewCell", bundle: nil)
        self.productTableView.register(uinib, forCellReuseIdentifier: "ProductTableViewCell")
    }
    func jsonParsing(){
        let urlstring = "https://dummyjson.com/products"
        let url = URL(string: urlstring)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        URLSession.shared.dataTask(with: urlRequest){data,response,error in
            print(String(data: data!,encoding: .utf8)!)
            if(error == nil){
                let jsonObject = try! JSONSerialization.jsonObject(with: data!) as! [String : Any]
                let product = jsonObject["products"] as! [[String : Any]]
                for eachProduct in product{
                    let id = eachProduct["id"] as! Int
                    let title = eachProduct["title"] as! String
                    let price = eachProduct["price"] as! Int
                    let rating = eachProduct["rating"] as! Double
                    let brand = eachProduct["brand"] as! String
                    let description = eachProduct["description"] as! String
                    let category = eachProduct["category"] as! String
                    let thumbnail = eachProduct["thumbnail"] as! String
                    let discountPercentage = eachProduct["discountPercentage"] as! Double
                    let images = eachProduct["images"] as! [String]
                    let stock = eachProduct["stock"] as! Int
                    
                    let newProductObject = Product(id:id,title: title,description: description, price: price,discountPercentage:discountPercentage, rating: rating,stock:stock, brand: brand,category: category,thumbnail:thumbnail,images:images)
                    
                    self.products.append(newProductObject)
                }
                DispatchQueue.main.async {
                    self.productTableView.reloadData()
                }
            }
        }.resume()
    }
    
}
extension ProductViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.productTableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as! ProductTableViewCell
        cell.titleLabel.text = products[indexPath.row].title
        cell.priceLabel.text = "Price: \(products[indexPath.row].price)"
        let url = URL(string: products[indexPath.row].thumbnail)
        cell.img.sd_setImage(with: url!)
        cell.layer.borderWidth = 5
        cell.layer.cornerRadius = 20
        cell.layer.borderWidth = 6
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVC.product = products[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }
}
