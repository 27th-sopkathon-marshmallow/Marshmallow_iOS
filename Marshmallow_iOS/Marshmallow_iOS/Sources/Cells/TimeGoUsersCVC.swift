//
//  TimeGoUsersCVC.swift
//  Marshmallow_iOS
//
//  Created by Yunjae Kim on 2020/11/22.
//

import UIKit

class TimeGoUsersCVC: UICollectionViewCell {
    static let identifier = "TimeGoUsersCVC"
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }
    
    
    func setUser(profileURL : String, userName : String){
        profileImageView.image = UIImage(named: profileURL)
        userNameLabel.text = userName
        
    }
    
    
    
}
