//
//  TimeGoVC.swift
//  Marshmallow_iOS
//
//  Created by Yunjae Kim on 2020/11/22.
//

import UIKit
import SnapKit


class TimeGoVC: UIViewController {
    //MARK:- IBOutlets
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var circleContainView: UIView!
    
    @IBOutlet weak var wholeCV: UICollectionView!
    
    
    //MARK:- User Define Variables
    
    
    var timer = Timer()
    static var endTimeString = "2020-11-22 05:00:00"
    static var startTimeString = "yyyy-MM-dd HH:mm:ss"
    
    static var endTime : Date?
    static var startTime : Date?
    
    var circularView = CircularProgressView()
    
    
    
    
    
    //MARK:- LifeCycle Methods
    

    override func viewDidLoad() {
        super.viewDidLoad()
        wholeCV.dataSource = self
        wholeCV.delegate = self
        
        setItems()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        
    }

 
    
    
    //MARK:- User Define Functions
    
    func setItems(){
        titleLabel.text = "오후 7시 축구 경기"
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        TimeGoVC.endTime = formatter.date(from: TimeGoVC.endTimeString)
        TimeGoVC.startTime = date
        TimeGoVC.startTimeString = formatter.string(from: date)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeLimit), userInfo: nil, repeats: true)
       
        circularView.progressAnimation(duration: 20)
        circleContainView.addSubview(circularView)
        circularView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            
            
        }
        
        
    }
    
    @objc func timeLimit(){
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        
        
        let calendar = Calendar.current
        let diff = calendar.dateComponents([.second], from: date, to: TimeGoVC.endTime!)
        
        let totalSec = diff.second!
        
        let hour = totalSec/3600
        let min = (totalSec/60)%60
        let sec = totalSec%60
        
        let hourStr = hour < 10 ? "0"+String(hour) : String(hour)
        let minStr = min < 10 ? "0"+String(min) : String(min)
        let secStr = sec<10 ? "0"+String(sec) : String(sec)
        
        
        self.timeLabel.text = hourStr+":"+minStr+":"+secStr
        
        
        
    }
    
    
    
    
    
    

}






extension TimeGoVC : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
}

extension TimeGoVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item < 1{
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: TimeGoWholeCVC.identifier,
                    for: indexPath) as? TimeGoWholeCVC else {
                
                return UICollectionViewCell()}
            
            
            return cell
            
        }
        else{
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: TimeGoUnderCVC.identifier,
                    for: indexPath) as? TimeGoUnderCVC else {
                
                return UICollectionViewCell()}
            
            
            return cell
            
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "reusableTimeGoUsers", for: indexPath)
            return headerView
        default:
            assert(false,"")
            
        }
        
        
    }
    
    
    
    
}

extension TimeGoVC : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item < 1 {
            return CGSize(width: collectionView.frame.width , height: 100)
        }
        else{
            return CGSize(width: collectionView.frame.width , height: 800)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    //    UIEdgeInset
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
        
    }
    
    

    
}
