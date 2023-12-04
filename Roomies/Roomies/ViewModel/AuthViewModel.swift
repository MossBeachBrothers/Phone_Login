//
//  AuthViewModel.swift
//  Roomies
//
//  Created by Akhi Nair on 8/22/23.
//
import Foundation
import Firebase
import FirebaseAuth
import GoogleSignIn


class AuthViewModel: ObservableObject {
    // Published property to track the currently logged-in user
    @Published var currentUser: RoomiesUser?
    // Published property to track the user's login status
    @Published var isLoggedIn = false
    
    init() {
        // Check if a user is already logged in
        self.isLoggedIn = Auth.auth().currentUser != nil
        
        // If a user is already logged in, initialize the currentUser property
        if let user = Auth.auth().currentUser {
          self.currentUser = RoomiesUser(uid: user.uid,
                                         email: user.email ?? "",
                                         firstName: "",
                                         lastName: "",
                                         phoneNumber: "",
                                         friends: [],
                                         groups : [])
        }
        
        // Add a listener to track changes in the authentication state
        Auth.auth().addStateDidChangeListener { (auth, user) in
            // Update isLoggedIn based on whether a user is authenticated
            self.isLoggedIn = user != nil
            
            // Update currentUser based on the authentication state
            if let user = user {
              self.currentUser = RoomiesUser(uid: user.uid,
                                             email: user.email ?? "",
                                             firstName: "",
                                             lastName: "",
                                             phoneNumber: "",
                                             friends: [],
                                             groups : [])
            } else {
                self.currentUser = nil
            }
        }
    }
  
      
    
