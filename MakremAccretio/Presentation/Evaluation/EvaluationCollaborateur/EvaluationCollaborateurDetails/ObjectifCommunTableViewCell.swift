//
//  ObjectifCommunTableViewCell.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 7/19/20.
//  Copyright © 2020 Makrem. All rights reserved.
//




import UIKit


class ObjectifCommunTableViewCell : UITableViewCell {


    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var labelCard: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewBg.layer.cornerRadius = 15
        viewBg.layer.borderWidth = 1
        
        // Initialization code
    
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    

}
