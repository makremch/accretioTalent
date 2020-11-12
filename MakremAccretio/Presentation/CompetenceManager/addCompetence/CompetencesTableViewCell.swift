//
//  CompetenceTableViewCell.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 11/12/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import Foundation
import UIKit


class CompetencesTableViewCell: UITableViewCell{
    
    
//     MARK:- let and variables :
    static var codeSkill : String = ""
    
    //     MARK:- Declaration IBoutlets
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var nomCompetenceLabel: UILabel!
    
    
    //    MARK:- Configuration
    override func awakeFromNib() {
        super.awakeFromNib()
        configuringViewCell()
    }
    
    //    MARK:- cell Configuration:
    func configuringViewCell() {
        viewCell.layer.cornerRadius = 10
        viewCell.backgroundColor = UIColor.white
        viewCell.layer.shadowColor = UIColor.systemGray5.cgColor
        viewCell.layer.shadowColor = UIColor.systemGray5.cgColor
        viewCell.layer.shadowOpacity = 1
        viewCell.layer.shadowOffset = .zero
        viewCell.layer.shadowRadius = 5
        viewCell.layer.shadowPath = UIBezierPath(rect: viewCell.bounds).cgPath
        viewCell.layer.shouldRasterize = true
        viewCell.layer.rasterizationScale = UIScreen.main.scale
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
    
}
