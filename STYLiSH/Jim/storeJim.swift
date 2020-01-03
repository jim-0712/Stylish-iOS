//
//  storeJim.swift
//  STYLiSH
//
//  Created by Jim on 2020/1/3.
//  Copyright © 2020 WU CHIH WEI. All rights reserved.
//

import Foundation
import UIKit

class StoreJimS {
  static let sharedJim = StoreJimS()
  
  var historyData = [HistoryList]()
  var totalMoney = 0
}
