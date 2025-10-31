import Crisp
import Foundation
import React

@objc(NativeCrispModuleSwift)
public class NativeCrispModuleSwift: NSObject {

    @objc public static let shared = NativeCrispModuleSwift()

    @objc
    public func configure(_ websiteId: String) {
        CrispSDK.configure(websiteID: websiteId)
    }

    @objc
    public func setTokenId(_ tokenID: String?) {
        CrispSDK.setTokenID(tokenID: tokenID)
    }

    @objc
    public func setUserEmail(_ email: String, signature: String?) {
        CrispSDK.user.email = email
        CrispSDK.user.signature = signature
    }

    @objc
    public func setUserNickname(_ nickname: String) {
        CrispSDK.user.nickname = nickname
    }

    @objc
    public func setUserPhone(_ phone: String) {
        CrispSDK.user.phone = phone
    }

    @objc
    public func setUserCompany(_ companyData: NSDictionary) {
        let company = CompanyParser.fromDictionary(companyData)
        CrispSDK.user.company = company
    }

    @objc
    public func setUserAvatar(_ url: String) {
        CrispSDK.user.avatar = URL(string: url)
    }

    @objc
    public func setSessionSegment(_ segment: String) {
        CrispSDK.session.segment = segment
    }

    @objc
    public func setSessionSegments(_ segments: NSArray, overwrite: Bool) {
        let segmentsArray = segments.compactMap { $0 as? String }
        CrispSDK.session.setSegments(segmentsArray, overwrite: overwrite)
    }

    @objc
    public func setSessionString(_ key: String, value: String) {
        CrispSDK.session.setString(value, forKey: key)
    }

    @objc
    public func setSessionBool(_ key: String, value: Bool) {
        CrispSDK.session.setBool(value, forKey: key)
    }

    @objc
    public func setSessionInt(_ key: String, value: Double) {
        CrispSDK.session.setInt(Int(value), forKey: key)
    }

    @objc
    public func getSessionIdentifier(
        _ resolve: RCTPromiseResolveBlock,
        rejecter reject: RCTPromiseRejectBlock
    ) {
        let sessionIdentifier = CrispSDK.session.identifier
        if let identifier = sessionIdentifier {
            resolve(identifier)
        } else {
            resolve(NSNull())
        }
    }

    @objc
    public func pushSessionEvent(_ eventName: String, colorValue: Double) {
        let color = convertIntegerToColor(Int(colorValue))
        CrispSDK.session.pushEvent(Crisp.SessionEvent(name: eventName, color: color))
    }

    @objc
    public func pushSessionEvents(_ events: NSArray) {
        var sessionEvents: [Crisp.SessionEvent] = []

        for event in events {
            if let eventDict = event as? NSDictionary,
               let name = eventDict["name"] as? String,
               let colorValue = eventDict["color"] as? NSNumber {
                let color = convertIntegerToColor(colorValue.intValue)
                sessionEvents.append(Crisp.SessionEvent(name: name, color: color))
            }
        }

        CrispSDK.session.pushEvents(sessionEvents)
    }

    private func convertIntegerToColor(_ colorInt: Int) -> Crisp.SessionEventColor {
        switch colorInt {
        case 0: return .red
        case 1: return .orange
        case 2: return .yellow
        case 3: return .green
        case 4: return .blue
        case 5: return .purple
        case 6: return .pink
        case 7: return .brown
        case 8: return .grey
        case 9: return .black
        default: return .black
        }
    }

    @objc
    public func resetSession() {
        CrispSDK.session.reset()
    }

    @objc
    public func show() {
        DispatchQueue.main.async {
            var viewController = RCTPresentedViewController()

            if viewController == nil {
                if #available(iOS 15.0, *) {
                    viewController = UIApplication.shared.connectedScenes
                        .compactMap { $0 as? UIWindowScene }
                        .flatMap { $0.windows }
                        .first { $0.isKeyWindow }?
                        .rootViewController
                } else {
                    viewController = UIApplication.shared.windows.first?.rootViewController
                }
            }

            viewController?.present(ChatViewController(), animated: true)
        }
    }

    @objc
    public func searchHelpdesk() {
        CrispSDK.searchHelpdesk()
    }

    @objc
    public func openHelpdeskArticle(_ id: String, locale: String, title: String?, category: String?) {
        CrispSDK.openHelpdeskArticle(locale: locale, slug: id, title: title, category: category)
    }

    @objc
    public func runBotScenario(_ id: String) {
        CrispSDK.session.runBotScenario(id: id)
    }

}
