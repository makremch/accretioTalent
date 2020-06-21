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

protocol CompetenceCollaborateurDisplayLogic: class
{
    func displaySomething(viewModel: CompetenceCollaborateur.Something.ViewModel)
    func getDataCompetences(response: CompetenseResponse,skillsLabel:[String: String])
}

class CompetenceCollaborateurViewController: DemoBaseViewController, CompetenceCollaborateurDisplayLogic, IAxisValueFormatter
{
    var interactor: CompetenceCollaborateurBusinessLogic?
    var router: (NSObjectProtocol & CompetenceCollaborateurRoutingLogic & CompetenceCollaborateurDataPassing)?
    
    // MARK: Object lifecycle
    
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
    
    // MARK: Setup
    
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
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        doSomething()
        let token = UserDefaults.standard.string(forKey: "accessToken")!
        self.interactor?.getCompetence(token: token)
        
        print("xnxx", self.dataValueCompetenceCollaborateur)
        print("----------------------------------------------------")
        
        
        
        
        
        
        
        // Do any additional setup after loading the view.
                self.title = "Radar Chart"
              
                
                chartView.delegate = self
                
                chartView.chartDescription?.enabled = false
                chartView.webLineWidth = 1
                chartView.innerWebLineWidth = 1
                chartView.webColor = .lightGray
                chartView.innerWebColor = .lightGray
                chartView.webAlpha = 1
                
//        let marker = chartView

//                marker.chartView = chartView
//                chartView.marker = marker
//
                let xAxis = chartView.xAxis
                xAxis.labelFont = .systemFont(ofSize: 9, weight: .light)
                xAxis.xOffset = 0
                xAxis.yOffset = 0
                xAxis.valueFormatter = self
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
        //        chartView.legend = l

                self.updateChartData()
                
                chartView.animate(xAxisDuration: 1.4, yAxisDuration: 1.4, easingOption: .easeOutBack)
        settingViewLabel()
    }
    
    // MARK: Do something
    

    
    func doSomething()
    {
        let request = CompetenceCollaborateur.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: CompetenceCollaborateur.Something.ViewModel)
    {
        //nameTextField.text = viewModel.name
    }
    
    

    
    var dataValueCompetenceCollaborateur : [ClassificationDto] = []
    var values : [Double] = [40,21,45,64,32,92]

    func getDataCompetences(response: CompetenseResponse,skillsLabel:[String: String]){
        print("---------------------------")
//        dataValueCompetenceCollaborateur
        let skills :[[Skill]]
        let affectations :[ClassificationDto]
        affectations = response.content![0].affectationSkillByClassificationDTOList.map {($0.skillsLevelClassificationDTO?.crSkillsLevels!) as! ClassificationDto}
        
        skills  = (response.content![0].affectationSkillByClassificationDTOList.map {($0.skills!)})
//        dataValueCompetenceCollaborateur = uniq(dataValueCompetenceCollaborateur)
        
        print("---------------------------", dataValueCompetenceCollaborateur )
        settingSpiderChart()
        var names : [String] = []
        print(response)
        names = skills[0].map  { skillsLabel[$0.codeSkill!]! }
        activities = names
        setChartData()
print(dataValueCompetenceCollaborateur,"aaaaaaaaaa")
    }
    
    
    func settingSpiderChart(){
//        print(dataValueCompetenceCollaborateur.map{($0.value)!})
      
        
    }

    
    @IBOutlet var chartView: RadarChartView!
    
    var activities = ["JAVA22", "Systémes", "QA", "Classification","makrem","kays","loumi"]
       var originalBarBgColor: UIColor!
       var originalBarTintColor: UIColor!
       var originalBarStyle: UIBarStyle!
    
    override func updateChartData() {
           if self.shouldHideData {
               chartView.data = nil
               return
           }
           
           self.setChartData()
       }
       
       func setChartData() {
           let mult: UInt32 = 80
           let min: UInt32 = 20
        
//        nombre competences :
//        print("assssba",dataValueCompetenceCollaborateur)
        let cnt = activities.count
           
        let block: (Int) -> RadarChartDataEntry = { _ in return RadarChartDataEntry(value: Double(0) )}
//           let entries1 = (0..<cnt).map(block)
        let entries1 = values.map { RadarChartDataEntry(value : $0) }
           let entries2 = (0..<cnt).map(block)
           
           let set1 = RadarChartDataSet(entries: entries1)
//           set1.setColor(UIColor(red: 103/255, green: 110/255, blue: 129/255, alpha: 1))
            set1.setColor(UIColor.cyan)
//           set1.fillColor = UIColor(red: 103/255, green: 110/255, blue: 129/255, alpha: 1)
           set1.fillColor = UIColor.cyan
           set1.drawFilledEnabled = true
           set1.fillAlpha = 0.5
           set1.lineWidth = 1
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
    
    
    
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var NameLabel: UILabel!
    
    func settingViewLabel(){
        NameLabel.text! = UserDefaults.standard.string(forKey: "nameOfUser")!
        NameLabel.textColor = UIColor.white
        NameLabel.alpha = 1
        userImage.alpha = 1
        userView.alpha = 0.3
//        userView.isOpaque = false
        userView.layer.cornerRadius = 10
        userImage.layer.cornerRadius = 5
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}






























// MARK: - Chart Config


extension CompetenceCollaborateurViewController {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
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
                                  .foregroundColor : UIColor.gray], range: NSRange(location: 10, length: centerText.length - 10))
        centerText.addAttributes([.font : UIFont(name: "HelveticaNeue-Light", size: 11)!,
                                  .foregroundColor : UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)], range: NSRange(location: centerText.length - 19, length: 19))
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

