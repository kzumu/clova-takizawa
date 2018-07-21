//
//  ClovaSpeechListCell.swift
//  clova-takizawa
//
//  Created by 下村一将 on 2018/07/22.
//  Copyright © 2018 kazu. All rights reserved.
//

import UIKit

class ClovaSpeechListCell: UITableViewCell {
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var likeCountLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func set(_ chat: Chat) {
        descriptionLabel.text = chat.text
        likeCountLabel.text = "\(chat.likeCount)"
        timeLabel.text = chat.timeDescription
    }
}
