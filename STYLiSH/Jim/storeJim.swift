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
  var lottery = [Lottery]()
  var refundNum = [ResponseWhy]()
  var signFeedBack = [SignFeedBack]()
  var signBack = [SignIn]()
  var totalMoney = 0
  var id = 0
  var email = ""
  
  var reallyTicketUse = 0
  var totalProductMoney = 0
  var totalFreight = 0
  var discount = 0
  var freeDelivery = 0
  
  var finalProductMoney = 0
  var finalFreeDelivey = 0
  
  var productBackNumber = 0
  var orderNumber = 0
  
  var commentProductId = ""
  var productBack = [BackComment]()
  
  var totalPoints = 0
  var clickOrNot = false
}
