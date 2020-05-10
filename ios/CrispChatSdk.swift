//
//  CrispChatSdk.swift
//  CrispChatSdk
//
//  Created by Walter Holohan on 09/05/2020.
//  Copyright © 2020 Facebook. All rights reserved.
//

import Foundation
import Crisp

@objc(CrispChatSdk)
class CrispChatSdk: NSObject {
    
    @objc
    func setEmail(_ email: String) {
        Crisp.user.set(email: email)
    }
    
    @objc
    static func requiresMainQueueSetup() -> Bool {
        return true
    }
}
