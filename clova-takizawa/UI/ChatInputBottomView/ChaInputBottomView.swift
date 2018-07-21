//
//  ChatRoomInputView.swift
//  lime
//
//  Created by 下村一将 on 2017/10/30.
//  Copyright © 2017 kazu. All rights reserved.
//

import UIKit

class ChatInputView: UIView {
    @IBOutlet weak var chatTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setFromXib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setFromXib()
    }

    func setFromXib() {
        let view = R.nib.chatInputBottomView.firstView(owner: self)!
        view.bounds = frame
        self.addSubview(view)
    }
}
