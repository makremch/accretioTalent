//
//  EvaluationManagerTableViewCell.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 7/22/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import Foundation

import UIKit
class EvaluationManagerTableViewCell: UITableViewCell {
  
    @IBOutlet weak var TitreLabel: UILabel!
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewCell.layer.cornerRadius = 15
        
    }
    
    
    
}
