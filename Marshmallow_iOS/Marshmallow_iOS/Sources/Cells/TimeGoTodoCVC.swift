//
//  TimeGoTodoCVC.swift
//  Marshmallow_iOS
//
//  Created by Yunjae Kim on 2020/11/22.
//

import UIKit

class TimeGoTodoCVC: UICollectionViewCell {
    
    static let identifier = "TimeGoTodoCVC"
    
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var todoLabel: UILabel!
    
    var clicked = false
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
        
    }
    
    func setTodo(todo : String){
        
        checkButton.setImage(UIImage(named: "challengeBtnCheckInactive")?.withRenderingMode(.alwaysOriginal), for: .normal)
        todoLabel.text = todo
        
    }
    
    
    @IBAction func checkButtonClicked(_ sender: Any) {
        
        if clicked{
            checkButton.setImage(UIImage(named: "challengeBtnCheckInactive")?.withRenderingMode(.alwaysOriginal), for: .normal)
            todoLabel.textColor = .black
            clicked = false
            
        }
        
        else{
            checkButton.setImage(UIImage(named: "challengeBtnCheckActive")?.withRenderingMode(.alwaysOriginal), for: .normal)
            todoLabel.textColor = .lightgrey
            clicked = true
            
        }
        
        
    }
    
    
}
