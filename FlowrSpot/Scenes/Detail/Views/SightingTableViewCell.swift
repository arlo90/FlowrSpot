//
//  SightingCollectionViewCell.swift
//  FlowrSpot
//
//  Created by Arijan Ljoki on 25/07/2019.
//  Copyright © 2019 PovioLabs. All rights reserved.
//

import PovioKit

class SightingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var locationContainer: UIView!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var flowerNameLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var favoritesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupDesign()
    }
    
    func setup(sighting: Sighting) {
        // If we used location API, location name would be set based on latitude and longitude
        locationLabel.text = "San Francisco, US"
        flowerNameLabel.text = sighting.name
        authorLabel.text = sighting.user.fullName
        backgroundImageView.kf.setImage(with: URL(string: "http:\(sighting.picture)"))
        avatarImageView.kf.setImage(with: URL(string: "https://api.adorable.io/avatars/80/\(sighting.user.id).png"))
        descriptionLabel.text = sighting.description
        
        commentsLabel.text = "detail_comments_count".localized()
        favoritesLabel.text = "detail_favorites_count".localized()
    }
}

private extension SightingTableViewCell {
    
    func setupDesign() {
        selectionStyle = .none
        
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2.0
        avatarImageView.layer.masksToBounds = true
        
        locationContainer.layer.cornerRadius = locationContainer.frame.height / 2.0
        locationContainer.layer.masksToBounds = true
        
        // Labels
        locationLabel.font = .custom(type: .regular, size: 12)
        locationLabel.textColor = UIColor.flowrPinkishTan
        flowerNameLabel.font = .custom(type: .regular, size: 15)
        flowerNameLabel.textColor = UIColor.flowrCharcoalGray
        descriptionLabel.font = .custom(type: .regular, size: 13)
        descriptionLabel.textColor = UIColor.flowrGray
        authorLabel.font = .custom(type: .italic, size: 12)
        authorLabel.textColor = UIColor.flowrGray
        commentsLabel.font = .custom(type: .regular, size: 12)
        commentsLabel.textColor = UIColor.flowrGray
        favoritesLabel.font = .custom(type: .regular, size: 12)
        favoritesLabel.textColor = UIColor.flowrGray
    }
}
