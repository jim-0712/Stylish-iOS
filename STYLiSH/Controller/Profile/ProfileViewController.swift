//
//  ProfileViewController.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/2/14.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView! {

        didSet {

            collectionView.delegate = self

            collectionView.dataSource = self
        }
    }

    let manager = ProfileManager()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension ProfileViewController: UICollectionViewDataSource {
  //History
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if indexPath.section == 1 && indexPath.row == 0 {
      guard let vcc = storyboard?.instantiateViewController(identifier: "history") as?  HistoryViewController else {
        return
      }
      vcc.modalPresentationStyle = .overCurrentContext
      present(vcc, animated: true, completion: nil)
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
