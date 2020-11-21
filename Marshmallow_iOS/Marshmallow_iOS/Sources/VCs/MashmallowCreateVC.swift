//
//  MashmallowCreateVC.swift
//  Marshmallow_iOS
//
//  Created by 황지은 on 2020/11/22.
//

import UIKit

class MashmallowCreateVC: UIViewController {
    
    @IBOutlet var createMashmallowTV: UITableView!
    @IBOutlet var popupBackgroundView: UIView!
    var hourText:String = "오전 4시 26분"
    var toDoListArray:[String] = [""]
    var realToDoArray:[String] = []
    let now = NSDate()
    let dateFormatter = DateFormatter()
    var mycount :Int = 0
    var goalText:String = "행복한 마시멜로 이야기"
    var finalhourText:String = ""
    var presentHour:String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createMashmallowTV.delegate = self
        createMashmallowTV.dataSource = self
        createMashmallowTV.allowsSelection = false
        createMashmallowTV.separatorStyle = .none
        setPopupBackgroundView()
        dateFormatter.amSymbol = "오전"
        dateFormatter.pmSymbol = "오후"
        dateFormatter.dateFormat = "a hh시 mm분"
        hourText = dateFormatter.string(from: now as Date)
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        presentHour = dateFormatter.string(from: now as Date)
        
    }
    @IBAction func touchUpDatePickerBtn(_ sender: UIButton) {
        animatePopupBackground(true)
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "CreateDatePickerVC") as? CreateDatePickerVC else { return }
        
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    private func setPopupBackgroundView() {
        
        popupBackgroundView.isHidden = true
        popupBackgroundView.alpha = 0
        self.view.bringSubviewToFront(popupBackgroundView)
        NotificationCenter.default.addObserver(self, selector: #selector(didDisappearPopup), name: .init("popup"), object: nil)
    }
    
    func animatePopupBackground(_ direction: Bool) {
        
        let duration: TimeInterval = direction ? 0.35 : 0.15
        let alpha: CGFloat = direction ? 0.54 : 0.0
        self.popupBackgroundView.isHidden = !direction
        UIView.animate(withDuration: duration) {
            self.popupBackgroundView.alpha = alpha
        }
        
    }
    
    @objc func didDisappearPopup(_ notification: Notification) {
        
        let dateFormatter : DateFormatter = DateFormatter()
        
        animatePopupBackground(false)
        
        guard let info = notification.userInfo as? [String: Any] else { return }
        guard let hour = info["hour"] as? String else { return }
        guard let minute = info["minute"] as? String else {return}
        guard let ampm = info["ampm"] as? String else {return}
        
        dateFormatter.dateFormat = "a h:mm"
        
        dateFormatter.amSymbol = "오전"
        dateFormatter.pmSymbol = "오후"
        
    
        
        hourText = "\(ampm)" + " " + "\(hour)" + "시"  + " " + "\(minute)" + "분"
        
        dateFormatter.dateFormat = "2020-11-22 11:30:15"
        finalhourText = dateFormatter.dateFormat
        print("파이널",finalhourText)
        
        createMashmallowTV.reloadSections(IndexSet(integer: 0), with: .none)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func touchUpCompleteBtn(_ sender: UIButton) {
        mycount += 1
        toDoListArray.append("")
        createMashmallowTV.reloadSections(IndexSet(integer: 2), with: .none)
    }
    
    
    @IBAction func realCompleteBtn(_ sender: UIButton) {
        realToDoArray.append("안녕")
        realToDoArray.append("나는")
        realToDoArray.append("지은")
        realToDoArray.append("이야")
        realToDoArray = realToDoArray.filter{$0 != ""}
        print(realToDoArray)
        
        
        JoinRoomService.shared.joinRoom(title: goalText, startTime: presentHour, limitTime: finalhourText, completion: { [self] result in
            switch result {
            case .success:
                print("성공")
            case .requestErr(let msg):
                print("dd",goalText)
                print("dd",presentHour)
                print("dd",finalhourText)
                print(msg)
            case .pathErr:
                print("path")
                break
            case .serverErr:
                print("server")
                break
            case .networkFail:
                print("network")
                break
            }
            
        })
        
        
    }
    
    
    
}

extension MashmallowCreateVC:UITableViewDelegate,UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        }
        else if section == 1 {
            return 1
        }
        else if section == 2 {
            return 4
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
            
            let goalCell = tableView.dequeueReusableCell(withIdentifier: "SetGoalAndTimeTVCell") as! SetGoalAndTimeTVCell
            goalCell.goalTextfield.layer.cornerRadius = 16
            goalCell.goalTextfield
                .setLeftPaddingPoints(16)
            
            goalCell.limitTimeBtn.setTitle(hourText, for: .normal)
            
            goalText = "행복한 마시멜로 이야기"
            return goalCell
            
        }
        
        
        else if indexPath.section == 1{
            
            let nicknameCell = tableView.dequeueReusableCell(withIdentifier: "SetNicknameTVCell") as! SetNicknameTVCell
            
            nicknameCell.setNicknameTextfield.layer.cornerRadius = 16
            nicknameCell.setNicknameTextfield.setLeftPaddingPoints(16)
            
            return nicknameCell
            
        }
        else if indexPath.section == 2 {
            let toDoListCell = tableView.dequeueReusableCell(withIdentifier: "SetToDoListTVCell") as! SetToDoListTVCell
            toDoListCell.setToDoListTextField.layer.cornerRadius = 16
            toDoListCell.setToDoListTextField.setLeftPaddingPoints(16)
            realToDoArray.append(toDoListCell.setToDoListTextField.text!)
            
            print(realToDoArray)
            
            return toDoListCell
        }
        
        else {
            let touchUpBtnCell = tableView.dequeueReusableCell(withIdentifier: "CompleteBtnTouchTVCell") as! CompleteBtnTouchTVCell
        
            return touchUpBtnCell
        }
        return UITableViewCell()
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 224
        }
        else if indexPath.section == 1 {
            
            return 172
        }
        else if indexPath.section == 2 {
            return 58
        }
        else {
            return 32
        }
    }
    
    
    
    
}
extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){ //왼쪽에 여백 주기
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
 
    func setRightPaddingPoints(_ amount:CGFloat) { //오른쪽에 여백 주기
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    
}

