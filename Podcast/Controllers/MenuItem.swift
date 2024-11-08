//
//  MenuItem.swift
//  Podcast
//
//  Created by cuongtran on 11/8/24.
//  Copyright © 2024 Nicolas Desormiere. All rights reserved.
//

import UIKit

struct MenuItem {
  let title: String
  let remoteImage: String
  let remoteImageSelection: String
  let localImage: UIImage
  let localImageSelection: UIImage
  
  var remoteUIImage: UIImage?
  var remoteUIImageSelection: UIImage?
}

struct ControllerTabItem {
  let controller: UIViewController
  var menuItem: MenuItem
}
