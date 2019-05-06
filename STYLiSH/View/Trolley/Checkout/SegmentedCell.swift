//
//  SegmentedCell.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/3/7.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import UIKit

class SegmentedCell: UITableViewCell {

    @IBOutlet weak var segmentedControl: UISegmentedControl!

    var valueChangedHandler: ((String) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()

        segmentedControl.addTarget(self, action: #selector(segmentedControlDidChangeValue(_:)), for: .valueChanged)
    }

    @objc func segmentedControlDidChangeValue(_ sender: UISegmentedControl) {

        guard let text = sender.titleForSegment(at: sender.selectedSegmentIndex) else { return }

        valueChangedHandler?(text)
    }
}
