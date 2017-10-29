//
//  ShopCell.swift
//  AlamofireSample
//
//  Created by Ebinuma Kenichi on 2017/10/29.
//  Copyright © 2017年 kenichi ebinuma. All rights reserved.
//

import UIKit

class ShopCell: UITableViewCell {
  @IBOutlet weak var shopImageView: UIImageView!
  @IBOutlet weak var shopDetailLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
}