    //MARK: Log Out
    func logOut() {
        do {
            try Auth.auth().signOut()
            // Clear currentUser and set isLoggedIn to false
            currentUser = nil
            isLoggedIn = false
            print("Signed out")
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
  
  // Firestore references and collections
  
    
    //MARK: Sign in With Google
    func signInWithGoogle(completion : @escaping (Error?) -> Void){
       
    }
    
    
    // Fetch users and groups functions
       // ...
       //MARK: Add a Friend
    func addFriend(userID: String) {
           // Add a friend to the user's friends subcollection
//           Firestore.firestore().collection("users").document(userID).collection("friends").document().setData(["status": "accepted", "timestamp": FieldValue.serverTimestamp()])
//
//
        Firestore.firestore().collection("users").document(currentUser?.uid ?? "").collection("friends").document().setData(["friendID": userID, "status": "accepted", "timestamp": FieldValue.serverTimestamp()])

    }
    
  //MARK: Reconcile Group
    func reconcileGroup(){
        //set all debts to zero
        
   }
    
  //MARK: Confirm Debt Request
    func confirmDebtRequest(
        for user_id: String,
        debtRequest_id: String,
        group_id: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
      let db = Firestore.firestore()
      let groupRef = db.collection("Groups").document(group_id)
      let requestRef = groupRef.collection("DebtRequests").document(debtRequest_id)
      
      db.runTransaction({ (transaction, errorPointer) -> Any? in
          do {
              // Step 1: Update confirmationStatus in DebtRequest document
              let requestDoc = try transaction.getDocument(requestRef)
              var confirmationStatus = requestDoc.data()?["confirmationStatus"] as? [String: Bool] ?? [:]
              confirmationStatus[user_id] = true
              transaction.updateData(["confirmationStatus": confirmationStatus], forDocument: requestRef)
              
              // Step 2: Check if all users have confirmed
              let allConfirmed = confirmationStatus.values.allSatisfy { $0 }
              transaction.updateData(["allConfirmed": allConfirmed], forDocument: requestRef)
              
              // Step 3: Update groupTotalsConfirmed in Group document
              if allConfirmed {
                  // Fetch the DebtRequest document data
                  let requestData = requestDoc.data()
                  
                  if let amount = requestData?["amount"] as? Double {
                      // Update groupTotalsConfirmed based on the confirmed request
                      let groupTotalsConfirmedKey = "groupTotalsConfirmed.\(user_id)" // User-specific key
                      transaction.updateData([groupTotalsConfirmedKey: FieldValue.increment(Int64(amount))], forDocument: groupRef)
                  }
              }
              
              return nil
          } catch {
              // Convert Swift Error to NSError for Firestore
              let nsError = error as NSError
              errorPointer?.pointee = nsError
              return nil
          }
      }) { (_, error) in
          if let error = error {
              // Convert NSError back to Swift Error
              let swiftError = error as Error
              completion(.failure(swiftError))
          } else {
              completion(.success(()))
          }
      }
  }
    
  //MARK: Add Debt Request
  func addDebtRequest(
      senderUserIDs: [String],
      groupID: String,
      receiverUserIDs: [String],
      amount: Double,
      requestDescription: String,
      completion: @escaping (Result<Void, Error>) -> Void
  ) {
      var confirmationStatus: [String: Bool] = [:]
      for userID in receiverUserIDs {
          // Initialize confirmation status for each receiver as false
          confirmationStatus[userID] = false
      }

      var newDebtRequest = DebtRequest(
          senderUserIDs: senderUserIDs,
          groupID: groupID,
          receiverUserIDs: receiverUserIDs,
          amount: amount,
          requestDescription: requestDescription
      )

      // Add the debt request to the global requests collection
      let globalRequestsRef = Firestore.firestore().collection("requests")
      globalRequestsRef.addDocument(data: newDebtRequest.toFirestoreData()) { error in
          if let error = error {
              //handle error in completion
              completion(.failure(error))
          } else {
              // Add the same request to the group's requests collection
              let groupRequestsRef = Firestore.firestore().collection("groups").document(groupID).collection("requests")
              groupRequestsRef.addDocument(data: newDebtRequest.toFirestoreData()) { error in
                  if let error = error {
                    //handle error in completion
                      completion(.failure(error))
                  } else {
                      // Update allConfirmed if all confirmationStatus values are true
                      if confirmationStatus.values.allSatisfy({ $0 == true }) {
                          newDebtRequest.allConfirmed = true
                      }

                      // Update the allConfirmed field in Firestore
                      groupRequestsRef.document(newDebtRequest.id ?? "").updateData(["allConfirmed": newDebtRequest.allConfirmed])
                      
                      //handle success in completion
                      completion(.success(()))
                  }
              }
          }
      }
  }
    
    
  //MARK: Create Group
  func createGroup(adminID: String, memberIDs: [String], groupName: String) {
    
      //    var groupID: String
      //    var adminID: String
      //    var groupName: String
      //    var groupImg: Bool = false
      //    var groupTotalsUnconfirmed: [String: Int] // UserID : Int
      //    var groupTotalsConfirmed: [String: Int] // UserID : Int
      //    var members: [String : [String : String]] // UserID : [Role : String, Timstamp : String, Name : String]
      //    var timestamp: String // Time of group creation
      //    var debtRequests: [DebtRequest]
      // Create a reference to the "groups" collection
      let db = Firestore.firestore()
      let timestamp = Timestamp()
      let groupData: [String: Any] = [
          "groupID": "group_001",
          "adminID": "admin_001",
          "groupName": "Vacation Trip",
          "groupImg": false,
          "groupTotalsUnconfirmed": [
              "user_001": 100,
              "user_002": 50
          ],
          "groupTotalsConfirmed": [
              "user_001": 80,
              "user_002": 40
          ],
          "members": [
              "user_001": [
                  "Role": "Admin",
                  "Timestamp": "2023-10-31 14:00:00",
                  "Name": "Alice"
              ],
              "user_002": [
                  "Role": "Member",
                  "Timestamp": "2023-10-31 14:05:00", 
                  "Name": "Bob"
              ]
          ],
          "timestamp": "2023-10-31 13:55:00",
          "debtRequests": []
      ]
    var groupRef: DocumentReference? = nil
       groupRef = db.collection("groups").addDocument(data: groupData) { err in
           if let err = err {
               print("Error adding document: \(err)")
           } else if let groupID = groupRef?.documentID {
               print("Document added with ID: \(groupID)")
               
               // Adding the admin to the memberIDs array
               var allMemberIDs = memberIDs
               allMemberIDs.append(adminID)
               
               for userID in allMemberIDs {
                   // Determine the role
                   let role = (userID == adminID) ? "admin" : "member"
                   
                   // Define the user group data
                   let userGroupData: [String: Any] = [
                       "GroupID": groupID,
                       "Role": role,
                       "Timestamp": timestamp
                   ]
                   
                   // Add the group info to each user's Groups sub-collection
                   db.collection("Users").document(userID).collection("Groups").document(groupID).setData(userGroupData) { err in
                       if let err = err {
                           print("Error adding group to user's groups: \(err)")
                       } else {
                           print("Successfully added group to user's groups.")
                       }
                   }
               }
           }
       }
    
    
  
      // Add the group to the "groups" collection
//      let newGroupRef = groupsCollection.addDocument(data: groupData) { (error) in
//          if let error = error {
//              print("Error creating group: \(error.localizedDescription)")
//          } else {
//              print("Group created successfully!")
//              // Get the ID of the newly created group
//          }
//      }
      
//      if !newGroupRef.documentID.isEmpty {
//          let groupID = newGroupRef.documentID
//          self.addGroupIDToUser(adminID: adminID, groupID: groupID)
//      } else {
//          // Handle the case when newGroupRef.documentID is empty
//      }
  }

  //MARK: Add Group ID to User
  func addGroupIDToUser(adminID: String, groupID: String) {
      // Create a reference to the user's document in the "users" collection
      let userDocument = Firestore.firestore().collection("users").document(adminID)
      
      // Update the "groups" array field to add the new group ID
      userDocument.updateData([
          "groups": FieldValue.arrayUnion([groupID])
      ]) { error in
          if let error = error {
              print("Error adding group ID to user: \(error.localizedDescription)")
          } else {
              print("Group ID added to the user's document successfully!")
          }
      }
  }

    //MARK: Fetch Newly Created Group ID
    private func fetchNewlyCreatedGroupID(adminID: String, memberIDs: [String], groupName: String) {
           Firestore.firestore().collection("groups").whereField("groupName", isEqualTo: groupName).getDocuments { snapshot, error in
               if let error = error {
                   print("Error fetching group ID: \(error.localizedDescription)")
               } else {
                   guard let document = snapshot?.documents.first else {
                       print("Group document not found")
                       return
                   }
                   
                   let groupID = document.documentID
                   print("Fetched group ID: \(groupID)")
                   self.addMembersToGroup(adminID: adminID, groupID: groupID, memberIDs: memberIDs)
               }
           }
    }

    //MARK: Add Members to Group
    private func addMembersToGroup(adminID: String, groupID: String, memberIDs: [String]) {
           var batch = Firestore.firestore().batch()
           
           // Add the admin as a member with the "admin" role
           let adminMemberRef = Firestore.firestore().collection("groups").document(groupID).collection("members").document(adminID)
           batch.setData(["role": "admin", "timestamp": FieldValue.serverTimestamp()], forDocument: adminMemberRef)
           
           // Add other members with the "member" role
           for memberID in memberIDs {
               let memberRef = Firestore.firestore().collection("groups").document(groupID).collection("members").document(memberID)
               batch.setData(["role": "member", "timestamp": FieldValue.serverTimestamp()], forDocument: memberRef)
               
           // Add a reference to the group in the user's "groups" subcollection
           let userGroupsRef = Firestore.firestore().collection("users").document(memberID).collection("groups").document(groupID)
           batch.setData(["groupID": groupID], forDocument: userGroupsRef)
               
           }
           
           batch.commit { error in
               if let error = error {
                   print("Error adding members to group: \(error.localizedDescription)")
               } else {
                   print("Members added to group successfully!")
               }
           }
  }

  func getAllGroupsForUser(userID: String, completion: @escaping ([DocumentSnapshot]?) -> Void) {
      // Reference to the Firestore database
      let db = Firestore.firestore()

      // Fetch the groupIDs
      let userGroupsRef = db.collection("Users").document(userID).collection("Groups")
      userGroupsRef.getDocuments { (userGroupsSnapshot, error) in
          guard let userGroupsDocuments = userGroupsSnapshot?.documents, error == nil else {
              print("Error getting user groups:", error?.localizedDescription ?? "")
              completion(nil)
              return
          }

          guard !userGroupsDocuments.isEmpty else {
              completion([])
              return
          }

          let groupIDs = userGroupsDocuments.map { $0.documentID }

          // Reference to the groups collection
          let groupsRef = db.collection("groups")

          // A group to manage multiple asynchronous calls
          let dispatchGroup = DispatchGroup()

          // An array to store the fetched documents
          var groupDocs: [DocumentSnapshot] = []

          // Fetch each group document individually
          for groupID in groupIDs {
              dispatchGroup.enter()
              groupsRef.document(groupID).getDocument { (document, error) in
                  if let document = document, document.exists {
                      groupDocs.append(document)
                      print("document appeneded to groupDocs")
                  } else {
                      print("Error fetching group document:", error?.localizedDescription ?? "")
                  }
                  dispatchGroup.leave()
              }
          }
        print(groupDocs.capacity)
          // Completion handler after all documents are fetched
          dispatchGroup.notify(queue: .main) {
              completion(groupDocs)
          }
      }
  }








  //MARK:  Sign In With Email
    static func signInWithEmail(email: String, password: String, completion: @escaping (Error?) -> Void) {
        
        // completion: @escaping (Bool) -> Void
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(error)
                
            } else {
                print("Sucesss")
            }
        }
         
        //Auth.auth().signIn(withEmail: email, password: password)
    }
    
