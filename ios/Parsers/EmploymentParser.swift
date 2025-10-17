import Foundation
import Crisp

@objc
public class EmploymentParser: NSObject {

    @objc
    public static func fromDictionary(_ dict: NSDictionary) -> Employment {
        let title = dict.getStringOrNil(forKey: "title")
        let role = dict.getStringOrNil(forKey: "role")
        return Employment(title: title, role: role)
    }
}
