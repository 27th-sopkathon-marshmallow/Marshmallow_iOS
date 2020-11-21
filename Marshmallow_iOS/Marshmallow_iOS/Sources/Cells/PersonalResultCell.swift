//
//  PersonalResultCell.swift
//  Marshmallow_iOS
//
//  Created by 장서현 on 2020/11/22.
//

import UIKit

class PersonalResultCell: UITableViewCell {
    static let identifier = "PersonalResultCell"

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var resultPercentage: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
