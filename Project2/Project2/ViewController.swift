//
//  ViewController.swift
//  Project2
//
//  Created by Görkem Gültekin on 4.02.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var totalQuestion = 10
    override func viewDidLoad() {
        super.viewDidLoad()
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        countries += ["estonia","france","germany","ireland","italy","monaco","nigeria","poland","russia","spain","uk","us"]
        print(totalQuestion)
        askQuestion()
    }
    func askQuestion(action: UIAlertAction! = nil) {
        if totalQuestion == 0{
            let alert = UIAlertController(title: "Finish", message: "\(score) correct in 10 questions", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (alert) in
                self.score = 0
                self.totalQuestion = 0
                self.askQuestion()
            }))
            alert.addAction(UIAlertAction(title: "Exit", style: UIAlertAction.Style.cancel, handler: { (alert) in
                exit(10)
            }))
            present(alert, animated: true, completion: nil)
        }else{
        countries.shuffle()
        correctAnswer = Int.random(in: 1...2)
        button1.setImage(UIImage(named: countries[0]), for: UIControl.State.normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        title = "\(countries[correctAnswer].uppercased()) Score:\(score)"
        }
    }
    @IBAction func buttonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 1, delay: 0,usingSpringWithDamping: 0.5,initialSpringVelocity: 5, options: [], animations: {
            sender.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
            var title: String
            var message: String
            if sender.tag == self.correctAnswer{
                    title = "Correct"
                    self.score += 1
                message = "Score: \(self.score)"
                }else{
                    title = "Wrong"
                    message = "That's the flag of \(self.countries[sender.tag].uppercased())"
                }
                let ac = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler:{action in
                self.askQuestion(action: action)
                sender.transform = .identity
            } ))
            self.present(ac, animated: true)
            self.totalQuestion -= 1
        })
    }
}

