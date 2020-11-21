//
//  SetGoalAndTimeTVCell.swift
//  Marshmallow_iOS
//
//  Created by 황지은 on 2020/11/22.
//

import UIKit



class SetGoalAndTimeTVCell: UITableViewCell {
    
   
    @IBOutlet var goalTextfield: UITextField!
    @IBOutlet var limitTimeBtn: UIButton!
    
    
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func touchUpLimitTimeBtn(_ sender: UIButton) {
        
        //데이트피커 띄우기
    }
    
    
    
}

