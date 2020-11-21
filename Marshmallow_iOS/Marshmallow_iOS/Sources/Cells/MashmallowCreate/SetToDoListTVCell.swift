//
//  SetToDoListTVCell.swift
//  Marshmallow_iOS
//
//  Created by 황지은 on 2020/11/22.
//

import UIKit



class SetToDoListTVCell: UITableViewCell,UITextFieldDelegate {

   
    @IBOutlet var setToDoListTextField: UITextField!
    var queryArray:[String] = []
   
    override class func awakeFromNib() {
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
 
  
    
}



  
   
