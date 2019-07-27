//
//  DetailContentView.swift
//  FlowrSpot
//
//  Created by Arijan Ljoki on 27/07/2019.
//  Copyright © 2019 PovioLabs. All rights reserved.
//

import PovioKit

class DetailContentView: UIView {
    let headerViewHeight: CGFloat = 450
    let headerView: FlowerHeaderView = FlowerHeaderView.loadView()
    let tableView = UITableView(frame: .zero, style: .grouped).autolayoutView()
    let emptyView = EmptyView.autolayoutView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension DetailContentView {
    func setupViews() {
        backgroundColor = .white
        setupTableView()
        setupHeaderView()
        setupEmptyView()
    }
    
    func setupTableView() {
        addSubview(tableView)
        tableView.backgroundColor = .white
        tableView.keyboardDismissMode = .onDrag
        tableView.contentInset = UIEdgeInsets(top: headerViewHeight, left: 0, bottom: 0, right: 0)
        
        let nibCell = UINib(nibName: SightingTableViewCell.identifier, bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: SightingTableViewCell.identifier)
        tableView.snp.makeConstraints {
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
