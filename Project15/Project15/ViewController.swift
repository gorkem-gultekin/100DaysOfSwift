//
//  ViewController.swift
//  Project15
//
//  Created by Görkem Gültekin on 19.02.2021.
//

import UIKit

class ViewController: UIViewController {

    var imageView: UIImageView!
    var currentAnswer = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView = UIImageView(image: UIImage(named: "penguin"))
        imageView.center = CGPoint(x: 220, y: 384)
        view.addSubview(imageView)
        
      
    }
    
    @IBAction func tapped(_ sender: UIButton) {
        
        sender.isHidden = true
        UIView.animate(withDuration: 1, delay: 0,usingSpringWithDamping: 0.5,initialSpringVelocity: 5, options: [], animations:{
            self.imageView.transform = CGAffineTransform(scaleX: 2, y: 2)
//            switch self.currentAnswer{
//            case 0:
//                self.imageView.transform = CGAffineTransform(scaleX: 2, y: 2)
//            case 1:
//                self.imageView.transform = .identity
//            case 2:
//                self.imageView.transform = CGAffineTransform(translationX: 380, y: 0)
//            case 3:
//                self.imageView.transform = .identity
//            case 4:
//                self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
//            case 5:
//                self.imageView.transform = .identity
//            case 6:
//                self.imageView.alpha = 0.7
//                self.imageView.backgroundColor = UIColor.gray
//            case 7:
//                self.imageView.alpha = 1
//                self.imageView.backgroundColor = UIColor.clear
//            default:
//                break
//            }
        }){finished in
            sender.isHidden = false
        }
        currentAnswer += 1
        if currentAnswer > 7 {
            currentAnswer = 0
        }
        
    }
    

}

