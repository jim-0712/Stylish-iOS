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
  private init() {}
  var historyData = [HistoryList]()
  var refundData = [WantRefund]()
//  var servicesAnswer = [Services]()
  var lottery = [Lottery]()
  var totalMoney = 0
  var id = 0
  var email = ""
}
