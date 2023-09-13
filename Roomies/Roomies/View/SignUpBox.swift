//
//  SignUpBox.swift
//  Roomies
//
//  Created by Akhi Nair on 8/21/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseCore
import GoogleSignIn

enum InputType {
    case email
    case phone
}

struct SignUpBox : View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State private var first_name : String = ""
    @State private var last_name : String = ""
    
    @State private var input_type : InputType = .email
    
    @State private var email_or_phone : String = ""
    
    @State private var password : String = ""
    @State private var repeat_password : String = ""
    
    @State var isPasswordValid : Bool = false
    
    @State private var errorMessage : String = ""
    @State private var emailPhoneErrorMessage : String = ""
    @State private var highlightedFields: Set<Int> = []
    
    @State private var isPasswordVisible : Bool = false
    
    @State private var verifyCode : Bool = false
        
    
    var body: some View {
        
        var isPasswordValid : Bool {
            PasswordReqView(password: $password).isPasswordValid()
        }
        
        if !verifyCode{
            
            ScrollView(showsIndicators: true){
                
                VStack(alignment: .center) {
                    
                    Text("Sign Up")
                        .foregroundColor(.gray)
                        .font(GlobalFonts.titleFont)
                        .fontWeight(.semibold)
                    
                    CustomTextField(hint: "First Name", text: $first_name)
                        .modifier(HighlightModifier(index: 0,
                                                    errorMessages : [$errorMessage],
                                                    highlightedFields: $highlightedFields))
                    
                    CustomTextField(hint: "Last Name", text: $last_name)
                        .modifier(HighlightModifier(index: 1,
                                                    errorMessages : [$errorMessage],
                                                    highlightedFields: $highlightedFields))
                    
                    
                    CustomTextField(hint: "Email or Phone", text: $email_or_phone)
                        .modifier(HighlightModifier(index: 2,
                                                    errorMessages: [$errorMessage, $emailPhoneErrorMessage],
                                                    
                                                    highlightedFields: $highlightedFields))
                    Text(emailPhoneErrorMessage)
                        .font(GlobalFonts.captionFont)
                        .foregroundColor(Color.red)
                    
                    PasswordField(hint: "Password", password: $password)
                        .modifier(HighlightModifier(index: 3,
                                                    errorMessages : [$errorMessage],
                                                    highlightedFields: $highlightedFields))
                    
                    PasswordReqView(password : $password)
                    
                    PasswordField(hint: "Repeat Password", password: $repeat_password)
                        .modifier(HighlightModifier(index: 4,
                                                    errorMessages : [$errorMessage],
                                                    highlightedFields: $highlightedFields))
                    
                    HStack(spacing: 4) {
                        Text("- Passwords match")
                            .foregroundColor(passwordsMatch() ? .green : .red)
                            .font(GlobalFonts.captionFont)
                        
                        Spacer()
                    }
                    
                    //Spacer()
                    VStack {
                        
                        Text(errorMessage)
                            .font(GlobalFonts.captionFont)
                            .foregroundColor(Color.red)
                        
                        Spacer().frame(height: 10)
                        
                        Button (action: {validateFields(validpassword: isPasswordValid)}){
                            
                            Text("Sign Up")
                                .font(GlobalFonts.bodyFont)
                            
                        }
                        .buttonStyle(RoomiesButtonStyle())
                        
                        
                        HStack{
                            
                            Rectangle()
                                .fill(Color.gray)
                                .frame(maxWidth: .infinity, maxHeight: 1)
                            
                            Text("or")
                                .foregroundColor(.gray)
                            
                            Rectangle()
                                .fill(Color.gray)
                                .frame(maxWidth: .infinity, maxHeight: 1)
                        }
                        .padding(.horizontal)
                        
                        
                        //Sign in with Google Button
                        
                        Button (action: {}) {
                            
                            HStack {
                                
                                Image("btn_google_dark_normal_ios")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                
                                Text("Sign Up with Google")
                                    .font(GlobalFonts.bodyFont)
                                    .foregroundColor(.white)
                                    .padding()
                            }
                        }
                        .buttonStyle(RoomiesButtonStyle(color: Color.blue, pad_top: 0,
                                                        pad_bottom : 0, pad_left : 0, pad_right : 0))
                    }
                }
                .padding()
                
            }
        }
        
        else {
                        
            GetCodeBox(input_type : input_type,
                       email_or_phone: email_or_phone,
                       exitFunc: signUpUser)
        }
    }
    
    func passwordsMatch() -> Bool{
        /*
         Check if the two passwords match each other
         */
        if (password == repeat_password) && !password.isEmpty{
            print("Passwords match")
            return true
        }
        print("Passwords do NOT match")
        return false
        
    }
    
    func isValidEmailOrPhone() -> Bool {
        /*
         Determine if the input is a valid email or phone
         */
        
        // Input is a valid email
        if authViewModel.isValidEmail(email: email_or_phone){
            input_type = .email
            return true
        }
        
        // Input is a valid phone
        else if authViewModel.isValidPhoneNumber(phone: email_or_phone){
            input_type = .phone
            return true
        }
        
        // Input is neither a valid email or phone
        return false
        
    }
    
    
    func validateFields(validpassword : Bool) {
        
        errorMessage = ""
        emailPhoneErrorMessage = ""
        
        var invalid_fields : Bool = false
        
        if first_name.isEmpty {
            highlightedFields.insert(0)
            invalid_fields = true
        }
        if last_name.isEmpty {
            highlightedFields.insert(1)
            invalid_fields = true
        }
        if !isValidEmailOrPhone() {
            highlightedFields.insert(2)
            emailPhoneErrorMessage = "Invalid Email or Phone Number"
            invalid_fields = true
        }
        
        print("Checking if email is already in use")
        authViewModel.checkIfUserExists(email: email_or_phone){ exists in
            if exists {
                highlightedFields.insert(2)
                emailPhoneErrorMessage = "Email already in use"
                invalid_fields = true
              print("email is already in use")
            }
          else{
            print("email is NNOOOTTT already in use")
          }
        }
        
        
        if !validpassword {
            highlightedFields.insert(3)
            invalid_fields = true
        }
        
        if !passwordsMatch() {
            highlightedFields.insert(4)
            invalid_fields = true
        }
                  
        if invalid_fields{
          
            errorMessage = "Please fix the highlighted fields"
            return
        }
      else{
        print("all the fields are invalid")
      }
        
        //If all fields are correct, send code and move to the verification code screen
        
        verifyCode = true
    }
    
    func signUpUser(){
        
        
        let newUser = RoomiesUser(
            uid: "",
            email: email_or_phone,
            firstName: first_name,
            lastName: last_name,
            phoneNumber: "",
            friends: [],
            groups: []
        )
        
        if input_type == .email{
            
            print("Signing Up with Email")
            
            AuthViewModel.signUpWithEmail(email: email_or_phone,
                                        password: password,
                                          user: newUser){ result in
                if let result = result {
                    print(result.localizedDescription)
                } else {
                    print("Success")
                }
                                          }
        }
        else if input_type == .phone{
            
            print("Signing in with Phone")
            
            AuthViewModel.signUpWithPhoneNumber(phone: email_or_phone,
                                            password: password,
                                            user: newUser){ result in
                                            print(result)}
        }
        
    }
    
    func signInWithGoogle(){
        /*
         Signs the User in with Google
         */
        
    }
        
}


// Modifier to handle highlighting
struct HighlightModifier: ViewModifier {
    
    let index: Int
    
    @State var errorMessages : [Binding<String>]
    @Binding var highlightedFields: Set<Int>
    
    func body(content: Content) -> some View {
            
        content
            .border(highlightedFields.contains(index) ? Color.red : Color.clear)
            .onTapGesture {
                highlightedFields.remove(index) // Remove highlighting on tap
                
                for index in errorMessages.indices {
                    errorMessages[index].wrappedValue = ""
                }
                
            }
    }
}


struct  SignUpBox_Preview : PreviewProvider {
    
    static var previews: some View {
        ContentView()
            .environmentObject(AuthViewModel()) // Inject an instance of AuthViewModel for preview
    }
}
