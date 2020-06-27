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
    @IBOutlet weak var chartView: RadarChartView!
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var viewLabel: UIView!
    
    //    MARK:- var
    var competence: CompetenceCollab? = nil
    var values : [Double] = []
    var skillsLabel:[String: String]? = nil
    var activities : [String] = []
    var radarIndex : Int = 0
    
//    MARK:- Configuration
     override func awakeFromNib() {
            super.awakeFromNib()
        configuringViewCell()
        configuringViewLabelCollaborateur()
//        chartView.delegate = self
        chartView.chartDescription?.enabled = false
        chartView.webLineWidth = 1
        chartView.innerWebLineWidth = 1
        chartView.webColor = .lightGray
        chartView.innerWebColor = .lightGray
        chartView.webAlpha = 1
        let xAxis = chartView.xAxis
        xAxis.labelFont = .systemFont(ofSize: 9, weight: .light)
        xAxis.xOffset = 0
        xAxis.yOffset = 0
//        xAxis.valueFormatter = self
        xAxis.labelTextColor = .white
        let yAxis = chartView.yAxis
        yAxis.labelFont = .systemFont(ofSize: 9, weight: .light)
        yAxis.labelCount = 5
        yAxis.axisMinimum = 0
        yAxis.axisMaximum = 80
        yAxis.drawLabelsEnabled = false
        let l = chartView.legend
        l.horizontalAlignment = .center
        l.verticalAlignment = .top
        l.orientation = .horizontal
        l.drawInside = false
        l.font = .systemFont(ofSize: 10, weight: .light)
        l.xEntrySpace = 7
        l.yEntrySpace = 5
        l.textColor = .white

        chartView.animate(xAxisDuration: 1.4, yAxisDuration: 1.4, easingOption: .easeOutBack)
//        updateRadar(index: 0)
       
    }

//    MARK:- Configuring cell color and corner radius
    func configuringViewCell() {
        viewCell.layer.cornerRadius = 15
        viewCell.backgroundColor = UIColor.systemGray3
    }
    func configuringViewLabelCollaborateur(){
//        viewLabel.backgroundColor = UIColor.cyan
        viewLabel.layer.cornerRadius = 5
    }
    override func layoutSubviews() {
        self.updateRadar(index: 0)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    
//MARK:- competence
    func updateRadar(index : Int){
           let skills :[[Skill]]
           var skillsLevels = [[String: Level]]()
           let affectations :[ClassificationDto]
        affectations = self.competence!.affectationSkillByClassificationDTOList.map {($0.skillsLevelClassificationDTO?.crSkillsLevels!) as! ClassificationDto} as! [ClassificationDto]
           skills  = (self.competence!.affectationSkillByClassificationDTOList.map {($0.skills!)}) as! [[Skill]]
           let affectationList = self.competence!.affectationSkillByClassificationDTOList
        for affectation in  affectationList {
               print("skilllevelyyyyyy")
               print(skillsLevels)
            
               var skillsLevel: [String: Level] = [:]
               for level in affectation.skillsLevelClassificationDTO!.crSkillsLevels!.levels!{
                   skillsLevel[level.code!] = level
               }
               skillsLevels.append(skillsLevel)
           }
           print(skillsLevels)
           var names : [String] = []
        if skills.isEmpty  || affectations.isEmpty || competence!.affectationSkillByClassificationDTOList.isEmpty {
            return
        }
           names = skills[index].map  { skillsLabel![$0.codeSkill!]! }
           activities = names
           values = skills[index].map{ Double((skillsLevels[index][$0.skillLevel!]?.value!)!) as Double}
        print(values)
        print("******")
           setChartData(label : (competence!.affectationSkillByClassificationDTOList[index].skillsLevelClassificationDTO?.classificationDTO?.value)!)
       }
    
    
    
    
    
    func setChartData(label  : String) {
           let cnt = activities.count
           let block: (Int) -> RadarChartDataEntry = { _ in return RadarChartDataEntry(value: Double(0) )}
           let entries1 = values.map { RadarChartDataEntry(value : $0) }
           let entries2 = (0..<cnt).map(block)
           let set1 = RadarChartDataSet(entries: entries1,label: label)
           //           set1.setColor(UIColor(red: 103/255, green: 110/255, blue: 129/255, alpha: 1))
           set1.setColor(UIColor.cyan)
           //           set1.fillColor = UIColor(red: 103/255, green: 110/255, blue: 129/255, alpha: 1)
           set1.fillColor = UIColor.cyan
           set1.drawFilledEnabled = true
           set1.fillAlpha = 0.5
           set1.lineWidth = 2
           set1.drawHighlightCircleEnabled = true
           set1.setDrawHighlightIndicators(false)
           
           let set2 = RadarChartDataSet(entries: entries2, label: "--")
           set2.setColor(UIColor(red: 121/255, green: 162/255, blue: 175/255, alpha: 1))
           set2.fillColor = UIColor(red: 121/255, green: 162/255, blue: 175/255, alpha: 1)
           set2.drawFilledEnabled = true
           set2.fillAlpha = 0.7
           set2.lineWidth = 2
           set2.drawHighlightCircleEnabled = true
           set2.setDrawHighlightIndicators(false)
           
           let data = RadarChartData(dataSets: [set1])
           data.setValueFont(.systemFont(ofSize: 18, weight: .bold))
           data.setDrawValues(false)
           data.setValueTextColor(.white)
           chartView.data = data
          }
    
    
    @IBAction func nextButton(_ sender: Any) {
        if self.competence!.affectationSkillByClassificationDTOList.isEmpty{
            return
        }
        radarIndex+=1
        radarIndex = radarIndex % (self.competence!.affectationSkillByClassificationDTOList.count)
        updateRadar(index: radarIndex)
    }
    
    
    
    @IBAction func previousButton(_ sender: Any) {
        if self.competence!.affectationSkillByClassificationDTOList.isEmpty{
            return
        }
        radarIndex-=1
        radarIndex = radarIndex +  (self.competence!.affectationSkillByClassificationDTOList.count)
        radarIndex = radarIndex %  (self.competence!.affectationSkillByClassificationDTOList.count)
        print(radarIndex)
        updateRadar(index: radarIndex)
    }
}

