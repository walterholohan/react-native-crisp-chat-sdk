//
//  CrispChatView.swift
//  CrispChatSdk
//
//  Created by Walter Holohan on 09/05/2020.
//  Copyright © 2020 Facebook. All rights reserved.
//

import UIKit
import Crisp

class CrispChatView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.addSubview(crispChat)
  }
  override func layoutSubviews() {
    super.layoutSubviews()
    self.crispChat.frame = self.bounds
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  lazy var crispChat: UIView = {
    let crispView = CrispView()
    crispView.frame = self.bounds
    crispView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    return crispView
  }()
}
