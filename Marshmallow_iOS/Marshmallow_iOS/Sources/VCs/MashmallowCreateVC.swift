//
//  MashmallowCreateVC.swift
//  Marshmallow_iOS
//
//  Created by 황지은 on 2020/11/22.
//

import UIKit

class MashmallowCreateVC: UIViewController {
    
    @IBOutlet var createMashmallowTV: UITableView!
    var toDoListArray:[String] = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createMashmallowTV.delegate = self
        createMashmallowTV.dataSource = self
        createMashmallowTV.allowsSelection = false
        createMashmallowTV.separatorStyle = .none
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
        toDoListArray.append("")
        createMashmallowTV.reloadData()
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
            return toDoListArray.count
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

