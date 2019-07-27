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
    
    static let identifier = "FlowerHeaderView"
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var newSightingButton: UIButton!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var sightingLabel: UILabel!
    @IBOutlet weak var sightingBackgroundView: UIView!
    
    private let gradientLayer = CAGradientLayer()
    private var router: DetailRoutingLogic?
    private var flower: Flower?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupDesign()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = backgroundImageView.bounds
    }
    
    func setup(flower: Flower, router: DetailRoutingLogic?) {
        self.flower = flower
        self.router = router
        
        titleLabel.text = flower.name
        subtitleLabel.text = flower.latinName
        backgroundImageView.kf.setImage(with: URL(string: "http:\(flower.profilePicture)"))
        descriptionLabel.text = flower.description
        sightingLabel.text = "sightings_count".localized(flower.sightings ?? 0)
    }
    
    // User interaction is disabled for this view, so we need to handle click by ourself
    // Disabling interaction allows for tableView to be scrollable under header view.
    override internal func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if newSightingButton.frame.contains(point) {
            return newSightingButton
        }
        
        return nil
    }
}

private extension FlowerHeaderView {
    
    func setupDesign() {
        // Labels
        titleLabel.font = .custom(type: .light, size: 35)
        subtitleLabel.font = .custom(type: .light, size: 14)
        descriptionLabel.font = .custom(type: .regular, size: 13)
        sightingLabel.font = .custom(type: .regular, size: 12)
        
        // Button
        let buttonGradientLayer = CAGradientLayer()
        newSightingButton.titleLabel?.font = .custom(type: .semibold, size: 14)
        newSightingButton.setTitle("detail_button_add_new_sighting".localized(), for: .normal)
        buttonGradientLayer.frame = newSightingButton.bounds
        buttonGradientLayer.colors = [UIColor.flowrBlush.cgColor, UIColor.flowrBeige.cgColor]
        buttonGradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        buttonGradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        buttonGradientLayer.opacity = 1.0
        newSightingButton.layer.insertSublayer(buttonGradientLayer, at: 0)
        newSightingButton.layer.cornerRadius = 3
        newSightingButton.layer.masksToBounds = true
        
        // Background
        gradientLayer.frame = backgroundImageView.frame
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.opacity = 0.8
        backgroundImageView.layer.addSublayer(gradientLayer)
        
        sightingBackgroundView.layer.cornerRadius = sightingBackgroundView.frame.height / 2.0
        sightingBackgroundView.layer.masksToBounds = true
    }
    
    @IBAction func newSightingButtonPressed(_ sender: Any) {
        guard let flower = flower else {
            router?.navigateToAlert(title: "general_error".localized(), message: "placeholder_no_content".localized(), handler: nil)
            return
        }
        
        router?.navigateToCreateNewSighting(flower: flower)
    }
}
