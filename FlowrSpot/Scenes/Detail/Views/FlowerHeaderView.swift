//
//  FlowerHeaderView.swift
//  FlowrSpot
//
//  Created by Arijan Ljoki on 25/07/2019.
//  Copyright © 2019 PovioLabs. All rights reserved.
//

import UIKit
import Kingfisher

class FlowerHeaderView: UIView {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var newSightingButton: UIButton!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var labelsStackView: UIStackView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var sightingLabel: UILabel!
    @IBOutlet weak var sightingBackgroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupDesign()
    }
    
    func setup(flower: Flower) {
        titleLabel.text = flower.name
        subtitleLabel.text = flower.latinName
        backgroundImageView.kf.setImage(with: URL(string: "http:\(flower.profilePicture)"))
//        descriptionLabel.text = flower.
        sightingLabel.text = "sightings_count".localized(flower.sightings)
    }
    
    private func setupDesign() {
        // Labels
        titleLabel.font = .custom(type: .light, size: 35)
        subtitleLabel.font = .custom(type: .light, size: 14)
        descriptionLabel.font = .custom(type: .regular, size: 13)
        sightingLabel.font = .custom(type: .regular, size: 12)
        
        // Button
        newSightingButton.titleLabel?.font = .custom(type: .semibold, size: 14)
        newSightingButton.setTitle("detail_button_add_new_sighting".localized(), for: .normal)
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
//        gradientLayer.colors = [UIColor.flowrBlush.cgColor, UIColor.flowrBeige.cgColor]
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
//        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.opacity = 1.0
        newSightingButton.layer.addSublayer(gradientLayer)
        
        sightingBackgroundView.layer.cornerRadius = sightingBackgroundView.frame.height / 2.0
        sightingBackgroundView.layer.masksToBounds = true
    }
    
    @IBAction func newSightingButtonPressed(_ sender: Any) {
        // Navigate to empty screen
    }
}
