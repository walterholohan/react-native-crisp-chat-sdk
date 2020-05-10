//
//  CRispViewManager.swift
//  CrispChatSdk
//
//  Created by Walter Holohan on 09/05/2020.
//  Copyright © 2020 Facebook. All rights reserved.
//

import Foundation

@objc(CrispViewManager)
class CrispViewManager: RCTViewManager {
  override func view() -> UIView! {
    return CrispChatView()
  }
  override static func requiresMainQueueSetup() -> Bool {
    return true
  }
}
