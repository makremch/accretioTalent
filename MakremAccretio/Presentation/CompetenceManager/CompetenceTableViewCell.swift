//
//  CompetenceTableViewCell.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 6/25/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import UIKit
import Charts

class CompetenceTableViewCell: UITableViewCell{
    
    //    MARK:- IBOutlets
    @IBOutlet weak var CollaborateurNameLabel: UILabel!
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var viewLabel: UIView!
    
    //    MARK:- var
    var competence: CompetenceCollab? = nil
    var values : [Double] = [10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    var skillsLabel:[String: String]? = nil
    var activities : [String] = ["ss","","","","","","","","","","","","","","","","","","","","","",""]
    var radarIndex : Int = 0
    
    //    MARK:- Configuration
    override func awakeFromNib() {
        super.awakeFromNib()
        configuringViewCell()
        configuringViewLabelCollaborateur()
        
        //        chartView.delegate = self
        
        
    }
    
    //    MARK:- Configuring cell color and corner radius
    func configuringViewCell() {
        viewCell.layer.cornerRadius = 15
        viewCell.backgroundColor = UIColor.systemGray3
    }
    func configuringViewLabelCollaborateur(){
        //        viewLabel.backgroundColor = UIColor.cyan
        
    }
    override func layoutSubviews() {
//        updateRadar(index: 0)

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
    
    

