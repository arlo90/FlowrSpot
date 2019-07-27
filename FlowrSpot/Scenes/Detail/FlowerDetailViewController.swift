//
//  FlowerDetailViewController.swift
//  FlowrSpot
//
//  Created by Arijan Ljoki on 25/07/2019.
//  Copyright © 2019 PovioLabs. All rights reserved.
//

import PovioKit

protocol DetailDisplayLogic: class {
    func displayFlower(_ flower: Flower, sightings: [Sighting])
    func displayError(_ error: RemoteResourceError)
}

class FlowerDetailViewController: UIViewController {
    var interactor: DetailBusinessLogic?
    private lazy var contentView = DetailContentView.autolayoutView()
    private let flowerDataSource = FlowerDataSource()
    var router: DetailRoutingLogic?
    
    init(flowerId: Int, delegate: DetailRouterDelegate?) {
        super.init(nibName: nil, bundle: nil)
        let interactor = DetailInteractor()
        let presenter = DetailPresenter()
        let router = DetailRouter()
        interactor.presenter = presenter
        presenter.viewController = self
        router.viewController = self
        router.delegate = delegate
        self.interactor = interactor
        self.router = router
        
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
    func displayFlower(_ flower: Flower, sightings: [Sighting]) {
        navigationItem.title = flower.name
        flowerDataSource.update(sightings: sightings)
        
        // Here we should calculate height of header view, so it changes based on description size.
        // Currently its hardcoded.
        
        contentView.headerView.setup(flower: flower, router: router)
        contentView.tableView.reloadData()
        contentView.emptyView.isHidden = true
    }
    
    func displayError(_ error: RemoteResourceError) {
        contentView.emptyView.isHidden = false
    }
}

// MARK: - UITableView Delegate
extension FlowerDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Navigate on selection of cell
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
        
        // Based on offset we could add pagination for Sightings and fetch next page/size when scroll is closing to end.
        
        contentView.headerView.transform = CGAffineTransform.identity.translatedBy(x: 0, y: headerViewTranslation)
    }
}

// MARK: - Private methods
private extension FlowerDetailViewController {
    func setupViews() {
        navigationController?.navigationBar.tintColor = UIColor.flowrPinkishTan
        setupContentView()
    }
    
    func setupContentView() {
        view.addSubview(contentView)
        contentView.snp.makeConstraints { $0.edges.equalToSuperview() }
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = flowerDataSource
    }
    
    func loadData(flowerId: Int) {
        interactor?.fetchFlower(flowerId: flowerId)
    }
    
    // Funcion loadMore could be added for pagination.
}
