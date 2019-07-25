//
//  HomeViewController.swift
//  FlowrSpot
//
//  Created by TK on 16/01/2018.
//  Copyright © 2018 PovioLabs. All rights reserved.
//

import PovioKit

protocol HomeDisplayLogic: class {
  func displayFlowers(_ flowers: [Flower])
  func displayError(_ error: RemoteResourceError)
}

class HomeViewController: UIViewController {
  var interactor: HomeBusinessLogic?
  var router: HomeRoutingLogic?
  private lazy var contentView = HomeContentView.autolayoutView()
  private let flowersDataSource = FlowersDataSource()
  
  init(delegate: HomeRouterDelegate?) {
    super.init(nibName: nil, bundle: nil)
    let interactor = HomeInteractor()
    let presenter = HomePresenter()
    let router = HomeRouter()
    interactor.presenter = presenter
    presenter.viewController = self
    router.viewController = self
    router.delegate = delegate
    self.interactor = interactor
    self.router = router
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    loadData()
  }
}

// MARK: - Display Logic
extension HomeViewController: HomeDisplayLogic {
  func displayFlowers(_ flowers: [Flower]) {
    flowersDataSource.update(flowers: flowers)
    contentView.collectionView.reloadData()
    contentView.emptyView.isHidden = true
  }
  
  func displayError(_ error: RemoteResourceError) {
    router?.navigateToAlert(title: "general_error".localized(), message: error.localizedDescription, handler: nil)
    contentView.emptyView.isHidden = false
  }
}

// MARK: - UICollectionView Delegate
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return contentView.collectionViewDimensions.sizeForItem(at: indexPath, for: collectionView)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let row = flowersDataSource.row(at: indexPath) else {
      Logger.error("No availible row in dataSource at \(indexPath)")
      return
    }
    switch row {
    case let .flower(entity):
      router?.navigateToFlowerDetails(flower: entity)
    }
  }
}

// MARK: - UIScrollView Delegate
extension HomeViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let contentOffset = -scrollView.contentOffset.y
    
    let percentage = 1 - (contentOffset / contentView.headerViewHeight)
    
    var headerViewTranslation = -percentage * contentView.headerViewHeight
    if headerViewTranslation > 0 {
      headerViewTranslation = 0 // lock headerView
    }
    
    contentView.headerView.transform = CGAffineTransform.identity.translatedBy(x: 0, y: headerViewTranslation)
    
    switch percentage {
    case 0.75...:
      contentView.showSearchButton()
    case _:
      contentView.hideSearchButton()
    }
  }
}

// MARK: - Private methods
private extension HomeViewController {
  func setupViews() {
    navigationItem.title = "general_app_name".localized()
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: contentView.rightBarButton)
    setupContentView()
  }
  
  func setupContentView() {
    view.addSubview(contentView)
    contentView.snp.makeConstraints { $0.edges.equalToSuperview() }
    contentView.rightBarButton.setImage(#imageLiteral(resourceName: "plIconSearch"), for: .normal)
    contentView.rightBarButton.addTarget(self, action: #selector(barButtonPressed), for: .touchUpInside)
    contentView.collectionView.delegate = self
    contentView.collectionView.dataSource = flowersDataSource
  }
  
  func loadData() {
    interactor?.fetchFlowers()
  }
  
  @objc func barButtonPressed() {
    contentView.collectionView.setContentOffset(CGPoint(x: 0, y: -contentView.headerViewHeight), animated: true)
  }
}
