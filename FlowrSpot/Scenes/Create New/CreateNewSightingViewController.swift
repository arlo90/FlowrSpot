//
//  CreateNewSightingViewController.swift
//  FlowrSpot
//
//  Created by Arijan Ljoki on 27/07/2019.
//  Copyright © 2019 PovioLabs. All rights reserved.
//

import UIKit

class CreateNewSightingViewController: UIViewController {
    
    init(flower: Flower) {
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "create_new_title".localized()
    }
}
