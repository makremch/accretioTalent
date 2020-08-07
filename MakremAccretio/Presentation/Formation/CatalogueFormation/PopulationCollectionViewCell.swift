//
//  PopulationCollectionViewCell.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 8/4/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import UIKit


protocol PopulationCollectionViewCellDelegate {
    func didChangeSwitchValue(value: Bool, participant: PopulationElement)
}


class PopulationCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var nomParticipant: UILabel!
    @IBOutlet weak var switcherOn: UISwitch!
    @IBOutlet weak var populationLabel: UILabel!
    
    
    var delegate: PopulationCollectionViewCellDelegate?
    var value: Bool =  false
    var participant : PopulationElement?
    static var participants : [PopulationElement] = []
    
    
    
    @IBAction func addRemoveParticipant(_ sender: UISwitch) {
        self.value = sender.isOn
        if value {
            PopulationCollectionViewCell.participants.append(participant!)
            print("added success !")
            print(PopulationCollectionViewCell.participants.count,PopulationCollectionViewCell.participants)
            print("-------------")
        }else{
            print(participant?.registrationNumber as Any)
            PopulationCollectionViewCell.participants = PopulationCollectionViewCell.participants.filter { $0.registrationNumber! != participant?.registrationNumber! }
            print(PopulationCollectionViewCell.participants.count,PopulationCollectionViewCell.participants)
        }
        delegate?.didChangeSwitchValue(value: value, participant: self.participant!)
        
    }
    
    
    
    override func awakeFromNib() {
           super.awakeFromNib()
        viewContent.layer.cornerRadius = 15
       }
    
}
