import Crisp

@objc(CrispChatSdk)
class CrispChatSdk: NSObject {

    @objc
    func configure(_ websiteId: String) {
        CrispSDK.configure(websiteID: websiteId)
    }

    @objc
    func setTokenId(_ tokenID: String?) {
        CrispSDK.setTokenID(tokenID: tokenID)
    }

     @objc
    func setUserEmail(_ email: String, signature: String?) {
        CrispSDK.user.email = email
        CrispSDK.user.signature = signature
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
    func setUserCompany(_ companyData: [String: Any]) {
        let companyName: String? = companyData["name"] as? String
        
        var companyUrl: URL? = nil
        if let urlString: String = companyData["url"] as? String, !urlString.isEmpty {
            companyUrl = URL(string: urlString)
        }
        
        let companyDescription: String? = companyData["companyDescription"] as? String
        
        var employment: Employment? = nil
        if let employmentData: [String : Any] = companyData["employment"] as? [String: Any] {
            let title: String? = employmentData["title"] as? String
            let role: String? = employmentData["role"] as? String
            employment = Employment(title: title, role: role)
        }
        
        var geolocation: Geolocation? = nil
        if let geolocationData: [String : Any] = companyData["geolocation"] as? [String: Any] {
            let city: String? = geolocationData["city"] as? String
            let country: String? = geolocationData["country"] as? String
            geolocation = Geolocation(city: city, country: country)
        }
        
        let company = Company(
            name: companyName,
            url: companyUrl,
            companyDescription: companyDescription,
            employment: employment,
            geolocation: geolocation
        )
        
        CrispSDK.user.company = company
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
    func setSessionSegments(_ segments: NSArray, overwrite: Bool) {
        let segmentsArray = segments.compactMap { $0 as? String }
        CrispSDK.session.setSegments(segmentsArray, overwrite: overwrite)
    }

    @objc
    func setSessionString(_ key: String, value: String) {
        CrispSDK.session.setString(value, forKey: key)
    }

    @objc
    func setSessionBool(_ key: String, value: Bool) {
        CrispSDK.session.setBool(value, forKey: key)
    }

    @objc
    func setSessionInt(_ key: String, value: Int) {
        CrispSDK.session.setInt(value, forKey: key)
    }

    @objc
    func getSessionIdentifier(
        _ resolve: RCTPromiseResolveBlock, rejecter reject: RCTPromiseRejectBlock
    ) {
        let sessionIdentifier = CrispSDK.session.identifier
        if let identifier = sessionIdentifier {
            resolve(identifier)
        } else {
            resolve(NSNull())
        }
    }

    @objc
    func pushSessionEvent(_ eventName: String, color: NSInteger) {
        let sessionEventColor = convertIntegerToColor(color)
        CrispSDK.session.pushEvent(Crisp.SessionEvent(name: eventName, color: sessionEventColor))
    }

    @objc
    func pushSessionEvents(_ events: NSArray) {
        var sessionEvents: [Crisp.SessionEvent] = []

        for event in events {
            if let eventDict = event as? [String: Any],
               let name = eventDict["name"] as? String,
               let colorInt = eventDict["color"] as? NSInteger {
                let sessionEventColor = convertIntegerToColor(colorInt)
                sessionEvents.append(Crisp.SessionEvent(name: name, color: sessionEventColor))
            }
        }

        CrispSDK.session.pushEvents(sessionEvents)
    }

    private func convertIntegerToColor(_ colorInt: NSInteger) -> Crisp.SessionEventColor {
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
    func openHelpdeskArticle(_ id: String, locale: String, title: String?, category: String?) {
        CrispSDK.openHelpdeskArticle(locale: locale, slug: id, title: title, category: category)
    }
    
    @objc
    func runBotScenario(_ id: String) {
        CrispSDK.runBotScenario(id)
    }

    @objc
    static func requiresMainQueueSetup() -> Bool {
        return true
    }

}
