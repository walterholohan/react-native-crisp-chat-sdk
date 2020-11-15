import Crisp

@objc(CrispChatSdk)
class CrispChatSdk: NSObject {

    @objc
    func setTokenId(_ id: String) {
        CrispSDK.setTokenID(tokenID: id)
    }
    
    @objc
    func setUserEmail(_ email: String) {
        CrispSDK.user.email = email
    }
    
    @objc
    func setUserNickname(_ nickname: String) {
        CrispSDK.user.nickname = nickname
    }
    @objc
    func setUserPhone(_ phone: String) {
        CrispSDK.user.phone = phone
    }

    @objc
    func setUserAvatar(_ url: String) {
        CrispSDK.user.avatar = URL(string: url)
    }
    
    @objc
    func setSessionSegment(_ segment: String) {
        CrispSDK.session.segment = segment
    }
    
    @objc
    func pushSessionEvent(_ name: String, _ color: Crisp.SessionEventColor) {
        CrispSDK.session.pushEvent(SessionEvent(name: name, color: color))
    }

    @objc
    func resetSession() {
        CrispSDK.session.reset()
    }
    
    @objc
    func show() {
        DispatchQueue.main.async {
            UIApplication.shared.windows.first?.rootViewController?.present(ChatViewController(), animated: true)
        }
    }

    @objc
    static func requiresMainQueueSetup() -> Bool {
        return true
    }

}
