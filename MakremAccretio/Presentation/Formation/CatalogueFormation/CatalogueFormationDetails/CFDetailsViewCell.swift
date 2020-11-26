//
//  CFDetailsViewCell.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 23/11/2020.
//  Copyright © 2020 Makrem. All rights reserved.
//

import Foundation
import UIKit



class CFDetailsViewCell: UITableViewCell {
    
    
    @IBOutlet weak var nomFormateurLabel       : UILabel!
    @IBOutlet weak var emailFormateurLabel     : UILabel!
    @IBOutlet weak var telephoneFormateurLabel : UILabel!
    @IBOutlet weak var FormateurCellView       : UIView!
    
    func viewStyle(){
//        FormateurCellView.layer.cornerRadius       = 10
//        FormateurCellView.layer.cornerRadius       = 5
//        FormateurCellView.backgroundColor          = UIColor.white
//        FormateurCellView.layer.shadowColor        = UIColor.systemGray4.cgColor
//        FormateurCellView.layer.shadowColor        = UIColor.systemGray4.cgColor
//        FormateurCellView.layer.shadowOpacity      = 1
//        FormateurCellView.layer.shadowOffset       = .zero
//        FormateurCellView.layer.shadowRadius       = 5
//        FormateurCellView.layer.shadowPath         = UIBezierPath(rect: FormateurCellView.bounds).cgPath
//        FormateurCellView.layer.shouldRasterize    = true
//        FormateurCellView.layer.rasterizationScale = UIScreen.main.scale
//        FormateurCellView.layer.borderWidth        = 1
//        FormateurCellView.layer.borderColor        = UIColor.systemGray5.cgColor
        FormateurCellView.layer.cornerRadius = 8
        FormateurCellView.layer.shadowOffset = CGSize(width: 0, height: 0.2)
        FormateurCellView.layer.shadowRadius = 8
        FormateurCellView.layer.shadowOpacity = 0.3
        FormateurCellView.layer.shadowColor = UIColor.systemGray4.cgColor
        FormateurCellView.layer.shadowPath = UIBezierPath(roundedRect: self.bounds,
                                             byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 8, height:
                                                                                                    8)).cgPath
        FormateurCellView.layer.shouldRasterize = true
        FormateurCellView.layer.rasterizationScale = UIScreen.main.scale
        
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewStyle()
        
    }
    
  
    
}

class ShadowView: UIView {
    
    var setupShadowDone: Bool = false
    
    public func setupShadow() {
        if setupShadowDone { return }
        print("Setup shadow!")
        self.layer.cornerRadius = 8
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.3
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds,
                                             byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 8, height:
                                                                                                    8)).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        
        setupShadowDone = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupShadow()
    }
}
