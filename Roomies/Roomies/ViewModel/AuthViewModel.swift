//
//  AuthViewModel.swift
//  Roomies
//
//  Created by Akhi Nair on 8/22/23.
//
import Foundation
import Firebase

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
            self.currentUser = RoomiesUser(uid: user.uid,email: user.email ?? "", firstName: "", lastName: "", phoneNumber: "")
        }
        
        // Add a listener to track changes in the authentication state
        Auth.auth().addStateDidChangeListener { (auth, user) in
            // Update isLoggedIn based on whether a user is authenticated
            self.isLoggedIn = user != nil
            
            // Update currentUser based on the authentication state
            if let user = user {
                self.currentUser = RoomiesUser(uid: user.uid, email: user.email ?? "", firstName: "", lastName: "", phoneNumber: "")
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
    
    static func signInWithEmail(email: String, password: String) {
        
        // completion: @escaping (Bool) -> Void
        /*
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Sign-in error: \(error.localizedDescription)")
                completion(false)
            } else {
                completion(true)
            }
        }
         */
        Auth.auth().signIn(withEmail: email, password: password)
    }
    
    
    static func signInWithPhoneNumber(phone: String, password: String) {
        
        // completion: @escaping (Bool) -> Void
        
    }

    
    static func signUpWithEmail(email: String, password: String, user: RoomiesUser){
    
        //completion: @escaping (Error?) -> Void) {
        /*
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
         */
        //Auth.auth().createUser(withEmail: email, password: password)
        print("Signing up with Email")
    }
    
    static func signUpWithPhoneNumber(phone: String, password: String, user: RoomiesUser) {
        
        // completion: @escaping (Bool) -> Void
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
                                                 phoneNumber: data["phoneNumber"] as? String ?? "")
                    completion(.success(fetchedUser))
                } else {
                    completion(.failure(NSError(domain: "Firestore", code: 0, userInfo: nil)))
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
