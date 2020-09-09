//
//  EvaluatedTableViewCell.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 8/19/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import UIKit

class EvaluatedTableViewCell: UITableViewCell {

//    MARK: IBOutlets
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var formationLabel: UILabel!
    @IBOutlet weak var evaluateurNumberLabel: UILabel!
    @IBOutlet weak var noteGlobaleLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        statusView.layer.cornerRadius = 5
        viewCell.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
