//
//  ProfileViewController.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/2/14.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
  var storeManJim = StoreJimS.sharedJim
  @IBOutlet weak var collectionView: UICollectionView! {
    
    didSet {
      
      collectionView.delegate = self
      
      collectionView.dataSource = self
    }
  }
  
  let manager = ProfileManager()
  var total = 0
  override func viewDidLoad() {
    super.viewDidLoad()
    getData()
  }
  
  func getData() {
    let configuration = URLSessionConfiguration.default
    let session = URLSession(configuration: configuration)
    let shoppingCart = URL(string: "https://williamyhhuang.com/api/1.0/test")!
    var request = URLRequest(url: shoppingCart)
    request.httpMethod = "GET"
    
    let task = session.dataTask(with: request) {(data, response, error)  in
      guard let httpResponse = response as? HTTPURLResponse,
        httpResponse.statusCode == 200 else {return}
      
      guard let data = data else {
        return
      }
      let decoder = JSONDecoder()
      do {
        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        let result  = try decoder.decode(HistoryList.self, from: data)
        self.storeManJim.historyData = [result]
        for count1 in 0 ..< self.storeManJim.historyData[0].list.count {
          for count2 in 0 ..< self.storeManJim.historyData[0].list[count1].product.count {
            guard let money = Int(self.storeManJim.historyData[0].list[count1].product[count2].price) else {break }
            self.total += money
          }
        }
        self.storeManJim.totalMoney = self.total
        print(result)
      } catch {
        
      }
    }
    task.resume()
  }
  //
  //  func getDataFromSty() {
  //    let token = KeyChainManager.shared.token
  //    let configuration = URLSessionConfiguration.default
  //    let session = URLSession(configuration: configuration)
  //    let shoppingCart = URL(string: "https://williamyhhuang.com/api/1.0/user/profile")!
  //    var request = URLRequest(url: shoppingCart)
  //    request.httpMethod = "GET"
  //    request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
  //
  //    let task = session.dataTask(with: request) {(data, response, error)  in
  //      guard let httpResponse = response as? HTTPURLResponse,
  //        httpResponse.statusCode == 200 else {return}
  //
  //      guard let data = data else {
  //        return
  //      }
  //      let decoder = JSONDecoder()
  //      do {
  //        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
  //        let result  = try decoder.decode(FromSty.self, from: data)
  //        print(result)
  //      } catch {
  //
  //      }
  //    }
  //    task.resume()
  //  }
  
  func postLoginCall(){
    let email = UserDefaults.standard.value(forKey: "email")
    let shoppingCart = URL(string: "https://williamyhhuang.com/api/1.0/user/profile")!
    var request = URLRequest(url: shoppingCart)
    request.httpMethod = "POST"
    let postString = "emailaddress=\(email)"
    print(postString)
    request.httpBody = postString.data(using: String.Encoding.utf8)
    
    let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
      guard error == nil else {                                                          // check for fundamental networking error
        print("error=\(error)")
        return
      }
      guard let data = data else {
        return
      }
      let decoder = JSONDecoder()
      do {
        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        let result  = try decoder.decode(HistoryList.self, from: data)
        self.storeManJim.historyData = [result]
        for count1 in 0 ..< self.storeManJim.historyData[0].list.count {
          for count2 in 0 ..< self.storeManJim.historyData[0].list[count1].product.count {
            guard let money = Int(self.storeManJim.historyData[0].list[count1].product[count2].price) else {break }
            self.total += money
          }
        }
        self.storeManJim.totalMoney = self.total
        print(result)
      } catch {
        
      }
    }
    task.resume()
  }
}

extension ProfileViewController: UICollectionViewDataSource {
  //History
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if indexPath.section == 1 && indexPath.row == 0 {
      guard let vcc = UIStoryboard(name: "Jim", bundle: nil).instantiateViewController(identifier: "history") as?  HistoryViewController else {
        return
      }
      vcc.modalPresentationStyle = .overCurrentContext
      present(vcc, animated: true, completion: nil)
    } else if indexPath.section == 1 && indexPath.row == 3 {
      guard let vcc = UIStoryboard(name: "Jim", bundle: nil).instantiateViewController(identifier: "point")  as?  PointViewController else {
        return
      }
      vcc.modalPresentationStyle = .overCurrentContext
      present(vcc, animated: true, completion: nil)
    }else if indexPath.section == 1 && indexPath.row == 4 {
      guard let vc = UIStoryboard(name: "Chat", bundle: nil).instantiateViewController(identifier: "chat") as? ChatViewController else {
        return
      }
      vc.navigationController?.pushViewController(vc, animated: true)
      show(vc, sender: nil)
    }
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    
    return manager.groups.count
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return manager.groups[section].items.count
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: String(describing: ProfileCollectionViewCell.self),
      for: indexPath
    )
    
    guard let profileCell = cell as? ProfileCollectionViewCell else { return cell }
    
    let item = manager.groups[indexPath.section].items[indexPath.row]
    
    profileCell.layoutCell(image: item.image, text: item.title)
    
    return profileCell
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    viewForSupplementaryElementOfKind kind: String,
    at indexPath: IndexPath
  ) -> UICollectionReusableView {
    
    if kind == UICollectionView.elementKindSectionHeader {
      
      let header = collectionView.dequeueReusableSupplementaryView(
        ofKind: UICollectionView.elementKindSectionHeader,
        withReuseIdentifier: String(describing: ProfileCollectionReusableView.self),
        for: indexPath
      )
      
      guard let profileView = header as? ProfileCollectionReusableView else { return header }
      
      let group = manager.groups[indexPath.section]
      
      profileView.layoutView(title: group.title, actionText: group.action?.title)
      
      return profileView
    }
    
    return UICollectionReusableView()
  }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    
    if indexPath.section == 0 {
      
      return CGSize(width: UIScreen.width / 5.0, height: 60.0)
      
    } else if indexPath.section == 1 {
      
      return CGSize(width: UIScreen.width / 4.0, height: 60.0)
    }
    
    return CGSize.zero
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    insetForSectionAt section: Int
  ) -> UIEdgeInsets {
    
    return UIEdgeInsets(top: 24.0, left: 0, bottom: 0, right: 0)
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumLineSpacingForSectionAt section: Int
  ) -> CGFloat {
    
    return 24.0
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumInteritemSpacingForSectionAt section: Int
  ) -> CGFloat {
    
    return 0
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    referenceSizeForHeaderInSection section: Int
  ) -> CGSize {
    
    return CGSize(width: UIScreen.width, height: 48.0)
  }
}
