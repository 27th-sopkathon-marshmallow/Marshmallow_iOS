//
//  CreateDatePickerVC.swift
//  Marshmallow_iOS
//
//  Created by 황지은 on 2020/11/22.
//

import UIKit

class CreateDatePickerVC: UIViewController {

    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var confirmBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBtnCustom()

        // Do any additional setup after loading the view.
    }
    
    private func setBtnCustom() {
        confirmBtn.layer.cornerRadius = 25
//        confirmBtn.backgroundColor = UIColor.yellow
//        confirmBtn.tintColor = UIColor.white
    }
    
    @IBAction func dismissDatePicker(_ sender: UIButton) {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "hh"
        let hour: String = dateFormatter.string(from: datePicker.date)
        
        dateFormatter.dateFormat = "mm"
        let minute:String = dateFormatter.string(from: datePicker.date)
     
      
        dateFormatter.dateFormat = "a"
        dateFormatter.amSymbol = "오전"
        dateFormatter.pmSymbol = "오후"
        let ampm:String = dateFormatter.string(from: datePicker.date)
      
      let calendar = Calendar.current
      
      
        
      NotificationCenter.default.post(name: .init("popup"), object: nil, userInfo: ["hour": hour, "minute":minute, "ampm":ampm])
        
        self.dismiss(animated: true, completion: nil)
    }

}
