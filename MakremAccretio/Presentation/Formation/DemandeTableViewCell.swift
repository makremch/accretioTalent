//
//  DemandeTableViewCell.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 5/8/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import UIKit


class DemandeTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var NomFormationLabel: UILabel!
    @IBOutlet weak var InitiateurLabel: UILabel!
    @IBOutlet weak var nbreParticipantsLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dateCreationLabel: UILabel!
    @IBOutlet weak var cellViewDecoration: UIView!
    @IBOutlet weak var statusView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addShadowView()
        cellViewDecoration.layer.cornerRadius = 15
        cellViewDecoration.backgroundColor = UIColor.systemGray5
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