  //MARK: Sign in with Phone Number
    static func signInWithPhoneNumber(phone: String, password: String) {
        
        // completion: @escaping (Bool) -> Void
        
    }

  //MARK: Sign up with Email
    static func signUpWithEmail(email: String, password: String, user: RoomiesUser, completion: @escaping (Error?) -> Void){
        
    
        //completion: @escaping (Error?) -> Void) {
        
        print("Signing up with Email")
         
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(error)
            } else {
                if let uid = authResult?.user.uid {
                    let userData: [String: Any] = [
                        "uid": uid,
                        "email": user.email,
                        "firstName": user.firstName,
                        "lastName": user.lastName,
                        "phoneNumber": user.phoneNumber
                    ]
                    
//                     Save user data to Firestore
                    Firestore.firestore().collection("users").document(uid).setData(userData) { error in
                        completion(error)
                    }
                }
            }
        }
        
        //Auth.auth().createUser(withEmail: email, password: password)
    }
  
    //MARK: Get all Group Meta Deta
//    func getAllGroupMetaData(completion: @escaping ([GroupMetaData]?, Error?) -> Void) {
//        Firestore.firestore().collection("groups").getDocuments { snapshot, error in
//            if let error = error {
//                completion(nil, error)
//            } else {
//                var groupMetaDataList: [GroupMetaData] = []
//
//                for document in snapshot?.documents ?? [] {
//                    let data = document.data()
//                    let group_id = document.documentID
//                    let group_name = data["groupName"] as? String ?? ""
//                    let group_members = data["members"] as? [String] ?? []
//                    let last_request = data["lastRequest"] as? String ?? ""
//                    let timestamp = data["timestamp"] as? String ?? ""
//
//                    let groupMetaData = GroupMetaData(group_id: group_id,
//                                                      group_name: group_name,
//                                                      group_members: group_members,
//                                                      last_request: last_request,
//                                                      timestamp: timestamp)
//
//                    groupMetaDataList.append(groupMetaData)
//                }
//
//                completion(groupMetaDataList, nil)
//            }
//        }
//    }
//
    
    static func signUpWithPhoneNumber(phone: String, password: String, user: RoomiesUser, completion: @escaping (Error?) -> Void) {
        
        print("Signing up with Phone Number")
    }
    
    static func sendOTPCodeEmail(email : String, code: Int32){
        print("Sending OTP Through Email")
    }
    
    static func sendOTPCodePhone(phone : String, code: Int32){
        print("Sending OTP Through Phone")
    }
    

    func fetchUserData(for uid: String, completion: @escaping (Result<RoomiesUser, Error>) -> Void) {
        
            Firestore.firestore().collection("users").document(uid).getDocument { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                } else if let data = snapshot?.data(),
                          let firstName = data["firstName"] as? String,
                          let lastName = data["lastName"] as? String {
                    let fetchedUser = RoomiesUser(uid: uid,
                                                 email: data["email"] as? String ?? "",
                                                 firstName: firstName,
                                                 lastName: lastName,
                                                 phoneNumber: data["phoneNumber"] as? String ?? "",
                                                  friends: [],
                                                  groups : [])
                    completion(.success(fetchedUser))
                } else {
                    completion(.failure(NSError(domain: "Firestore", code: 0, userInfo: nil)))
                }
            }
        }
    
    func createGroup(){
        
    }
    

    func checkIfUserExists(email: String = "", phone: String = "", completion: @escaping (Bool) -> Void) {
        
        if !email.isEmpty{
            Auth.auth().fetchSignInMethods(forEmail: email) { signInMethods, error in
                if let error = error {
                    print("Error checking user existence: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                
                // If signInMethods is not empty, a user with the given email already exists
                let userExists = signInMethods != nil && !signInMethods!.isEmpty
                completion(userExists)
            }
        }
    }
    

    func resetUserPassword(email: String) {
        
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                if let error = error {
                    // Handle the error here
                    print("Error resetting password: \(error.localizedDescription)")
                    // You can display an alert or some UI to inform the user about the error
                } else {
                    // Reset password email sent successfully
                    // Update the state to indicate that the code has been sent
                }
            }
    }
    
    func isValidPhoneNumber(phone : String) -> Bool{
        /*
         Checks if the text within the email or phone field is a phone number
         */
        
        let phoneRegex = "^\\d{10}$" // Assumes a 10-digit number format

        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        
        
        return phonePredicate.evaluate(with: phone)
    }
    
    
    func isValidEmail(email : String) -> Bool{
        /*
         Checks if the text within the email or phone field is an email
         */
        
        let emailRegex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        
        return emailPredicate.evaluate(with: email)
    }
    
    
}
