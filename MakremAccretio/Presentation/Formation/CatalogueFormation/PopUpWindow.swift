//
//  PopUpWindow.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 5/13/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import UIKit
import DropDown



protocol PopUpDelegate{
    func handleDismissAll()
}
class PopUpWindow: UIView, UIPickerViewDataSource, UIPickerViewDelegate {
 

    var delegate : PopUpDelegate?
    let importanceData = ["Importance de la formation","Q1","Q2","Q3","Q4"]
    
    //        MARK: - elements Declarations:
    
    
    fileprivate let titleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Nouvelle Demande"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.shadowColor = UIColor.black
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Arial Rounded MT Bold", size: 30)
        return titleLabel
    }()
    
    fileprivate let formationEditText : UITextField = {
       let formationEditText = UITextField()
        formationEditText.placeholder = "Titre Formation"
        formationEditText.layer.cornerRadius = 5
        formationEditText.translatesAutoresizingMaskIntoConstraints = false
        formationEditText.borderStyle = UITextField.BorderStyle.roundedRect
        formationEditText.autocorrectionType = UITextAutocorrectionType.no
        formationEditText.keyboardType = UIKeyboardType.default
        formationEditText.returnKeyType = UIReturnKeyType.done
        formationEditText.clearButtonMode = UITextField.ViewMode.whileEditing
        formationEditText.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return formationEditText
    }()
    
    fileprivate let formationDescriptionEditText : UITextField = {
       let formationDescriptionEditText = UITextField()
        formationDescriptionEditText.placeholder = "Description"
        formationDescriptionEditText.layer.cornerRadius = 5
        formationDescriptionEditText.translatesAutoresizingMaskIntoConstraints = false
        formationDescriptionEditText.borderStyle = UITextField.BorderStyle.roundedRect
        formationDescriptionEditText.autocorrectionType = UITextAutocorrectionType.no
        formationDescriptionEditText.keyboardType = UIKeyboardType.default
        formationDescriptionEditText.returnKeyType = UIReturnKeyType.done
        formationDescriptionEditText.clearButtonMode = UITextField.ViewMode.whileEditing
        formationDescriptionEditText.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return formationDescriptionEditText
    }()
    
    fileprivate let buttonValider: UIButton = {
        let buttonValider = UIButton()
        buttonValider.backgroundColor = UIColor.blue
        buttonValider.setTitle("  Annuler  ", for: .normal)
        buttonValider.setTitleColor(.white, for: .normal)
        buttonValider.addTarget(self, action: #selector(handleDismissAll), for: .touchUpInside)
        buttonValider.translatesAutoresizingMaskIntoConstraints = false
        buttonValider.layer.cornerRadius = 5
        return buttonValider
    }()
    fileprivate let buttonDismiss: UIButton = {
        let buttonDismiss = UIButton()
        buttonDismiss.backgroundColor = UIColor.cyan
        buttonDismiss.setTitle("  Sauvgarder  ", for: .normal)
        buttonDismiss.setTitleColor(.black, for: .normal)
        buttonDismiss.addTarget(self, action: #selector(handleDismissAll), for: .touchUpInside)
        buttonDismiss.translatesAutoresizingMaskIntoConstraints = false
        buttonDismiss.layer.cornerRadius = 5
        return buttonDismiss
    }()

    
    fileprivate let dropDown : UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        
        return picker
    }()
    
    
    
//    MARK: - init
    override init(frame: CGRect) {
        super.init(frame:frame)
        backgroundColor = .white
        
        //        MARK: - Adding elements to view :
        addSubview(buttonValider)
        addSubview(buttonDismiss)
        addSubview(formationEditText)
        addSubview(titleLabel)
        addSubview(formationDescriptionEditText)
        addSubview(dropDown)
        
        
        //        MARK: - Button dismiss :
        buttonDismiss.addTarget(self, action: #selector(handleDismissAll), for: .touchUpInside)
        buttonDismiss.topAnchor.constraint(equalTo: buttonDismiss.topAnchor).isActive = true
        buttonDismiss.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true
        buttonDismiss.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
        buttonDismiss.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
        buttonDismiss.alpha = 1
        buttonDismiss.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        //        MARK: - button valider :
        buttonValider.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
        buttonValider.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
        buttonValider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -60).isActive = true
        buttonValider.topAnchor.constraint(equalTo: buttonValider.topAnchor).isActive = true
        buttonValider.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        //        MARK: - Formation edit text :
        formationEditText.topAnchor.constraint(equalTo: formationEditText.topAnchor).isActive = true
        formationEditText.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -300).isActive = true
        formationEditText.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
        formationEditText.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
        formationEditText.alpha = 1
        formationEditText.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
//        MARK: - Label title :
//        titleLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -430).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
        titleLabel.alpha = 1
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // MARK: - Description text for formation:
        formationDescriptionEditText.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -260).isActive = true
        formationDescriptionEditText.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
        formationDescriptionEditText.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
        formationDescriptionEditText.alpha = 1
        formationDescriptionEditText.heightAnchor.constraint(equalToConstant: 30).isActive = true
        formationDescriptionEditText.topAnchor.constraint(equalTo: formationDescriptionEditText.topAnchor).isActive = true
        
        
//        MARK: - Importance de la formation picker:
        dropDown.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -200).isActive = true
        dropDown.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        dropDown.rightAnchor.constraint(equalTo: rightAnchor, constant: 20).isActive = true
        dropDown.alpha = 1
        dropDown.heightAnchor.constraint(equalToConstant: 70).isActive = true
        dropDown.topAnchor.constraint(equalTo: dropDown.topAnchor).isActive = true
        dropDown.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        dropDown.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        dropDown.bottomAnchor.constraint(equalTo:  safeAreaLayoutGuide.bottomAnchor).isActive = true
        dropDown.frame = CGRect(x: 12, y: 12, width: 900, height: 900)
        dropDown.delegate = self
        dropDown.dataSource = self
    }
    
    
//    MARK: - Picker importance functions  :
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
     }
     
     func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return importanceData.count
     }
     
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return importanceData[row]
    }
    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        let selectedRow = importanceData[row]
//
//    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func handleDismissAll(){
          delegate?.handleDismissAll()
      }
    
    
    
   
}

