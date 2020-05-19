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
    func setTokenId(_ id: String) {
        Crisp.tokenId = id
    }
    
    @objc
    func setLocale(_ locale: String) {
        Crisp.locale = locale
    }
    
    @objc
    func setUserEmail(_ email: String) {
        Crisp.user.set(email: email)
    }
    
    @objc
    func setUserNickname(_ nickname: String) {
        Crisp.user.set(nickname: nickname)
    }
    @objc
    func setUserPhone(_ phone: String) {
        Crisp.user.set(phone: phone)
    }
    
    @objc
    func setUserAvatar(_ url: String) {
        Crisp.user.set(avatar: url)
    }
    @objc
    func setSessionSegment(_ segment: String) {
        Crisp.session.set(segment: segment)
    }
    
    @objc
    func resetSession() {
        Crisp.session.reset()
    }
    
    @objc
    static func requiresMainQueueSetup() -> Bool {
        return true
    }
}
