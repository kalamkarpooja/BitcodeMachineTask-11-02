//
//  UserViewController.swift
//  MachineTest-11-2
//
//  Created by Mac on 06/03/23.
//

import UIKit
import SDWebImage
class UserViewController: UIViewController {
    var userDetailVC : UserDetailViewController = UserDetailViewController()
    @IBOutlet weak var usersCollectionView: UICollectionView!
    var urlString : String?
    var url : URL?
    var urlRequest : URLRequest?
    var urlSession : URLSession?
    var users = [User]()
    override func viewDidLoad() {
        super.viewDidLoad()
        jsonDecoder()
        tableView()
    }
    func tableView(){
        usersCollectionView.dataSource = self
        usersCollectionView.delegate = self
        let uinib = UINib(nibName: "UserCollectionViewCell", bundle: nil)
        self.usersCollectionView.register(uinib, forCellWithReuseIdentifier: "UserCollectionViewCell")
    }
    func jsonDecoder(){
        urlString = "https://reqres.in/api/users?page=2"
        url = URL(string: urlString!)
        urlRequest = URLRequest(url: url!)
        urlRequest?.httpMethod = "GET"
        URLSession.shared.dataTask(with: urlRequest!){data,response,error in
            print(String(data: data!, encoding: .utf8)!)
            let getJsonObject = try! JSONSerialization.jsonObject(with: data!) as! [String : Any]
            let jsonObject = getJsonObject["data"] as! [[String : Any]]
            for eachDictionary in jsonObject{
                let userId = eachDictionary["id"] as! Int
                let userFName = eachDictionary["first_name"] as! String
                let userLName = eachDictionary["last_name"] as! String
                let userEmail = eachDictionary["email"] as! String
                let userAvatar = eachDictionary["avatar"] as! String
                let newUserObject = User(id: userId, email: userEmail, first_name: userFName, last_name: userLName, avatar: userAvatar)
                self.users.append(newUserObject)
                DispatchQueue.main.async {
                    self.usersCollectionView.reloadData()
                }
            }
        }.resume()
    }
}
extension UserViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.usersCollectionView.dequeueReusableCell(withReuseIdentifier: "UserCollectionViewCell", for: indexPath) as! UserCollectionViewCell
        cell.fnLabel.text = users[indexPath.row].first_name
        cell.emailLabel.text = users[indexPath.row].email
        let urlString = users[indexPath.row].avatar
        let url = URL(string: urlString)
        cell.img.sd_setImage(with: url)
        cell.layer.borderWidth = 5
        cell.layer.cornerRadius = 15
        cell.backgroundColor = .gray
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 210, height: 300)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        userDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "UserDetailViewController") as! UserDetailViewController
        userDetailVC.user = users[indexPath.row]
        navigationController?.pushViewController(userDetailVC, animated: true)
    }
    
}
