//
//  HomeHeaderView.swift
//  FlowrSpot
//
//  Created by TK on 16/01/2018.
//  Copyright © 2018 PovioLabs. All rights reserved.
//

import UIKit
import SnapKit

class HomeHeaderView: UIView {
  private let backgroundImageView = UIImageView.autolayoutView()
  private let titleLabel = UILabel.autolayoutView()
  private let subtitleLabel = UILabel.autolayoutView()
  private let searchBar = SearchView.autolayoutView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
    return searchBar.frame.contains(point)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Private methods
private extension HomeHeaderView {
  func setupViews() {
    clipsToBounds = true
    setupBackgroundImageView()
    setupTitleLabel()
    setupSubtitleLabel()
    setupSearchBar()
  }

  func setupBackgroundImageView() {
    addSubview(backgroundImageView)
    backgroundImageView.image = UIImage(named: "plHero")
    backgroundImageView.contentMode = .scaleAspectFill
    backgroundImageView.snp.makeConstraints {
      $0.top.left.right.bottom.equalToSuperview()
    }
  }
  
  func setupTitleLabel() {
    addSubview(titleLabel)
    titleLabel.font = .custom(type: .regular, size: 24)
    titleLabel.textColor = .white
    titleLabel.textAlignment = .center
    titleLabel.numberOfLines = 0
    titleLabel.text = "home_title".localized()
    titleLabel.snp.makeConstraints {
      $0.top.equalTo(60)
      $0.left.equalTo(20)
      $0.right.equalTo(-20)
    }
  }
  
  func setupSubtitleLabel() {
    addSubview(subtitleLabel)
    subtitleLabel.font = .custom(type: .light, size: 12)
    subtitleLabel.textAlignment = .center
    subtitleLabel.numberOfLines = 0
    subtitleLabel.alpha = 0.7
    subtitleLabel.textColor = .white
    subtitleLabel.text = "home_subtitle".localized()
    subtitleLabel.snp.makeConstraints {
      $0.left.equalTo(20)
      $0.right.equalTo(-20)
      $0.centerX.equalToSuperview()
      $0.top.equalTo(titleLabel.snp.bottom).offset(20)
    }
  }
  
  func setupSearchBar() {
    addSubview(searchBar)
    searchBar.placeholder = "home_search_placeholder".localized()
    searchBar.snp.makeConstraints {
      $0.top.equalTo(subtitleLabel).inset(40)
      $0.left.equalTo(30)
      $0.right.equalTo(-30)
      $0.height.equalTo(45)
      $0.centerX.equalToSuperview()
    }
  }
}
