//
//  FlowerDetailViewController.swift
//  FlowrSpot
//
//  Created by Arijan Ljoki on 25/07/2019.
//  Copyright © 2019 PovioLabs. All rights reserved.
//

import PovioKit

protocol DetailDisplayLogic: class {
    func displayFlower(_ flower: Flower)
    func displayError(_ error: RemoteResourceError)
}

class FlowerDetailViewController: UIViewController {
    var interactor: DetailBusinessLogic?
    private lazy var contentView = HomeContentView.autolayoutView()
    private let flowerDataSource = FlowerDataSource()
    
    init(flowerId: Int) {
        super.init(nibName: nil, bundle: nil)
        let interactor = DetailInteractor()
        let presenter = DetailPresenter()
        interactor.presenter = presenter
        presenter.viewController = self
        self.interactor = interactor
        
        loadData(flowerId: flowerId)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

// MARK: - Display Logic
extension FlowerDetailViewController: DetailDisplayLogic {
    func displayFlower(_ flower: Flower) {
        flowerDataSource.update(flower: flower)
        contentView.collectionView.reloadData()
        contentView.emptyView.isHidden = true
    }
    
    func displayError(_ error: RemoteResourceError) {
//        router?.navigateToAlert(title: "general_error".localized(), message: error.localizedDescription, handler: nil)
        contentView.emptyView.isHidden = false
    }
}

// MARK: - UICollectionView Delegate
extension FlowerDetailViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return contentView.collectionViewDimensions.sizeForItem(at: indexPath, for: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let row = flowerDataSource.row(at: indexPath) else {
            Logger.error("No availible row in dataSource at \(indexPath)")
            return
        }
        switch row {
        case let .flower(entity):
            print(entity)
            return
//            router?.navigateToFlowerDetails(flower: entity)
        }
    }
}

// MARK: - UIScrollView Delegate
extension FlowerDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset = -scrollView.contentOffset.y
        
        let percentage = 1 - (contentOffset / contentView.headerViewHeight)
        
        var headerViewTranslation = -percentage * contentView.headerViewHeight
        if headerViewTranslation > 0 {
            headerViewTranslation = 0 // lock headerView
        }
        
        contentView.headerView.transform = CGAffineTransform.identity.translatedBy(x: 0, y: headerViewTranslation)
    }
}

// MARK: - Private methods
private extension FlowerDetailViewController {
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
        contentView.collectionView.dataSource = flowerDataSource
    }
    
    func loadData(flowerId: Int) {
        interactor?.fetchFlower(flowerId: flowerId)
    }
    
    @objc func barButtonPressed() {
        contentView.collectionView.setContentOffset(CGPoint(x: 0, y: -contentView.headerViewHeight), animated: true)
    }
}
