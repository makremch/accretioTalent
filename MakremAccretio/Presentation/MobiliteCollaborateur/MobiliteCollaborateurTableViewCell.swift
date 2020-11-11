//
//  MobiliteCollaborateurTableViewCell.swift
//  MakremAccretio
//
//  Created by Makrem on 3/5/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import UIKit


class MobiliteCollaborateurTableViewCell : UITableViewCell {

    
    @IBOutlet weak var RegionLabel: UILabel!
    @IBOutlet weak var offreContrat: UILabel!
    @IBOutlet weak var codeCollaborateurLabel: UILabel!
    @IBOutlet weak var offreTitre: UILabel!
    @IBOutlet weak var viewForData: UIView!
    @IBOutlet weak var imase: UIImageView!
    
    func designForView(){
        viewForData.layer.cornerRadius = 15
        viewForData.layer.shadowColor = UIColor.systemGray5.cgColor
        viewForData.layer.shadowOpacity = 1
        viewForData.layer.shadowOffset = .zero
        viewForData.layer.shadowRadius = 10
        viewForData.layer.shadowPath = UIBezierPath(rect: viewForData.bounds).cgPath
        viewForData.layer.shouldRasterize = true
        viewForData.layer.rasterizationScale = UIScreen.main.scale
        
        imase.layer.cornerRadius = 10
//        imase.layer.shadowColor = UIColor.gray.cgColor
//        imase.layer.shadowOpacity = 10
//        imase.layer.shadowOffset = .zero
//        imase.layer.shadowRadius = 15
//        imase.layer.shadowPath = UIBezierPath(rect: imase.bounds).cgPath
//        imase.layer.shouldRasterize = true
//        imase.layer.rasterizationScale = UIScreen.main.scale

               
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        designForView()
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    

}
