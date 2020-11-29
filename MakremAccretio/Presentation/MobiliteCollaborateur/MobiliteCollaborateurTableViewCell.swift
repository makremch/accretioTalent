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
        viewForData.layer.cornerRadius = 10
        viewForData.layer.shadowColor = UIColor.systemGray5.cgColor
        viewForData.layer.shadowOpacity = 1
        viewForData.layer.shadowOffset = .zero
        viewForData.layer.shadowRadius = 10
        viewForData.layer.shadowPath = UIBezierPath(rect: viewForData.bounds).cgPath
        viewForData.layer.shouldRasterize = true
        viewForData.layer.rasterizationScale = UIScreen.main.scale
        viewForData.backgroundColor = UIColor.white
  
               
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
