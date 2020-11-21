//
//  HomePopVC.swift
//  Marshmallow_iOS
//
//  Created by 장서현 on 2020/11/22.
//

import UIKit

class HomePopVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.8)
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func touchUpClose(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    

}
