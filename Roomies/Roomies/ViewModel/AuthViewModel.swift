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
  
  
    
    // MARK: Function to log out the user
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
  
    
    
    func signInWithGoogle(completion : @escaping (Error?) -> Void){
       
    }
    
    
    // Fetch users and groups functions
       // ...

    func addFriend(userID: String) {
           // Add a friend to the user's friends subcollection
//           Firestore.firestore().collection("users").document(userID).collection("friends").document().setData(["status": "accepted", "timestamp": FieldValue.serverTimestamp()])
//
//
        Firestore.firestore().collection("users").document(currentUser?.uid ?? "").collection("friends").document().setData(["friendID": userID, "status": "accepted", "timestamp": FieldValue.serverTimestamp()])

    }

    func reconcileGroup(){
        //set all debts to zero
        
   }
    
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
    
  
  func addDebtRequest(
      senderUserID: String,
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
          senderUserID: senderUserID,
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
    
    

    func createGroup(adminID: String, memberIDs: [String], groupName: String) {
           let groupData: [String: Any] = [
               "groupName": groupName,
               "adminID": adminID
           ]
           
           Firestore.firestore().collection("groups").addDocument(data: groupData) { error in
               if let error = error {
                   print("Error creating group: \(error.localizedDescription)")
               } else {
                   print("Group created successfully!")
                   self.fetchNewlyCreatedGroupID(adminID: adminID, memberIDs: memberIDs, groupName: groupName)
               }
           }
    }

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
    
    
    static func signInWithPhoneNumber(phone: String, password: String) {
        
        // completion: @escaping (Bool) -> Void
        
    }

    
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
                    
                    // Save user data to Firestore
                    Firestore.firestore().collection("users").document(uid).setData(userData) { error in
                        completion(error)
                    }
                }
            }
        }
        
        //Auth.auth().createUser(withEmail: email, password: password)
    }
    
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
