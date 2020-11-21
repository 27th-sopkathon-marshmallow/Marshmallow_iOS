//
//  TimeGoWholeCVC.swift
//  Marshmallow_iOS
//
//  Created by Yunjae Kim on 2020/11/22.
//

import UIKit

class TimeGoWholeCVC: UICollectionViewCell {
    static let identifier = "TimeGoWholeCVC"
    
    @IBOutlet weak var userCV: UICollectionView!
    
    
    var profileImages = ["challengeImgProfile1","challengeImgProfile2","challengeImgProfile3","challengeImgProfile4","challengeImgProfile5","challengeImgProfile6","challengeImgProfile7"]
    
    override func awakeFromNib() {
        userCV.delegate = self
        userCV.dataSource = self
        
    }
    
    
    
    
    
}



extension TimeGoWholeCVC : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
}

extension TimeGoWholeCVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TimeGoVC.participants.count
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TimeGoUsersCVC.identifier,
                for: indexPath) as? TimeGoUsersCVC else {
            
            return UICollectionViewCell()}
        
        cell.setUser(profileURL: profileImages[indexPath.item], userName: TimeGoVC.participants[indexPath.item])
        
        
        return cell
        
        
    }
    

    
    
    
    
}

extension TimeGoWholeCVC : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40 , height: 60)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0)
    }
    
    //    UIEdgeInset
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
        
    }
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: collectionView.frame.width, height: 20)
//
//    }
    
    
    
}
