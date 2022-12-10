//
//  ContentView.swift
//  LostAndFound
//
//  Created by Remi Pacifico Hansen on 12/6/22.
//

import SwiftUI
import Firebase

struct LoginView: View {
    enum Field {
        case email, password
    }
    @State private var email = ""
    @State private var password = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var buttonsDisabled = true
    @State private var presentSheet = false
    @FocusState private var focusField: Field?
    var body: some View {
        ScrollView {
            Image("bceagle")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
                .padding()
            Text("Welcome to Lost 'n' Found!")
                .foregroundColor(Color("BC-Maroon"))
                .fontWeight(.bold)
                .font(Font.custom("Bodoni 72", size: 30))
            
            Group {
                TextField("Boston College E-Mail", text: $email)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .submitLabel(.next)
                    .focused($focusField, equals: .email)
                    .onSubmit {
                        focusField = .password
                    }
                    .onChange(of: email) { _ in
                        enableButtons()
                    }
                
                SecureField("Password", text: $password)
                    .textInputAutocapitalization(.never)
                    .submitLabel(.done)
                    .focused($focusField, equals: .password)
                    .onSubmit {
                        focusField = nil
                    }
                    .onChange(of: password) { _ in
                        enableButtons()
                    }
            }
            .textFieldStyle(.roundedBorder)
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.gray.opacity(0.5), lineWidth: 2)
            }
            .padding(.horizontal)
            
            HStack {
                Button {
                    register()
                } label: {
                    Text("Sign Up")
                }
                .padding(.trailing)
                
                Button {
                    login()
                } label: {
                    Text("Log In")
                }
                .padding(.leading)
                
            }
            .disabled(buttonsDisabled)
            .buttonStyle(.borderedProminent)
            .tint(Color("BC-Maroon"))
            .font(.title2)
            .padding(.top)
        }
        .alert(alertMessage, isPresented: $showingAlert) {
            Button("Ok", role: .cancel) {}
        }
        .onAppear{
            if Auth.auth().currentUser != nil {
                print("🪵 Login success")
                presentSheet = true
            }
        }
        .fullScreenCover(isPresented: $presentSheet) {
            ListView(post: Post())
        }
    }
    func enableButtons() {
        let emailIsGood = email.count >= 6 && email.contains("@bc.edu")
//        @bc.edu instead of just @
        let passwordIsGood = password.count >= 6
        buttonsDisabled = !(emailIsGood && passwordIsGood)
    }
    
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("😡 SIGN-UP ERROR: \(error.localizedDescription)")
                alertMessage = "😡 SIGN-UP ERROR: \(error.localizedDescription)"
                showingAlert = true
            }else {
                print("😎 Registration success")
                presentSheet = true
            }
        }
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("😡 LOGIN ERROR: \(error.localizedDescription)")
                alertMessage = "😡 LOGIN ERROR: \(error.localizedDescription)"
                showingAlert = true
            }else {
                print("🪵 Login success")
                presentSheet = true
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
            LoginView()
    }
}
