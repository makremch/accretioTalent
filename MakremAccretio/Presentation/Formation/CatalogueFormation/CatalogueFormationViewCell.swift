//
//  CatalogueFormationViewCell.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 5/12/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import Foundation
import UIKit




class CatalogueFormationViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var viewCell             : UIView!
    @IBOutlet weak var dateLabel            : UILabel!
    @IBOutlet weak var initiatorLabel       : UILabel!
    @IBOutlet weak var themeLabel           : UILabel!
    @IBOutlet weak var formationNameLabel   : UILabel!
    @IBOutlet weak var formationImageView   : UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        viewCell.layer.cornerRadius        = 1
        viewCell.layer.cornerRadius        = 10
        viewCell.backgroundColor           = UIColor.white
        viewCell.layer.shadowColor         = UIColor.systemGray4.cgColor
        viewCell.layer.shadowColor         = UIColor.systemGray4.cgColor
        viewCell.layer.shadowOpacity       = 1
        viewCell.layer.shadowOffset        = .zero
        viewCell.layer.shadowRadius        = 10
        viewCell.layer.shadowPath          = UIBezierPath(rect: viewCell.bounds).cgPath
        viewCell.layer.shouldRasterize     = true
        viewCell.layer.rasterizationScale  = UIScreen.main.scale
        
        formationImageView.roundCorners([.topLeft, .topRight], radius: 10.0)
    }
    
    
//    func addShadowView(width:CGFloat=0, height:CGFloat=1, Opacidade:Float=0.3, maskToBounds:Bool=false, radius:CGFloat=8){
//         self.layer.shadowColor = UIColor.black.cgColor
//         self.layer.shadowOffset = CGSize(width: width, height: height)
//         self.layer.shadowRadius = radius
//         self.layer.cornerRadius = radius
//         self.layer.shadowOpacity = Opacidade
//         self.layer.masksToBounds = maskToBounds
//    }
    
    
    
}
