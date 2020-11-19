//
//  CompetenceCollaborateurViewController.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 6/2/20.
//  Copyright (c) 2020 Makrem. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import Charts
import Foundation
protocol CompetenceCollaborateurDisplayLogic: class
{
    func displaySomething(viewModel: CompetenceCollaborateur.Something.ViewModel)
    func getDataCompetences(response: CompetenseResponse,skillsLabel:[String: String])
}

class CompetenceCollaborateurViewController: DemoBaseViewController, CompetenceCollaborateurDisplayLogic, IAxisValueFormatter
{
    
    //    MARK:- IBOutlets
    @IBOutlet var chartView: RadarChartView!
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var viewBgBoth: UIView!
    @IBOutlet weak var PosteLabel: UILabel!
    @IBOutlet weak var nextButtonBO: UIButton!
    @IBOutlet weak var precedentButtonBO: UIButton!
    @IBOutlet weak var noDataMessage: UILabel!
    @IBOutlet weak var chartViewBar: HorizontalBarChartView!
    @IBOutlet weak var addCompetenceButton: UIButton!
    
    
    
    //    MARK:- Var & Let
    var interactor: CompetenceCollaborateurBusinessLogic?
    var router: (NSObjectProtocol & CompetenceCollaborateurRoutingLogic & CompetenceCollaborateurDataPassing)?
    var dataValueCompetenceCollaborateur : [ClassificationDto] = []
    var response: CompetenseResponse? = nil
    var skillsLabel:[String: String]? = nil
    var activities : [String] = ["","","","","","","","","","","","","","","","","","","","","","",""]
    var originalBarBgColor: UIColor!
    var originalBarTintColor: UIColor!
    var originalBarStyle: UIBarStyle!
    var radarIndex : Int = 0
    var index = 0
    var managerPoste = ""
    var nameAndLastNameFromManager = ""
    
    //    MARK:- Button Actions
    @IBAction func nextButton(_ sender: Any) {
        radarIndex+=1
        let count = (response?.content![self.index].affectationSkillByClassificationDTOList.count) != nil ? response?.content![self.index].affectationSkillByClassificationDTOList.count : 1
        radarIndex = radarIndex % (count)!
        updateRadar(index: radarIndex)
        chartViewBar.animate(xAxisDuration: 3)
        chartViewBar.animate(yAxisDuration: 6)
    }
    
    @IBAction func previousButton(_ sender: Any) {
        radarIndex-=1
        radarIndex = radarIndex +  (response?.content![self.index].affectationSkillByClassificationDTOList.count)!
        radarIndex = radarIndex % (response?.content![self.index].affectationSkillByClassificationDTOList.count)!
        print(radarIndex)
        updateRadar(index: radarIndex)
        
    }
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func addCompetence(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let addCompVC = storyBoard.instantiateViewController(withIdentifier: "addComp") as! AjouterCompetenceViewController
        self.navigationController?.pushViewController(addCompVC, animated: true)
    }
    
