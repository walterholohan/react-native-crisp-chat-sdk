import Foundation
import Crisp

@objc
public class GeolocationParser: NSObject {

    @objc
    public static func fromDictionary(_ dict: NSDictionary) -> Geolocation {
        let country = dict.getStringOrNil(forKey: "country")
        let city = dict.getStringOrNil(forKey: "city")
        return Geolocation(city: city, country: country)
    }
}
