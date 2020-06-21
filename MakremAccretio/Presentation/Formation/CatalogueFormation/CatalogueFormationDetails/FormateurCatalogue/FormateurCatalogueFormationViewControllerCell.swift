//
//  FormateurCatalogueFormationViewControllerCell.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 5/19/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import Foundation
import UIKit




class FormateurCatalogueFormationViewControllerCell: UITableViewCell {
    
    
    
//    MARK: - UI Declarations  :
    
    @IBOutlet weak var nomPrenomLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var telLabel: UILabel!
    
 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addShadowView()
 
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

