//
//  TimeGoVC.swift
//  Marshmallow_iOS
//
//  Created by Yunjae Kim on 2020/11/22.
//

import UIKit
import SnapKit
import Then


class TimeGoVC: UIViewController {
    //MARK:- IBOutlets
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var circleContainView: UIView!
    
    @IBOutlet weak var titleContainView: UIView!
    @IBOutlet weak var wholeCV: UICollectionView!
    
    
    //MARK:- User Define Variables
    
    
    var timer = Timer()
    static var endTimeString = "2020-11-22 07:00:00"
    static var startTimeString = "2020-11-22 03:53:40"
    
    static var endTime : Date?
    static var startTime : Date?
    static var participants : [String] = []
    
    var circularView = CircularProgressView()
    
    var popUpView = UIView().then{
        $0.makeRounded(cornerRadius: 16)
        $0.backgroundColor = .white
        
        
        
    }
    var blurView = UIView().then{
        $0.backgroundColor = .black
        $0.alpha = 0.8
    }
    
    var candyView = UIImageView().then{
        $0.image = UIImage(named: "resultIcCandy")
        
    }
    var timeOutLabel = UILabel().then{
        $0.numberOfLines = 0
        $0.text = "시간이 종료되었어요!\n누가 마시멜로를 꾹 참았을까요?"
        $0.font = UIFont(name: "", size: 16.0)
        
        $0.textAlignment = .center
        
        
    }
    
    
    var okayButton = UIButton().then{
        $0.backgroundColor = .mypink
        $0.setTitle("확인", for: .normal)
        $0.addTarget(self, action: #selector(touchupOkayButton), for: .touchUpInside)
        
        
    }
    
    
    var inviteView = UIView().then{
        $0.backgroundColor = .white
        $0.makeRounded(cornerRadius: 15)
    }
    
    var inviteTitleLabel = UILabel().then{
        $0.numberOfLines = 0
        $0.text = "친구들과 같이 마시멜로!"
        $0.font = UIFont(name: $0.font.fontName, size: 22)
        $0.textAlignment = .center
        
    }
    
    var inviteDetailLabel = UILabel().then{
        $0.numberOfLines = 0
        $0.text = "초대코드를 복사하여\n친구들과 같이 마시멜로하세요 :D"
        $0.textColor = .darkgrey
        $0.font = UIFont(name: $0.font.fontName, size: 14)
        $0.textAlignment = .center
        
        
        
    }
    
    var codeCopyButotn = UIButton().then{
        
        $0.backgroundColor = .lightpink
        $0.setTitle("초대 코드 복사", for: .normal)
        $0.setTitleColor(.mypink, for: .normal)
        $0.addTarget(self, action: #selector(touchupCopyButton), for: .touchUpInside)
        $0.titleLabel?.font = UIFont(name: "", size: 16)
        $0.makeRounded(cornerRadius: 24)
    }
    
    
    var cancelButton = UIButton().then{
       
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(.lightgrey, for: .normal)
        $0.addTarget(self, action: #selector(touchupCancelButton), for: .touchUpInside)
        
        
    }
    
    var completeButton  = UIButton().then{
        
        $0.setTitle("복사 완료!", for: .normal)
        $0.backgroundColor = .black
        $0.setTitleColor(.white, for: .normal)
        $0.addTarget(self, action: #selector(touchupCancelButton), for: .touchUpInside)
        $0.makeRounded(cornerRadius: 14)
        $0.titleLabel?.font = UIFont(name: $0.titleLabel?.font.fontName ?? "", size: 14)
        
        
    }
    
    
    //MARK:- LifeCycle Methods
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setItems()
        
        
        wholeCV.dataSource = self
        wholeCV.delegate = self
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        
    }

 
    
    
    //MARK:- User Define Functions
    
    func setItems(){
        
        GetRoomInfoService.shared.getRoomInfo(id : 12) { networkResult -> Void in
            switch networkResult {
            case .success(let data) :
                if let roomData = data as? GetRoomInfoData{
                    TimeGoVC.startTimeString = roomData.startTime
                    TimeGoVC.endTimeString = roomData.limitTime
                    self.titleLabel.text = roomData.title
                    
                    for p in roomData.participant {
                       
                        TimeGoVC.participants.append(p.nickname)
                        
                        
                    }
                    
                    let date = Date()
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    let calendar = Calendar.current
                    
                    TimeGoVC.endTime = formatter.date(from: TimeGoVC.endTimeString)
                    TimeGoVC.startTime = formatter.date(from: TimeGoVC.startTimeString)
                    TimeGoVC.startTimeString = formatter.string(from: date)
                    
                    let diff = calendar.dateComponents([.second], from: TimeGoVC.startTime!, to: TimeGoVC.endTime!)
                    
                    let totalSec = diff.second!
                    
                    
                 
                    
                    self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timeLimit), userInfo: nil, repeats: true)
                    self.circularView.progressAnimation(duration: Double(totalSec))
                    self.circleContainView.addSubview(self.circularView)
                    self.circularView.snp.makeConstraints{
                        $0.centerX.equalToSuperview()
                        $0.centerY.equalToSuperview()
                        
                        
                    }
                    self.wholeCV.reloadData()
                    
                    
                }
                
            case .requestErr(let msg):
                if let message = msg as? String {
                   print(message)
                }
            case .pathErr :
                print("pathErr")
            case .serverErr :
                print("serverErr")
            case .networkFail:
                print("networkFail")
            
                
                
            
            }
            
            
        }
        
        
      
        
    
       
        timeLabel.textColor = .mypink
        titleContainView.backgroundColor = .palegrey
        titleContainView.makeRounded(cornerRadius: 16)
        
    }
    
    @objc func timeLimit(){
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        
        
        let calendar = Calendar.current
        let diff = calendar.dateComponents([.second], from: date, to: TimeGoVC.endTime!)
        
        let totalSec = diff.second!
        
        if totalSec < 1 {
            showTimeOut()
            timer.invalidate()
            
            
        }
        
        let hour = totalSec/3600
        let min = (totalSec/60)%60
        let sec = totalSec%60
        
        let hourStr = hour < 10 ? "0"+String(hour) : String(hour)
        let minStr = min < 10 ? "0"+String(min) : String(min)
        let secStr = sec<10 ? "0"+String(sec) : String(sec)
        
        
        self.timeLabel.text = hourStr+":"+minStr+":"+secStr
        
        
        
        
        
    }
    
    @objc func touchupOkayButton(){
        
        GetResultService.shared.getRoomInfo(id: 12) { networkResult -> Void in
            switch networkResult {
            case .success(let data) :
                var namesForNext : [String] = []
                var percentForNext : [Int] = []
                if let roomData = data as? GetResultData{
                    
                    for p in roomData.participant {
                        namesForNext.append(p.nickname)
                        percentForNext.append(p.percent)
                    }
                    
                 
                
                    
                    
                }
                
                guard let vcName = UIStoryboard(name: "Result",
                                                bundle: nil).instantiateViewController(
                                                    withIdentifier: "ResultVC") as? ResultVC
                    else{
                        return
                }
                vcName.names = namesForNext
                vcName.percents = percentForNext
                
                self.present(vcName, animated: true, completion: nil)
                
                
                print(namesForNext)
                print(percentForNext)
                
            case .requestErr(let msg):
                if let message = msg as? String {
                   print(message)
                }
            case .pathErr :
                print("pathErr")
            case .serverErr :
                print("serverErr")
            case .networkFail:
                print("networkFail")
            
                
                
            
            }
            
            
        }
        
        
        
        
        
    }
    
    @objc func touchupCopyButton(){
        
        
        cancelButton.removeFromSuperview()
        inviteView.addSubview(completeButton)
        completeButton.snp.makeConstraints{
            $0.top.equalToSuperview().offset(196)
            $0.width.equalTo(111)
            $0.height.equalTo(28)
            $0.centerX.equalToSuperview()
        }
        
        
    }
    
    @objc func touchupCancelButton(){
        blurView.removeFromSuperview()
        inviteView.removeFromSuperview()
        
        
    
    }
    @objc func touchupCompleteButton(){
        blurView.removeFromSuperview()
        inviteView.removeFromSuperview()
        
        
    
    }
    
    
    
    func showTimeOut(){
        
        self.view.addSubview(blurView)
        self.view.addSubview(popUpView)
        
        blurView.snp.makeConstraints{
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        popUpView.snp.makeConstraints{
            $0.width.equalTo(274)
            $0.height.equalTo(236)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(257)
            
            
        }
        
        popUpView.addSubview(candyView)
        
        candyView.snp.makeConstraints{
            $0.width.height.equalTo(36)
            $0.top.equalToSuperview().offset(40)
            $0.centerX.equalToSuperview()
        }
        
        popUpView.addSubview(timeOutLabel)
        timeOutLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(100)
            $0.centerX.equalToSuperview()
            
        }
        
        popUpView.addSubview(okayButton)
        okayButton.snp.makeConstraints{
            $0.width.equalToSuperview()
            $0.height.equalTo(48)
            $0.bottom.equalToSuperview()
            
    
        }
        
        
        
        
    }
    
    
    
    @IBAction func shareButtonAction(_ sender: Any) {
        view.addSubview(blurView)
        view.addSubview(inviteView)
        inviteView.addSubview(inviteTitleLabel)
        inviteView.addSubview(inviteDetailLabel)
        inviteView.addSubview(codeCopyButotn)
        inviteView.addSubview(cancelButton)
        
        
        blurView.snp.makeConstraints{
            $0.top.bottom.leading.trailing.equalToSuperview()
            
        }
        
        inviteView.snp.makeConstraints{
            $0.width.equalToSuperview()
            $0.height.equalTo(261)
            $0.bottom.equalToSuperview().offset(5)
            
            
        }
        inviteTitleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(42)
            $0.centerX.equalToSuperview()
        }
        
        inviteDetailLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(80)
            $0.centerX.equalToSuperview()
        }
 
        codeCopyButotn.snp.makeConstraints{
            $0.top.equalTo(136)
            $0.width.equalTo(219)
            $0.height.equalTo(48)
            $0.centerX.equalToSuperview()
            
        }
        
        cancelButton.snp.makeConstraints{
            $0.top.equalToSuperview().offset(196)
            $0.centerX.equalToSuperview()
            
            
        }
        
        
        
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 30)

    }
    

    
}
