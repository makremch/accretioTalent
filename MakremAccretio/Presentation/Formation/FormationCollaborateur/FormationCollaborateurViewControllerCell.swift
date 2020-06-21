//
//  FormationCollaborateurViewControllerCell.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 5/12/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import Foundation
import UIKit



class FormationCollaborateurViewControllerCell: UITableViewCell {

    @IBOutlet weak var sessionLabel: UILabel!
    @IBOutlet weak var formationNameLabel: UILabel!
    @IBOutlet weak var initiateurLabel: UILabel!
    @IBOutlet weak var DateDebutLabel: UILabel!
    @IBOutlet weak var FormateurNameLabel: UILabel!
    @IBOutlet weak var DateFinLabel: UILabel!
    @IBOutlet weak var celluleView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addShadowView()
        celluleView.layer.cornerRadius = 10
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
