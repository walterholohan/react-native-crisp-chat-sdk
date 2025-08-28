import Crisp

@objc(CrispChatSdk)
class CrispChatSdk: NSObject {

    @objc
    func configure(_ websiteId: String) {
        CrispSDK.configure(websiteID: websiteId)
    }

    @objc
    func setTokenId(_ tokenID: String?) {
        CrispSDK.setTokenID(tokenID : tokenID)
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
    func setSessionString(_ key: String, value: String) {
        CrispSDK.session.setString(value, forKey: key)
    }

    @objc
    func setSessionBool(_ key: String, value: Bool) {
        CrispSDK.session.setString(String(value), forKey: key)
    }

    @objc
    func setSessionInt(_ key: String, value: Int) {
        CrispSDK.session.setInt(value, forKey: key)
    }

    @objc
    func pushSessionEvent(_ eventName: String, color: Crisp.SessionEventColor) {
        CrispSDK.session.pushEvent(Crisp.SessionEvent(name: eventName, color: color))
    }

    @objc
    func resetSession() {
        CrispSDK.session.reset()
    }

    @objc
    func show() {
        DispatchQueue.main.async {
            var viewController = RCTPresentedViewController()

            if viewController == nil {
                viewController = UIApplication.shared.windows.first?.rootViewController
            }

            viewController?.present(ChatViewController(), animated: true)
        }
    }

     @objc
    func searchHelpdesk() {
        CrispSDK.searchHelpdesk()
    }

    @objc
    func openHelpdeskArticle(_ id : String, locale: String, title: String?, category: String?) {
        CrispSDK.openHelpdeskArticle(locale: locale, slug: id, title: title, category: category)
    }

    @objc
    static func requiresMainQueueSetup() -> Bool {
        return true
    }

}
