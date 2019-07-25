//
//  HomeContentView.swift
//  FlowrSpot
//
//  Created by Toni Kocjan on 12/06/2019.
//  Copyright © 2019 PovioLabs. All rights reserved.
//

import UIKit
import PovioKit

class HomeContentView: UIView {
  let collectionViewDimensions = FlowerCollectionViewItemDimenson(numberOfItemsInRow: 2, insets: 8)
  let headerViewHeight: CGFloat = 255
  let headerView = HomeHeaderView.autolayoutView()
  let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).autolayoutView()
  let rightBarButton = UIButton(type: .custom)
  let emptyView = EmptyView.autolayoutView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension HomeContentView {
  func showSearchButton() {
    guard rightBarButton.alpha == 0 else { return }
    
    let transform = CATransform3DRotate(CATransform3DIdentity, 0, 1, 0, 0)
    UIView.animate(withDuration: 0.3) {
      self.rightBarButton.layer.transform = transform
      self.rightBarButton.alpha = 1
    }
  }
  
  func hideSearchButton() {
    guard rightBarButton.alpha == 1 else { return }
    
    let transform = CATransform3DRotate(CATransform3DIdentity, .pi, 1, 0, 0)
    UIView.animate(withDuration: 0.3) {
      self.rightBarButton.alpha = 0
      self.rightBarButton.layer.transform = transform
    }
  }
}

private extension HomeContentView {
  func setupViews() {
    backgroundColor = .white
    setupCollectionView()
    setupHeaderView()
    setupEmptyView()
  }
  
  func setupCollectionView() {
    addSubview(collectionView)
    collectionView.backgroundColor = .white
    collectionView.keyboardDismissMode = .onDrag
    collectionView.contentInset = UIEdgeInsets(top: headerViewHeight, left: 0, bottom: 0, right: 0)
    collectionView.register(FlowerCollectionViewCell.self)
    if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
      flowLayout.scrollDirection = .vertical
      flowLayout.sectionInset = collectionViewDimensions.sectionInset
      flowLayout.minimumLineSpacing = collectionViewDimensions.lineSpacing
      flowLayout.minimumInteritemSpacing = collectionViewDimensions.interItemSpacing
    }
    collectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  func setupHeaderView() {
    addSubview(headerView)
    headerView.snp.makeConstraints {
      $0.leading.top.trailing.equalToSuperview()
      $0.height.equalTo(headerViewHeight)
    }
  }
  
  func setupEmptyView() {
    addSubview(emptyView)
    emptyView.text = "placeholder_no_content".localized()
    emptyView.snp.makeConstraints {
      $0.top.equalTo(headerView.snp.bottom)
      $0.leading.trailing.bottom.equalToSuperview()
    }
  }
}
