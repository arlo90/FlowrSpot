//
//  PhotoCollectionViewCell.swift
//  FlowrSpot
//
//  Created by TK on 16/01/2018.
//  Copyright © 2018 PovioLabs. All rights reserved.
//

import PovioKit
import Kingfisher

class FlowerCollectionViewCell: UICollectionViewCell {
  private let imageView = UIImageView.autolayoutView()
  private let favoriteButton = UIButton.autolayoutView()
  private let titleLabel = UILabel.autolayoutView()
  private let subtitleLabel = UILabel.autolayoutView()
  private let sightingsLabel = UILabel.autolayoutView()
  private let sightingsLabelWrapperView = UIView.autolayoutView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Public methods
extension FlowerCollectionViewCell {
  func setFlower(_ flower: Flower) {
    titleLabel.text = flower.name
    subtitleLabel.text = flower.latinName
    sightingsLabel.text = "sightings_count".localized(flower.sightings)
    imageView.kf.setImage(with: URL(string: "http:\(flower.profilePicture)"))
  }
}

// MARK: - Private methods
private extension FlowerCollectionViewCell {
  func setupViews() {
    layer.masksToBounds = true
    layer.cornerRadius = 3
    setupImageView()
    setupFavoriteButton()
    setupSightingsLabel()
    setupLabelWrapperView()
    setupSubtitleLabel()
    setupTitleLabel()
  }
  
  func setupImageView() {
    addSubview(imageView)
    imageView.kf.indicatorType = .activity
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = bounds
    gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
    gradientLayer.locations = [0.0, 1.0]
    gradientLayer.opacity = 0.8
    imageView.layer.addSublayer(gradientLayer)
    imageView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  func setupFavoriteButton() {
    addSubview(favoriteButton)
    favoriteButton.backgroundColor = .white
    favoriteButton.layer.cornerRadius = 12
    favoriteButton.setImage(#imageLiteral(resourceName: "favoritesIcons"), for: .normal)
    favoriteButton.snp.makeConstraints {
      $0.top.equalTo(12)
      $0.trailing.equalTo(-12)
      $0.size.equalTo(24)
    }
  }
  
  func setupSightingsLabel() {
    addSubview(sightingsLabel)
    sightingsLabel.font = .custom(type: .regular, size: 10)
    sightingsLabel.textColor = .white
    sightingsLabel.textAlignment = .center
    sightingsLabel.snp.makeConstraints {
      $0.bottom.equalTo(-30)
      $0.height.equalTo(24)
      $0.centerX.equalToSuperview()
    }
  }
  
  func setupLabelWrapperView() {
    addSubview(sightingsLabelWrapperView)
    sightingsLabelWrapperView.backgroundColor = .black
    sightingsLabelWrapperView.alpha = 0.5
    sightingsLabelWrapperView.layer.cornerRadius = 12
    sightingsLabelWrapperView.snp.makeConstraints {
      $0.center.equalTo(sightingsLabel.snp.center)
      $0.height.equalTo(24)
      $0.width.equalTo(sightingsLabel.snp.width).offset(25)
    }
  }
  
  func setupSubtitleLabel() {
    addSubview(subtitleLabel)
    subtitleLabel.font = .custom(type: .italic, size: 10)
    subtitleLabel.textColor = .white
    subtitleLabel.textAlignment = .center
    subtitleLabel.alpha = 0.7
    subtitleLabel.snp.makeConstraints {
      $0.leading.equalTo(20)
      $0.trailing.equalTo(-20)
      $0.bottom.equalTo(sightingsLabelWrapperView.snp.top).offset(-20)
      $0.centerX.equalToSuperview()
    }
  }
  
  func setupTitleLabel() {
    addSubview(titleLabel)
    titleLabel.font = .custom(type: .regular, size: 20)
    titleLabel.textColor = .white
    titleLabel.textAlignment = .center
    titleLabel.numberOfLines = 2
    titleLabel.snp.makeConstraints {
      $0.leading.equalTo(12)
      $0.trailing.equalTo(-12)
      $0.bottom.equalTo(subtitleLabel).inset(15)
      $0.centerX.equalToSuperview()
    }
  }
}
