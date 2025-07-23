//
//  ResultScreenViewController.swift
//  ApplyToCreditProject
//
//  Created by Şerif Botan Kapcuk on 23.07.2025.
//

import UIKit

class ResultScreenViewController: UIViewController {
    
    @IBOutlet var homeButton:UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    func setupUI() {
        
    }
    @IBAction func clickedHomeButton(_ homeButton:UIButton){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "dashboardID")
        nextVC.modalPresentationStyle = .custom
        self.present(nextVC, animated: true, completion: nil)
    }
}
