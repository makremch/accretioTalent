//
//  MenuCollection.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 8/15/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import UIKit

class MenuCollection: UICollectionViewCell {

       @IBOutlet weak var lblTitle: UILabel!
       @IBOutlet weak var cntView: UIView!
       @IBOutlet weak var imgvWalkthrough: UIImageView!
       
       override func awakeFromNib() {
           super.awakeFromNib()
        cntView.layer.cornerRadius = 10
          
       }


}
