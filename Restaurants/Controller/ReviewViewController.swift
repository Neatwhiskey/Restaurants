//
// ReviewViewController.swift
//  Restaurants
//
//  Created by Jamaaldeen Opasina on 31/12/2023.
//

import UIKit

class ReviewViewController: UIViewController {

    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var closeButton: UIButton!
    @IBOutlet var rateButtons: [UIButton]!{
        didSet{
            rateButtons.forEach{ button in
                button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .largeTitle)
            }
        }
    }
    var restaurant = Restaurant()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundImageView.image = UIImage(data: restaurant.image)
        
        //Applying blur effect
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
            //Slide in animation
        let moveRightTransform = CGAffineTransform.init(translationX: 600, y: 0)
        let scaleUpTransform = CGAffineTransform.init(scaleX: 5.0, y: 5.0)
        let moveScaleTransform = scaleUpTransform.concatenating(moveRightTransform)
        let moveUPTransform = CGAffineTransform.init(translationX: 0, y: -600)
        
            //Make the buttons invisible
        for rateButton in rateButtons{
            //rateButton.transform = moveRightTransform
            rateButton.transform = moveScaleTransform
            rateButton.alpha = 0
        }
        
        closeButton.transform = moveUPTransform

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        for index in 0...4{
            UIView.animate(withDuration: 0.4,delay: (0.1 + 0.05 * Double(index)),options: [], animations: {
                self.rateButtons[index].alpha = 1.0
                self.rateButtons[index].transform = .identity
            }, completion: nil)
        }
        
        //Animate close button
        UIView.animate(withDuration: 0.4, delay: 0.1, options: [], animations: {
            self.closeButton.transform = .identity
        }, completion: nil)
    
    
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
//        UIView.animate(withDuration: 0.8, delay: 0.1, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, animations: {
//            self.rateButtons[0].alpha = 1.0
//            self.rateButtons[0].transform = .identity
//        },completion : nil)
//        
//        UIView.animate(withDuration: 0.8, delay: 0.2, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, animations: {
//            self.rateButtons[1].alpha = 1.0
//            self.rateButtons[1].transform = .identity
//        },completion : nil)
//        
//        UIView.animate(withDuration: 0.8, delay: 0.25, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, animations: {
//            self.rateButtons[2].alpha = 1.0
//            self.rateButtons[2].transform = .identity
//        },completion : nil)
//        
//        UIView.animate(withDuration: 0.8, delay: 0.3, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, animations: {
//            self.rateButtons[3].alpha = 1.0
//            self.rateButtons[3].transform = .identity
//        },completion : nil)
//        
//        UIView.animate(withDuration: 0.8, delay: 0.35, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, animations: {
//            self.rateButtons[4].alpha = 1.0
//            self.rateButtons[4].transform = .identity
//        },completion : nil)
    }
    

}
