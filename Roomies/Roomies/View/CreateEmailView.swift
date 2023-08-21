
/*
 
 import SwiftUI
 import FirebaseAuth
 
 struct CreateEmailView: View {
 @State private var email: String = ""
 @State private var password: String = ""
 @State private var showAlert: Bool = false
 @Binding var currentPage: String?
 var body: some View {
 NavigationView {
 ScrollView(.vertical, showsIndicators: false) {
 VStack(alignment: .leading, spacing: 20) {
 Image(systemName: "square")
 .font(.system(size: 30))
 .foregroundColor(.indigo)
 
 VStack(alignment: .leading, spacing: 5) {
 Text("Roomies")
 .foregroundColor(.pink)
 .font(.title)
 .fontWeight(.semibold)
 
 Text("Create an Account")
 .foregroundColor(.gray)
 .font(.title)
 .fontWeight(.semibold)
 }
 .lineSpacing(10)
 .padding(.top, 20)
 .padding(.trailing, 15)
 
 TextField("Email", text: $email)
 .textFieldStyle(RoundedBorderTextFieldStyle())
 .foregroundColor(.black)
 .padding(.horizontal)
 .background(Color("TextFieldBackground"))
 .cornerRadius(10)
 
 SecureField("Password", text: $password)
 .textFieldStyle(RoundedBorderTextFieldStyle())
 .foregroundColor(.black)
 .padding(.horizontal)
 .background(Color("TextFieldBackground"))
 .cornerRadius(10)
 
 Button(action: {
 Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
 if let error = error {
 print(error.localizedDescription)
 }
 
 else {
 showAlert = true
 }
 // ...
 }
 }
 
 ) {
 Text("Sign Up")
 .font(.headline)
 .foregroundColor(.white)
 .padding()
 .frame(maxWidth: .infinity)
 .background(Color.pink)
 .cornerRadius(10)
 }
 .padding(.top, 20)
 .alert(isPresented: $showAlert) {
 Alert(
 title: Text("Success"),
 message: Text("Account created!"),
 dismissButton: .default(Text("OK"))
 )
 }
 
 Button("Back to Login") {
 currentPage = "Login"
 }
 }
 .padding()
 .background(Color("Background").ignoresSafeArea())
 .background()
 }
 }
 }
 }
 
 struct CreateEmailView_Previews: PreviewProvider {
 static var previews: some View {
 Login()
 }
 }
 
 */
