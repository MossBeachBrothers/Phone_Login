import Foundation
import FirebaseFirestore

struct RoomiesGroup : Hashable {
    var groupID: String
    var adminID: String
    var groupName: String
    var groupImg: Bool
    var groupTotalsUnconfirmed: [String: Int]
    var groupTotalsConfirmed: [String: Int]
    var members: [String: [String: String]] // Assuming this is the format for members
    var timestamp: String
    var debtRequests: [DebtRequest]

    init?(dictionary: [String: Any], id: String) {
        guard let adminID = dictionary["adminID"] as? String,
              let groupName = dictionary["groupName"] as? String,
              let groupImg = dictionary["groupImg"] as? Bool,
              let groupTotalsUnconfirmed = dictionary["groupTotalsUnconfirmed"] as? [String: Int],
              let groupTotalsConfirmed = dictionary["groupTotalsConfirmed"] as? [String: Int],
              let members = dictionary["members"] as? [String: [String: String]],
              let timestamp = dictionary["timestamp"] as? String else {
            return nil
        }

        self.groupID = id
        self.adminID = adminID
        self.groupName = groupName
        self.groupImg = groupImg
        self.groupTotalsUnconfirmed = groupTotalsUnconfirmed
        self.groupTotalsConfirmed = groupTotalsConfirmed
        self.members = members
        self.timestamp = timestamp

        // Initialize debtRequests
        if let debtRequestsData = dictionary["debtRequests"] as? [[String: Any]] {
            self.debtRequests = debtRequestsData.compactMap { data in
                // Convert each dictionary into a DebtRequest object
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data)
                    return try JSONDecoder().decode(DebtRequest.self, from: jsonData)
                } catch {
                    print("Error decoding DebtRequest data: \(error)")
                    return nil
                }
            }
        } else {
            self.debtRequests = []
        }
    }
  
    func toFirestoreData() -> [String: Any] {
            var data: [String: Any] = [:]
            
            data["groupID"] = groupID
            data["adminID"] = adminID
            data["groupName"] = groupName
            data["groupImg"] = groupImg
            data["groupTotalsUnconfirmed"] = groupTotalsUnconfirmed
            data["groupTotalsConfirmed"] = groupTotalsConfirmed
            data["members"] = members
            data["timestamp"] = timestamp

            // Convert each DebtRequest to a Firestore-compatible format
            data["debtRequests"] = debtRequests.map { $0.toFirestoreData() }

            return data
    }
}
