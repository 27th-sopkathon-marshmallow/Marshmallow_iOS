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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
        
    }
    
    func setTodo(todo : String){
       
        todoLabel.text = todo
        
    }
    
}
