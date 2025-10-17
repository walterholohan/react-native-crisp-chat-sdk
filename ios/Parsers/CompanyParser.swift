import Foundation
import Crisp

@objc
public class CompanyParser: NSObject {

    @objc
    public static func fromDictionary(_ dict: NSDictionary) -> Company {
        let name = dict.getStringOrNil(forKey: "name")

        var url: URL? = nil
        if let urlString = dict.getStringOrNil(forKey: "url"), !urlString.isEmpty {
            url = URL(string: urlString)
        }

        let companyDescription = dict.getStringOrNil(forKey: "companyDescription")

        var employment: Employment? = nil
        if let employmentDict = dict.getDictionaryOrNil(forKey: "employment") {
            employment = EmploymentParser.fromDictionary(employmentDict)
        }

        var geolocation: Geolocation? = nil
        if let geolocationDict = dict.getDictionaryOrNil(forKey: "geolocation") {
            geolocation = GeolocationParser.fromDictionary(geolocationDict)
        }

        return Company(
            name: name,
            url: url,
            companyDescription: companyDescription,
            employment: employment,
            geolocation: geolocation
        )
    }
}
