//
//  ResultVC.swift
//  Marshmallow_iOS
//
//  Created by 장서현 on 2020/11/22.
//

import UIKit

class ResultVC: UIViewController {
    @IBOutlet weak var resultTableView: UITableView!
    
    var names : [String] = []
    var percents : [Int] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultTableView.dataSource = self
        self.resultTableView.separatorStyle = .none
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func xButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

extension ResultVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else if section == 1{
            return 1
        }
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: ResultImageCell.identifier, for: indexPath)
            return cell
        }
        else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: LabelCell.identifier, for: indexPath)
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonalResultCell.identifier, for: indexPath) as? PersonalResultCell
        else {
            return UITableViewCell()
        }
        cell.setItems(userName: names[indexPath.item], per: percents[indexPath.item])
        return cell
    }
    
}
