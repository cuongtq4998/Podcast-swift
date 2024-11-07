//
//  MainTabBarController.swift
//  Podcast
//
//  Created by Nicolas Desormiere on 25/4/18.
//  Copyright © 2018 Nicolas Desormiere. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController, Rotatable {
  var viewsContainer: [UIView] {
    return [playerDetailsView]
  }
  
  enum ViewCanRotation: String {
    case inital
    case userManualFull
    case minizeMode
  }
  
  var state: ViewCanRotation = .inital {
    didSet {
      chanegOrientaton(state: state)
    }
  }
  
  private func chanegOrientaton(state: ViewCanRotation) {
    switch state {
    case .inital:
      resetToPortrait()
    case .userManualFull:
      break
    case .minizeMode:
      resetToPortrait()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    UINavigationBar.appearance().prefersLargeTitles = true
    
    tabBar.tintColor = .purple
    
    setupViewControllers()
    
    setupPlayerDetailsView()
  }
  
  @objc func minimizePlayerDetails() {
    maximizedTopAnchorConstraint.isActive = false
    bottomAnchorConstraint.constant = view.frame.height
    minimizedTopAnchorConstraint.isActive = true
    
    state = .minizeMode
    
    view.layoutIfNeeded()
    tabBar.transform = .identity
    playerDetailsView.maximizedStackView.alpha = 0
    playerDetailsView.miniPlayerView.alpha = 1
  }
  
  func maximizePlayerDetails(episode: Episode?, playlistEpisodes: [Episode] = [], userManual: Bool = false) {
    minimizedTopAnchorConstraint.isActive = false
    maximizedTopAnchorConstraint.isActive = true
    maximizedTopAnchorConstraint.constant = 0
    bottomAnchorConstraint.constant = 0
    
    if episode != nil {
      playerDetailsView.episode = episode
    }
    
    playerDetailsView.playlistEpisodes = playlistEpisodes
    state = !userManual ? .inital : .userManualFull
    
    view.layoutIfNeeded()
    tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
    playerDetailsView.maximizedStackView.alpha = 1
    playerDetailsView.miniPlayerView.alpha = 0
  }
  
  //MARK:- Setup Functions
  
  let playerDetailsView = PlayerDetailsView.initFromNib()
  var maximizedTopAnchorConstraint: NSLayoutConstraint!
  var minimizedTopAnchorConstraint: NSLayoutConstraint!
  var bottomAnchorConstraint: NSLayoutConstraint!
  
  fileprivate func setupPlayerDetailsView() {
    view.insertSubview(playerDetailsView, belowSubview: tabBar)
    playerDetailsView.translatesAutoresizingMaskIntoConstraints = false

    maximizedTopAnchorConstraint = playerDetailsView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height)
    maximizedTopAnchorConstraint.isActive = true
    bottomAnchorConstraint = playerDetailsView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: view.frame.height)
    bottomAnchorConstraint.isActive = true
    minimizedTopAnchorConstraint = playerDetailsView.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -64)
    
    playerDetailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    playerDetailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
  }
  
  func setupViewControllers() {
    let layout = UICollectionViewFlowLayout()
    let favoritesController = FavoritesController(collectionViewLayout: layout)
    viewControllers = [
      generateNavigationController(for: PodcastsSearchController(), menu: MenuItem(
        title: "Search",
        remoteImage: "https://images.fptplay53.net/media/photo/OTT/2024/08/13/normaltv_1723520994568.png",
        remoteImageSelection: "https://images.fptplay53.net/media/photo/OTT/2024/08/13/activetv_1723520483939.png",
        localImage: #imageLiteral(resourceName: "search"),
        localImageSelection: #imageLiteral(resourceName: "search"))
      ),
      generateNavigationController(for: favoritesController, menu: MenuItem(
        title: "Favorites",
        remoteImage: "https://images.fptplay53.net/media/photo/OTT/2024/08/13/normalvod_1723520974422.png",
        remoteImageSelection: "https://images.fptplay53.net/media/photo/OTT/2024/08/13/activevod_1723520974422.png",
        localImage: #imageLiteral(resourceName: "favorites"),
        localImageSelection: #imageLiteral(resourceName: "favorites"))
      ),
      generateNavigationController(for: DownloadsController(), menu: MenuItem(
        title: "Downloads",
        remoteImage: "https://images.fptplay53.net/media/photo/OTT/2024/08/13/normalsport_1723520924752.png",
        remoteImageSelection: "https://images.fptplay53.net/media/photo/OTT/2024/08/13/activesport_1723520571475.png",
        localImage: #imageLiteral(resourceName: "downloads"),
        localImageSelection: #imageLiteral(resourceName: "downloads"))
      )
    ]
  }
  
  //MARK:- Helper Functions
  
  fileprivate func generateNavigationController(for rootViewController: UIViewController, menu: MenuItem) -> UIViewController {
    let navController = UINavigationController(rootViewController: rootViewController)
    rootViewController.navigationItem.title = menu.title
    navController.tabBarItem.title = menu.title
    navController.tabBarItem.image = menu.localImage
    navController.tabBarItem.selectedImage = menu.localImageSelection
    return navController
  }

  
}

struct MenuItem {
  let title: String
  let remoteImage: String
  let remoteImageSelection: String
  let localImage: UIImage
  let localImageSelection: UIImage
  
  var remoteUIImage: UIImage?
  var remoteUIImageSelection: UIImage?
}
