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
  let provider = UserProvider()
  @IBOutlet weak var collectionView: UICollectionView! {
    
    didSet {
      
      collectionView.delegate = self
      
      collectionView.dataSource = self
    }
  }
  
  let manager = ProfileManager()
  var total = 0
  override func viewDidLoad() {
    
    let timer = Timer.scheduledTimer(
      timeInterval: 20.0, target: self, selector: Selector("doYourTask"),
    userInfo: nil, repeats: true)
    super.viewDidLoad()

  }
  
  @objc func doYourTask() {
      UserDefaults.standard.set(false, forKey: "sign")
  }
  //  func serviceData() {
  //    let configuration = URLSessionConfiguration.default
  //    let session = URLSession(configuration: configuration)
  //
  //    let shoppingCart = URL(string: "")!
  //    var request = URLRequest(url: shoppingCart)
  //    request.httpMethod = "GET"
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
  //        let result  = try decoder.decode(Services.self, from: data)
  //        self.storeManJim.servicesAnswer = [result]
  //        print(result)
  //      } catch {
  //
  //      }
  //    }
  //    task.resume()
  //  }
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
    } else if indexPath.section == 1 && indexPath.row == 4 {
      guard let vc = UIStoryboard(name: "Jim", bundle: nil).instantiateViewController(identifier: "chatJim") as? ChatJimViewController else {
        return
      }
      vc.navigationController?.pushViewController(vc, animated: true)
      show(vc, sender: nil)
    } else if indexPath.section == 1 && indexPath.row ==  1 {
      guard let vc = UIStoryboard(name: "Jim", bundle: nil).instantiateViewController(identifier: "Coupon") as? CouponViewController else {
        return
      }
      vc.navigationController?.pushViewController(vc, animated: true)
      show(vc, sender: nil)
    } else if indexPath.section == 1 && indexPath.row ==  5 {
      guard let vc = UIStoryboard(name: "Chat", bundle: nil).instantiateViewController(identifier: "chat") as? ChatViewController else {
        return
      }
      vc.navigationController?.pushViewController(vc, animated: true)
      show(vc, sender: nil)
    } else if indexPath.section == 0 && indexPath.row ==  4 {
      guard let vc = UIStoryboard(name: "second", bundle: nil).instantiateViewController(identifier: "refund") as? RefundViewController else {
        return
      }
      vc.navigationController?.pushViewController(vc, animated: true)
      show(vc, sender: nil)
    } else if indexPath.section == 1 && indexPath.row ==  2 {
      
      guard let isSign = UserDefaults.standard.value(forKey: "sign") as? Bool else { return }
      
      if isSign {
        self.fail()
      } else {
        guard let vc = UIStoryboard(name: "second", bundle: nil).instantiateViewController(identifier: "signin") as? SignInViewController else {
          return
        }
        vc.navigationController?.pushViewController(vc, animated: true)
        show(vc, sender: nil)
      }
    }
  }
  //  CouponViewController
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
  
  func fail() {
    
    let alert = UIAlertController(title: "簽到過了", message: "Success", preferredStyle: UIAlertController.Style.alert)
    let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
  }
}
