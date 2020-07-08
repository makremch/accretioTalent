//
//  EvaluationViewControllerCell.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 7/5/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import Foundation
import UIKit

class EvaluationViewControllerCell: UITableViewCell {

//    MARK:- IBOutlets
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var libelleCompagneLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var numberOfEvaluators: UILabel!
    
    func designingcellView(){
        cellView.layer.cornerRadius = 15
        
    }
    
      override func awakeFromNib() {
          super.awakeFromNib()
        self.designingcellView()
          
      }
      

}

