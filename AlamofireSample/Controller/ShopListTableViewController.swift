//
//  ShopListTableViewController.swift
//  AlamofireSample
//
//  Created by Ebinuma Kenichi on 2017/10/29.
//  Copyright © 2017年 kenichi ebinuma. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class ShopListTableViewController: UITableViewController, UITextFieldDelegate {
  @IBOutlet weak var searchTextField: UITextField!
  
  var shops: [Shop] = []
  var selectedShop: Shop?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    searchTextField.delegate = self
    tableView.register(UINib(nibName: "ShopCell", bundle: nil), forCellReuseIdentifier: "ShopCell")
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return shops.count
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 80
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ShopCell", for: indexPath) as! ShopCell
    let shop = shops[indexPath.row]
    cell.shopDetailLabel.text = shop.name
    if let image_url = shop.imageURL {
      let url = URL(string: image_url)
      cell.shopImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "default_image.png"))
    } else {
      cell.shopImageView.image = UIImage(named: "default_image.png")
    }
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    selectedShop = shops[indexPath.row]
    self.performSegue(withIdentifier: "ShowWebViewSegue", sender: self)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let webViewController = segue.destination as! WebViewController
    webViewController.selectedShop = self.selectedShop
  }
  
  @IBAction func searchButtonTapped(_ sender: Any) {
    let keyword = searchTextField.text!
    getShopData(keyword)
    searchTextField.text = ""
    searchTextField.resignFirstResponder()
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
  func getShopData(_ keyword: String) {
    var keyid: String = ""
    if ProcessInfo.processInfo.environment["keyid"] != nil {
      keyid = ProcessInfo.processInfo.environment["keyid"]!
    } else {
      fatalError("keyid not found")
    }
    
    let params: [String: AnyObject] = [
      "keyid": keyid as AnyObject,
      "format": "json" as AnyObject,
      "name": keyword as AnyObject
    ]
    
    let url = "https://api.gnavi.co.jp/RestSearchAPI/20150630/"
    Alamofire.request(url,parameters: params)
      .responseJSON(completionHandler: { (response) -> Void in
        if let object = response.result.value {
          let shopJSON = JSON(object)["rest"].array
          for shopData in shopJSON! {
            let shop = Shop()
            shop.imageURL = shopData["image_url"]["shop_image1"].string
            shop.url = shopData["url"].string
            shop.name = shopData["name"].string
            self.shops.append(shop)
          }
          self.tableView.reloadData()
        }
    })
  }
}
