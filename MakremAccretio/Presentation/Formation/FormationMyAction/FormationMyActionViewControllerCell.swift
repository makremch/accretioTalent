//
//  FormationMyActionViewControllerCell.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 5/12/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import Foundation
import UIKit


class FormationMyActionViewControllerCell: UITableViewCell {

    
    
    @IBOutlet weak var celluleView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addShadowView()
        celluleView.layer.cornerRadius = 15
        celluleView.backgroundColor = UIColor.systemGray6
    }
    
    func addShadowView(width:CGFloat=0, height:CGFloat=1, Opacidade:Float=0.3, maskToBounds:Bool=false, radius:CGFloat=8){
         self.layer.shadowColor = UIColor.black.cgColor
         self.layer.shadowOffset = CGSize(width: width, height: height)
         self.layer.shadowRadius = radius
         self.layer.cornerRadius = radius
         self.layer.shadowOpacity = Opacidade
         self.layer.masksToBounds = maskToBounds
    }


}
