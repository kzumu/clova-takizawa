//
//  DmPostCell.swift
//  clova-takizawa
//
//  Created by 下村一将 on 2018/07/22.
//  Copyright © 2018 kazu. All rights reserved.
//

import UIKit

class DmPostCell: UITableViewCell {

    @IBOutlet weak var isLikeLabel: UILabel!
    @IBOutlet weak var isReplyDescriptionLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        descriptionLabel.layer.masksToBounds = true
        descriptionLabel.layer.cornerRadius = 3.5
    }

    func set(_ dm: Dm) {
        switch dm.type {
        case .like(let c):
            isLikeLabel.isHidden = false
            isReplyDescriptionLabel.isHidden = true
            descriptionLabel.text = c.text
        case .post(let c):
            isReplyDescriptionLabel.isHidden = false
            isLikeLabel.isHidden = true
            descriptionLabel.text = c.text
        case _:
            ()
        }
        timeLabel.text = dm.timeDescription
    }
}