    // MARK:- Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK:- Setup
    private func setup()
    {
        let viewController = self
        let interactor = CompetenceCollaborateurInteractor()
        let presenter = CompetenceCollaborateurPresenter()
        let router = CompetenceCollaborateurRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK:- View lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let token = UserDefaults.standard.string(forKey: "accessToken")!
        doSomething()
        
        noDataMessage.isHidden                     = true
        nextButtonBO.layer.cornerRadius            = 5
        precedentButtonBO.layer.cornerRadius       = 5
        nextButtonBO.layer.cornerCurve             = CALayerCornerCurve.continuous
        
        nextButtonBO.layer.shadowColor             = UIColor.systemGray4.cgColor
        nextButtonBO.layer.shadowColor             = UIColor.systemGray4.cgColor
        nextButtonBO.layer.shadowOpacity           = 1
        nextButtonBO.layer.shadowOffset            = .zero
        nextButtonBO.layer.shadowRadius            = 2
        nextButtonBO.layer.shadowPath              = UIBezierPath(rect: nextButtonBO.bounds).cgPath
        nextButtonBO.layer.shouldRasterize         = true
        nextButtonBO.layer.rasterizationScale      = UIScreen.main.scale
        
        precedentButtonBO.layer.shadowColor        = UIColor.systemGray4.cgColor
        precedentButtonBO.layer.shadowColor        = UIColor.systemGray4.cgColor
        precedentButtonBO.layer.shadowOpacity      = 1
        precedentButtonBO.layer.shadowOffset       = .zero
        precedentButtonBO.layer.shadowRadius       = 2
        precedentButtonBO.layer.shadowPath         = UIBezierPath(rect: precedentButtonBO.bounds).cgPath
        precedentButtonBO.layer.shouldRasterize    = true
        precedentButtonBO.layer.rasterizationScale = UIScreen.main.scale
        
        viewBgBoth.layer.cornerRadius              = 15
        viewBgBoth.backgroundColor                 = UIColor.white
        viewBgBoth.layer.shadowColor               = UIColor.systemGray4.cgColor
        viewBgBoth.layer.shadowColor               = UIColor.systemGray4.cgColor
        viewBgBoth.layer.shadowOpacity             = 1
        viewBgBoth.layer.shadowOffset              = .zero
        viewBgBoth.layer.shadowRadius              = 10
        viewBgBoth.layer.shadowPath                = UIBezierPath(rect: viewBgBoth.bounds).cgPath
        viewBgBoth.layer.shouldRasterize           = true
        viewBgBoth.layer.rasterizationScale        = UIScreen.main.scale
        
        if(self.response == nil) {
            self.interactor?.getCompetence(token: token)
            addCompetenceButton.isHidden  = true
            PosteLabel.text = UserDefaults.standard.string(forKey: "poste")
            NameLabel.text = UserDefaults.standard.string(forKey: "nameOfUser")!
        } else {
            self.updateRadar(index: self.radarIndex)
            print(managerPoste,nameAndLastNameFromManager)
            print("assba")
            PosteLabel.text = managerPoste
            NameLabel.text = nameAndLastNameFromManager
        }
        setChartData(label: "Waiting for data", values: [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])
        // Do any additional setup after loading the view.
        self.title = "Horizontal Bar Char"
        self.options = [.toggleValues,
                        .toggleIcons,
                        .toggleHighlight,
                        .animateX,
                        .animateY,
                        .animateXY,
                        .saveToGallery,
                        .togglePinchZoom,
                        .toggleAutoScaleMinMax,
                        .toggleData,
                        .toggleBarBorders]
        
        self.setup(barLineChartView: chartViewBar)
        
        chartViewBar.delegate                 = self
        chartViewBar.drawBarShadowEnabled     = true
        chartViewBar.drawValueAboveBarEnabled = true
        chartViewBar.maxVisibleCount          = 60
        
        let xAxis                             = chartViewBar.xAxis
        xAxis.labelPosition                   = .bottom
        xAxis.labelFont                       = .systemFont(ofSize: 10)
        xAxis.drawAxisLineEnabled             = false
        xAxis.granularity                     = 10
        
        let leftAxis                          = chartViewBar.leftAxis
        leftAxis.labelFont                    = .systemFont(ofSize: 0)
        leftAxis.drawAxisLineEnabled          = false
        leftAxis.drawGridLinesEnabled         = false
        leftAxis.axisMinimum                  = 0
        
        let rightAxis                         = chartViewBar.rightAxis
        rightAxis.enabled                     = false
        rightAxis.labelFont                   = .systemFont(ofSize: 10)
        rightAxis.drawAxisLineEnabled         = false
        rightAxis.axisMinimum                 = 0
        
        let l = chartViewBar.legend
        l.horizontalAlignment = .left
        l.verticalAlignment = .bottom
        l.orientation = .horizontal
        l.drawInside = false
        l.form = .square
        l.formSize = 8
        l.font = UIFont(name: "Arial Rounded MT Bold", size: 11)!
        l.xEntrySpace = 4
        //        chartView.legend = l
        chartViewBar.fitBars = false
        chartViewBar.animate(yAxisDuration: 1.5)
        self.setChartBarData(values: [0] , labels: ["0"])
        
        //        self.updateChartData()
        settingViewLabel()
    }
    
    func setChartBarData(values : [Double] , labels : [String]   ) {
        let d = values.enumerated().map { BarChartDataEntry(x:Double($0 * 10) , y : $1 ) }
        let set1 = BarChartDataSet(entries: d,label: "")
        set1.drawIconsEnabled = false
        let data = BarChartData(dataSet: set1)
        data.setValueFont(UIFont(name:"Arial Rounded MT Bold", size:10)!)
        let xAxis = chartViewBar.xAxis
        xAxis.valueFormatter = ValueFormatter(chart: chartViewBar,skills: labels)
        chartViewBar.data = data
    }
    
    
    // MARK:- Do something
    func doSomething()
    {
        let request = CompetenceCollaborateur.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: CompetenceCollaborateur.Something.ViewModel)
    {
    }
    
