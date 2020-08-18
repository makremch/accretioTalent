//
//  CompetencesCell.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 8/15/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import UIKit

class CompetencesCell: UITableViewCell {
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
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
