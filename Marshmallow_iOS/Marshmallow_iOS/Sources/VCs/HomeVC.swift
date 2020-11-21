//
//  HomeVC.swift
//  Marshmallow_iOS
//
//  Created by 장서현 on 2020/11/22.
//

import UIKit

class HomeVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func touchUpCreate(_ sender: Any) {
    }
    
    @IBAction func touchUpEnter(_ sender: UIButton) {
        guard let dvc = self.storyboard?.instantiateViewController(identifier: "HomePopVC") else {
            return
        }
        self.present(dvc, animated: true, completion: nil)
    }
    
    
    @IBAction func createButtonAction(_ sender: Any) {
        guard let vcName = UIStoryboard(name: "MashmallowCreate",
                                        bundle: nil).instantiateViewController(
                                            withIdentifier: "MashmallowCreateVC") as? MashmallowCreateVC
        else{
            return
            
            
        }
        vcName.modalPresentationStyle = .fullScreen
        self.present(vcName, animated: true, completion: nil)
        
        
    }

}