    // MARK:- Update Radar function
    func updateRadar(index : Int){
        let skills :[[Skill]]
        var skillsLevels = [[String: Level]]()
        let affectations :[ClassificationDto]
        let a = self.response
        affectations = (self.response?.content![self.index].affectationSkillByClassificationDTOList.map {($0.skillsLevelClassificationDTO?.crSkillsLevels!)!})!
        skills  = (self.response?.content![self.index].affectationSkillByClassificationDTOList.map {($0.skills!)})!
        if skills.count == 0 {
            chartView.isHidden = true
            chartViewBar.isHidden = true
            nextButtonBO.isHidden = true
            precedentButtonBO.isHidden = true
            noDataMessage.isHidden = false
            return
        }
        let affectationList = self.response?.content![self.index].affectationSkillByClassificationDTOList
        for affectation in  affectationList! {
            print("skilllevelyyyyyy")
            print(skillsLevels)
            var skillsLevel: [String: Level] = [:]
            for level in affectation.skillsLevelClassificationDTO!.crSkillsLevels!.levels!{
                skillsLevel[level.code!] = level
            }
            skillsLevels.append(skillsLevel)
        }
        print(skillsLevels)
        print("---------------------------", dataValueCompetenceCollaborateur )
        var names : [String] = []
        print((response?.content?.count)!)
        print("+++++++++++++++++++++++++++++++++++++")
        names = skills[index].map  {(skillsLabel![$0.codeSkill!])! }
        activities = names.map  { formatName(name: $0) }
        var values_ : [Double] = []
        for skill in skills[index] {
            if skill.skillLevel == nil {
                values_.append(0)
            } else {
                values_.append(Double((skillsLevels[index][skill.skillLevel!]?.value!)!))
            }
        }
        
        let values = scaledValues( values: values_ )
        setChartData(label : (response?.content![self.index].affectationSkillByClassificationDTOList[index].skillsLevelClassificationDTO?.classificationDTO?.value)! , values: values)
        setChartBarData(values: values, labels: names)
        print(values)
        print(names)
    }
    
    func formatName(name : String) ->  String {
        if(name.count < 6) {
            return name
        }
        let words = name.split(separator: " ")
        if (words.count == 1 ) {
            return String(name.prefix(5))
        }
        if (words.count == 2 ) {
            return words.map{ $0.prefix(2) }.joined()
        }
        return words.map{ $0.prefix(1) }.joined()
    }
    
    func scaledValues(values: [Double]) ->  [Double] {
        if values.max()! < 5.0 {
            return values.map { $0 * 25 }
        }
        return values
    }
    
    
    
    //    MARK:- Getting data from API
    func getDataCompetences(response: CompetenseResponse,skillsLabel:[String: String]){
        
        self.response = response
        
        self.skillsLabel = skillsLabel
        
        self.updateRadar(index: self.radarIndex)
        
    }
    
    override func updateChartData() {
        if self.shouldHideData {
            chartView.data = nil
            return
        }
    }
    
    func hideRadar()  {
        chartView.isHidden = true
        chartViewBar.isHidden =  true
    }
    
