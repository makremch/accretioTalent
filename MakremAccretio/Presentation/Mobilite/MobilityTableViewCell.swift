//
//  MobilityTableViewCell.swift
//  MakremAccretio
//
//  Created by Makrem on 2/21/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import UIKit

class MobilityTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var libelleLabel: UILabel!
    @IBOutlet weak var mobiliteViewCell: UIView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLbael: UILabel!
    @IBOutlet weak var dateCreationLabel: UILabel!
    @IBOutlet weak var effectifLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mobiliteViewCell.layer.cornerRadius = 10
        addShadowView()
//        mobiliteViewCell.layer.backgroundColor = (UIColor.blue as! CGColor)
        // Initialization code
    }

    func addShadowView(width:CGFloat=0, height:CGFloat=1, Opacidade:Float=0.3, maskToBounds:Bool=false, radius:CGFloat=8){
         self.layer.shadowColor = UIColor.black.cgColor
         self.layer.shadowOffset = CGSize(width: width, height: height)
         self.layer.shadowRadius = radius
         self.layer.cornerRadius = radius
         self.layer.shadowOpacity = Opacidade
         self.layer.masksToBounds = maskToBounds
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
