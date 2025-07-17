//
//  ScrollView.swift
//  ApplyToCreditProject
//
//  Created by Şerif Botan Kapcuk on 15.07.2025.
//

import UIKit

class Slide: UIView {
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelBody: UILabel!
    @IBOutlet weak var Image1: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    func setupUI(){
        labelBody.numberOfLines = 0
        labelTitle.numberOfLines = 0
        labelBody.textColor = .black
        labelTitle.textColor = .black
        labelBody.textAlignment = .center
        labelTitle.textAlignment = .center
    }
}
