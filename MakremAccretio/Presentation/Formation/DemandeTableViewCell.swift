//
//  DemandeTableViewCell.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 5/8/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import UIKit


class DemandeTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var MesDemandesView         : UIView!
    @IBOutlet weak var formationLabel          : UILabel!
    @IBOutlet weak var statusView              : UIView!
    @IBOutlet weak var initiateurLabel         : UILabel!
    @IBOutlet weak var dateLabel               : UILabel!
    @IBOutlet weak var nombreParticipantsLabel : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addShadowView()
        
        
    }
    
    func addShadowView(){
        MesDemandesView.layer.cornerRadius = 10
        MesDemandesView.layer.shadowColor = UIColor.systemGray5.cgColor
        MesDemandesView.layer.shadowOpacity = 1
        MesDemandesView.layer.shadowOffset = .zero
        MesDemandesView.layer.shadowRadius = 10
        MesDemandesView.layer.shadowPath = UIBezierPath(rect: MesDemandesView.bounds).cgPath
        MesDemandesView.layer.shouldRasterize = true
        MesDemandesView.layer.rasterizationScale = UIScreen.main.scale
        statusView.roundCorners([.bottomRight, .topRight], radius: 10.0)
        
    }
   
}


extension UIView {

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         self.layer.mask = mask
    }

}
