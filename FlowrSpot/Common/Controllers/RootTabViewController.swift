//
//  RootTabViewController.swift
//  FlowrSpot
//
//  Created by TK on 16/01/2018.
//  Copyright © 2018 PovioLabs. All rights reserved.
//

import UIKit

class RootTabViewController: UITabBarController {
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
    
    private var selectedItem = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
  }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        // Animation for transition when selecting tabbar items
        UIView.transition(with: tabBar,
                          duration: 0.3,
                          options: [.allowUserInteraction, .transitionCrossDissolve],
                          animations: {
        }, completion: nil)
        
        // Selecting same item twice, will result in scrolling to top of the screen.
        if selectedItem == item.tag {
            if let base = selectedViewController?.children.last as? HomeViewController {
                base.scrollToTop()
            }
        }
        
        selectedItem = item.tag
    }
}

// MARK: - Private Methods
private extension RootTabViewController {
  func setupViews() {
    tabBar.barTintColor = .white
    tabBar.tintColor = .red
    
    UITabBarItem.appearance().setTitleTextAttributes([:], for: .normal)
    
    let homeViewController = HomeViewController(delegate: nil)
    let homeNavigationController = NavigationViewController(rootViewController: homeViewController)
    let viewControllers = [homeNavigationController, UIViewController(), UIViewController(), UIViewController()]
    setViewControllers(viewControllers, animated: true)
    
    if let items = tabBar.items, items.count == viewControllers.count {
        setupTabBarItem(items[0], using: #imageLiteral(resourceName: "favoritesIcons"), title: nil, tag: 0)
      setupTabBarItem(items[1], using: #imageLiteral(resourceName: "commentIcon"), title: nil, tag: 1)
      setupTabBarItem(items[2], using: #imageLiteral(resourceName: "sightingListIcon"), title: nil, tag: 2)
      setupTabBarItem(items[3], using: #imageLiteral(resourceName: "newSightingIcon"), title: nil, tag: 3)
    }
  }
  
    func setupTabBarItem(_ item: UITabBarItem, using image: UIImage?, title: String?, tag: Int) {
    item.image = image
    item.title = title
    item.tag = tag
    item.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
  }
}