    func setChartData(label  : String , values : [Double]) {
        
        //        let mult: UInt32 = 80
        //        let min: UInt32 = 20
        print("somme:",activities.count)
        chartView.clear()
        chartView.clearValues()
        chartView.updateConstraints()
        //        let block: (Int) -> RadarChartDataEntry = { _ in return RadarChartDataEntry(value: Double(0) )}
        let entries1 = values.map { RadarChartDataEntry(value : $0) }
        let set1 = RadarChartDataSet(entries: entries1,label: label)
        //           set1.setColor(UIColor(red: 103/255, green: 110/255, blue: 129/255, alpha: 1))
        set1.setColor(UIColor.cyan)
        //           set1.fillColor = UIColor(red: 103/255, green: 110/255, blue: 129/255, alpha: 1)
        set1.fillColor = UIColor.cyan
        set1.drawFilledEnabled = true
        set1.fillAlpha = 0.5
        set1.lineWidth = 1
        set1.drawHighlightCircleEnabled = true
        set1.setDrawHighlightIndicators(false)
        let data = RadarChartData(dataSets: [set1])
        data.setValueFont(.systemFont(ofSize: 18, weight: .bold))
        data.setDrawValues(false)
        data.setValueTextColor(.white)
        self.title = "Radar Chart"
        chartView.delegate = self
        chartView.chartDescription?.enabled = false
        chartView.webLineWidth = 1
        chartView.innerWebLineWidth = 1
        chartView.webColor = .systemGray4
        chartView.innerWebColor = .systemGray4
        chartView.webAlpha = 1
        let l = chartView.legend
        l.horizontalAlignment = .center
        l.verticalAlignment = .top
        l.orientation = .horizontal
        l.drawInside = false
        l.font = .systemFont(ofSize: 10, weight: .bold)
        l.xEntrySpace = 7
        l.yEntrySpace = 5
        l.textColor = .black
        let xAxis = chartView.xAxis
        xAxis.labelFont = .systemFont(ofSize: 9, weight: .bold)
        xAxis.xOffset = 0
        xAxis.yOffset = 0
        xAxis.valueFormatter = self
        xAxis.labelTextColor = .black
        let yAxis = chartView.yAxis
        yAxis.drawLabelsEnabled = false
        yAxis.labelCount = 5
        yAxis.axisMinimum = 0
        yAxis.axisMaximum = 80
        chartView.data = data
        chartView.animate(xAxisDuration: 1.4, yAxisDuration: 1.4, easingOption: .easeOutExpo)
        chartView.isHidden = false
        
        if(values.count == 23) {
            chartView.isHidden = true
        }
        
    }
    
    
    func settingViewLabel(){
        //        NameLabel.text! = UserDefaults.standard.string(forKey: "nameOfUser")! + " " + UserDefaults.standard.string(forKey: "lastNameOfUser")!
        NameLabel.textColor = UIColor.black
        NameLabel.alpha     = 1
        userImage.alpha     = 1
        userView.alpha      = 1
        //        userView.isOpaque = false
        
        userImage.layer.cornerRadius       = 1
        userView.layer.cornerRadius        = 10
        userView.backgroundColor           = UIColor.white
        userView.layer.shadowColor         = UIColor.systemGray4.cgColor
        userView.layer.shadowColor         = UIColor.systemGray4.cgColor
        userView.layer.shadowOpacity       = 1
        userView.layer.shadowOffset        = .zero
        userView.layer.shadowRadius        = 10
        userView.layer.shadowPath          = UIBezierPath(rect: userView.bounds).cgPath
        userView.layer.shouldRasterize     = true
        userView.layer.rasterizationScale  = UIScreen.main.scale
    }
}


// MARK: - Chart Config
extension CompetenceCollaborateurViewController {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        print(activities[Int(value) % activities.count])
        return activities[Int(value) % activities.count]
    }  
}

enum Option {
    case toggleValues
    case toggleIcons
    case toggleHighlight
    case animateX
    case animateY
    case animateXY
    case saveToGallery
    case togglePinchZoom
    case toggleAutoScaleMinMax
    case toggleData
    case toggleBarBorders
    // CandleChart
    case toggleShadowColorSameAsCandle
    case toggleShowCandleBar
    // CombinedChart
    case toggleLineValues
    case toggleBarValues
    case removeDataSet
    // CubicLineSampleFillFormatter
    case toggleFilled
    case toggleCircles
    case toggleCubic
    case toggleHorizontalCubic
    case toggleStepped
    // HalfPieChartController
    case toggleXValues
    case togglePercent
    case toggleHole
    case spin
    case drawCenter
    // RadarChart
    case toggleXLabels
    case toggleYLabels
    case toggleRotate
    case toggleHighlightCircle
    
    var label: String {
        switch self {
        case .toggleValues: return "Toggle Y-Values"
        case .toggleIcons: return "Toggle Icons"
        case .toggleHighlight: return "Toggle Highlight"
        case .animateX: return "Animate X"
        case .animateY: return "Animate Y"
        case .animateXY: return "Animate XY"
        case .saveToGallery: return "Save to Camera Roll"
        case .togglePinchZoom: return "Toggle PinchZoom"
        case .toggleAutoScaleMinMax: return "Toggle auto scale min/max"
        case .toggleData: return "Toggle Data"
        case .toggleBarBorders: return "Toggle Bar Borders"
        // CandleChart
        case .toggleShadowColorSameAsCandle: return "Toggle shadow same color"
        case .toggleShowCandleBar: return "Toggle show candle bar"
        // CombinedChart
        case .toggleLineValues: return "Toggle Line Values"
        case .toggleBarValues: return "Toggle Bar Values"
        case .removeDataSet: return "Remove Random Set"
        // CubicLineSampleFillFormatter
        case .toggleFilled: return "Toggle Filled"
        case .toggleCircles: return "Toggle Circles"
        case .toggleCubic: return "Toggle Cubic"
        case .toggleHorizontalCubic: return "Toggle Horizontal Cubic"
        case .toggleStepped: return "Toggle Stepped"
        // HalfPieChartController
        case .toggleXValues: return "Toggle X-Values"
        case .togglePercent: return "Toggle Percent"
        case .toggleHole: return "Toggle Hole"
        case .spin: return "Spin"
        case .drawCenter: return "Draw CenterText"
        // RadarChart
        case .toggleXLabels: return "Toggle X-Labels"
        case .toggleYLabels: return "Toggle Y-Labels"
        case .toggleRotate: return "Toggle Rotate"
        case .toggleHighlightCircle: return "Toggle highlight circle"
        }
    }
}

