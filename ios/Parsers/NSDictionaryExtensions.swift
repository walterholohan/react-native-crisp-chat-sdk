import Foundation

extension NSDictionary {

    func getStringOrNil(forKey key: String) -> String? {
        guard let value = self[key], !(value is NSNull) else {
            return nil
        }
        return value as? String
    }

    func getDictionaryOrNil(forKey key: String) -> NSDictionary? {
        guard let value = self[key], !(value is NSNull) else {
            return nil
        }
        return value as? NSDictionary
    }

    func getArrayOrNil(forKey key: String) -> NSArray? {
        guard let value = self[key], !(value is NSNull) else {
            return nil
        }
        return value as? NSArray
    }

    func getDoubleOrNil(forKey key: String) -> Double? {
        guard let value = self[key], !(value is NSNull) else {
            return nil
        }
        return value as? Double
    }

    func getIntOrNil(forKey key: String) -> Int? {
        guard let value = self[key], !(value is NSNull) else {
            return nil
        }
        return value as? Int
    }

    func getBoolOrNil(forKey key: String) -> Bool? {
        guard let value = self[key], !(value is NSNull) else {
            return nil
        }
        return value as? Bool
    }
}
