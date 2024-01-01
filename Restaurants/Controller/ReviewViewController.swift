//
// ReviewViewController.swift
//  Restaurants
//
//  Created by Jamaaldeen Opasina on 31/12/2023.
//

import UIKit

class ReviewViewController: UIViewController {

    @IBOutlet var backgroundImageView: UIImageView!
    
    @IBOutlet var rateButtons: [UIButton]!
    var restaurant = Restaurant()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundImageView.image = UIImage(named: restaurant.image)
        
        //Applying blur effect
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
            //Slide in animation
        let moveRightTransform = CGAffineTransform.init(translationX: 600, y: 0)
        let scaleUpTransform = CGAffineTransform.init(scaleX: 5.0, y: 5.0)
        let moveScaleTransform = scaleUpTransform.concatenating(moveRightTransform)
            //Make the buttons invisible
        for rateButton in rateButtons{
            //rateButton.transform = moveRightTransform
            rateButton.transform = moveScaleTransform
            rateButton.alpha = 0
        }

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        UIView.animate(withDuration: 10.0){
//            self.rateButtons[0].alpha = 1.0
//            self.rateButtons[1].alpha = 1.0
//            self.rateButtons[2].alpha = 1.0
//            self.rateButtons[3].alpha = 1.0
//            self.rateButtons[4].alpha = 1.0
//        }
        // delayed animation
//        UIView.animate(withDuration: 0.4, delay: 0.1, animations: {
//            self.rateButtons[0].alpha = 1.0
//        },completion: nil)
//        
//        UIView.animate(withDuration: 0.4, delay: 0.15, animations: {
//            self.rateButtons[1].alpha = 1.0
//        },completion: nil)
//        
//        UIView.animate(withDuration: 0.4, delay: 0.2, animations: {
//            self.rateButtons[2].alpha = 1.0
//        },completion: nil)
//        
//        UIView.animate(withDuration: 0.4, delay: 0.25, animations: {
//            self.rateButtons[3].alpha = 1.0
//        },completion: nil)
//        
//        UIView.animate(withDuration: 0.4, delay: 0.3, animations: {
//            self.rateButtons[4].alpha = 1.0
//        },completion: nil)
        
        
        //slide animation
//        UIView.animate(withDuration: 0.4, delay: 0.1, animations: {
//            self.rateButtons[0].alpha = 1.0
//            self.rateButtons[0].transform = .identity
//        },completion: nil)
//        
//        UIView.animate(withDuration: 0.4, delay: 0.15, animations: {
//            self.rateButtons[1].alpha = 1.0
//            self.rateButtons[1].transform = .identity
//        },completion: nil)
//        
//        UIView.animate(withDuration: 0.4, delay: 0.2, animations: {
//            self.rateButtons[2].alpha = 1.0
//            self.rateButtons[2].transform = .identity
//        },completion: nil)
//        
//        UIView.animate(withDuration: 0.4, delay: 0.25, animations: {
//            self.rateButtons[3].alpha = 1.0
//            self.rateButtons[3].transform = .identity
//        },completion: nil)
//        
//        UIView.animate(withDuration: 0.4, delay: 0.3, animations: {
//            self.rateButtons[4].alpha = 1.0
//            self.rateButtons[4].transform = .identity
//        },completion: nil)
        
        
        //spring animation
        UIView.animate(withDuration: 0.8, delay: 0.1, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.3, animations: {
            self.rateButtons[0].alpha = 1.0
            self.rateButtons[0].transform = .identity
        },completion : nil)
    }
    

}