class DemoBaseViewController: UIViewController, ChartViewDelegate {
    private var optionsTableView: UITableView? = nil
    let parties = ["Party A", "Party B", "Party C", "Party D", "Party E", "Party F",
                   "Party G", "Party H", "Party I", "Party J", "Party K", "Party L",
                   "Party M", "Party N", "Party O", "Party P", "Party Q", "Party R",
                   "Party S", "Party T", "Party U", "Party V", "Party W", "Party X",
                   "Party Y", "Party Z"]
    
    @IBOutlet weak var optionsButton: UIButton!
    var options: [Option]!
    
    var shouldHideData: Bool = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.initialize()
    }
    
    private func initialize() {
        self.edgesForExtendedLayout = []
    }
    
    func optionTapped(_ option: Option) {}
    
    func handleOption(_ option: Option, forChartView chartView: ChartViewBase) {
        switch option {
        case .toggleValues:
            for set in chartView.data!.dataSets {
                set.drawValuesEnabled = !set.drawValuesEnabled
            }
            chartView.setNeedsDisplay()
            
        case .toggleIcons:
            for set in chartView.data!.dataSets {
                set.drawIconsEnabled = !set.drawIconsEnabled
            }
            chartView.setNeedsDisplay()
            
        case .toggleHighlight:
            chartView.data!.highlightEnabled = !chartView.data!.isHighlightEnabled
            chartView.setNeedsDisplay()
            
        case .animateX:
            chartView.animate(xAxisDuration: 3)
            
        case .animateY:
            chartView.animate(yAxisDuration: 3)
            
        case .animateXY:
            chartView.animate(xAxisDuration: 3, yAxisDuration: 3)
            
        case .saveToGallery:
            UIImageWriteToSavedPhotosAlbum(chartView.getChartImage(transparent: false)!, nil, nil, nil)
            
        case .togglePinchZoom:
            let barLineChart = chartView as! BarLineChartViewBase
            barLineChart.pinchZoomEnabled = !barLineChart.pinchZoomEnabled
            chartView.setNeedsDisplay()
            
        case .toggleAutoScaleMinMax:
            let barLineChart = chartView as! BarLineChartViewBase
            barLineChart.autoScaleMinMaxEnabled = !barLineChart.isAutoScaleMinMaxEnabled
            chartView.notifyDataSetChanged()
            
        case .toggleData:
            shouldHideData = !shouldHideData
            updateChartData()
            
        case .toggleBarBorders:
            for set in chartView.data!.dataSets {
                if let set = set as? BarChartDataSet {
                    set.barBorderWidth = set.barBorderWidth == 1.0 ? 0.0 : 1.0
                }
            }
            chartView.setNeedsDisplay()
        default:
            break
        }
    }
    
    @IBAction func optionsButtonTapped(_ sender: Any) {
        if let optionsTableView = self.optionsTableView {
            optionsTableView.removeFromSuperview()
            self.optionsTableView = nil
            return
        }
        
        let optionsTableView = UITableView()
        optionsTableView.backgroundColor = UIColor(white: 0, alpha: 0.9)
        optionsTableView.delegate = self
        optionsTableView.dataSource = self
        
        optionsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.optionsTableView = optionsTableView
        
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(NSLayoutConstraint(item: optionsTableView,
                                              attribute: .leading,
                                              relatedBy: .equal,
                                              toItem: self.view,
                                              attribute: .leading,
                                              multiplier: 1,
                                              constant: 40))
        
        constraints.append(NSLayoutConstraint(item: optionsTableView,
                                              attribute: .trailing,
                                              relatedBy: .equal,
                                              toItem: sender as! UIView,
                                              attribute: .trailing,
                                              multiplier: 1,
                                              constant: 0))
        
        constraints.append(NSLayoutConstraint(item: optionsTableView,
                                              attribute: .top,
                                              relatedBy: .equal,
                                              toItem: sender,
                                              attribute: .bottom,
                                              multiplier: 1,
                                              constant: 5))
        
        self.view.addSubview(optionsTableView)
        constraints.forEach { $0.isActive = true }
        
        let constraint = NSLayoutConstraint(item: optionsTableView,
                                            attribute: .height,
                                            relatedBy: .equal,
                                            toItem: nil,
                                            attribute: .height,
                                            multiplier: 1,
                                            constant: 220)
        constraint.isActive = true
    }
    
    func updateChartData() {
        fatalError("updateChartData not overridden")
    }
    
    func setup(pieChartView chartView: PieChartView) {
        chartView.usePercentValuesEnabled = true
        chartView.drawSlicesUnderHoleEnabled = false
        chartView.holeRadiusPercent = 0.58
        chartView.transparentCircleRadiusPercent = 0.61
        chartView.chartDescription?.enabled = false
        chartView.setExtraOffsets(left: 5, top: 10, right: 5, bottom: 5)
        
        chartView.drawCenterTextEnabled = true
        
        let paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.alignment = .center
        
        let centerText = NSMutableAttributedString(string: "Charts\nby Daniel Cohen Gindi")
        centerText.setAttributes([.font : UIFont(name: "HelveticaNeue-Light", size: 13)!,
                                  .paragraphStyle : paragraphStyle], range: NSRange(location: 0, length: centerText.length))
        centerText.addAttributes([.font : UIFont(name: "HelveticaNeue-Light", size: 11)!,
                                  .foregroundColor : UIColor.black], range: NSRange(location: 10, length: centerText.length - 10))
        centerText.addAttributes([.font : UIFont(name: "HelveticaNeue-Light", size: 11)!,
                                  .foregroundColor : UIColor(red: 1/255, green: 1/255, blue: 1/255, alpha: 1)], range: NSRange(location: centerText.length - 19, length: 19))
        chartView.centerAttributedText = centerText;
        
        chartView.drawHoleEnabled = true
        chartView.rotationAngle = 0
        chartView.rotationEnabled = true
        chartView.highlightPerTapEnabled = true
        
        let l = chartView.legend
        l.horizontalAlignment = .right
        l.verticalAlignment = .top
        l.orientation = .vertical
        l.drawInside = false
        l.xEntrySpace = 7
        l.yEntrySpace = 0
        l.yOffset = 0
        //        chartView.legend = l
    }
    
    func setup(radarChartView chartView: RadarChartView) {
        chartView.chartDescription?.enabled = false
    }
    
    func setup(barLineChartView chartView: BarLineChartViewBase) {
        chartView.chartDescription?.enabled = false
        
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        chartView.pinchZoomEnabled = false
        
        // ChartYAxis *leftAxis = chartView.leftAxis;
        
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        
        chartView.rightAxis.enabled = false
        
    }
    // TODO: Cannot override from extensions
    //extension DemoBaseViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        NSLog("chartValueSelected");
    }
    
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        NSLog("chartValueNothingSelected");
    }
    
    func chartScaled(_ chartView: ChartViewBase, scaleX: CGFloat, scaleY: CGFloat) {
        
    }
    
    func chartTranslated(_ chartView: ChartViewBase, dX: CGFloat, dY: CGFloat) {
        
    }
}

extension DemoBaseViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if optionsTableView != nil {
            return 1
        }
        
        return 0
    }
    
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if optionsTableView != nil {
            return options.count
        }
        
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if optionsTableView != nil {
            return 40.0;
        }
        
        return 44.0;
    }
    
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
            cell?.backgroundView = nil
            cell?.backgroundColor = .clear
            cell?.textLabel?.textColor = .white
        }
        cell?.textLabel?.text = self.options[indexPath.row].label
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if optionsTableView != nil {
            tableView.deselectRow(at: indexPath, animated: true)
            
            optionsTableView?.removeFromSuperview()
            self.optionsTableView = nil
            
            self.optionTapped(self.options[indexPath.row])
        }
        
    }
}

public class ValueFormatter: NSObject,IAxisValueFormatter {
    weak var chart: BarLineChartViewBase?
    var skills : [String]
    init(chart: BarLineChartViewBase , skills : [String] ) {
        self.chart = chart
        self.skills = skills
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        print(value)
        return skills[Int(value / 10)]
    }
    
}
