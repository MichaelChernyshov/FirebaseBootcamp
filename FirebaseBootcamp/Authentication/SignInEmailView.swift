//
//  SignInEmailView.swift
//  FirebaseBootcamp
//
//  Created by Mikhail Chernyshov on 28/5/24.
//

import SwiftUI

@MainActor
final class SignInEmailViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func signIn () {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
        
        Task {
            do {
                let returnedData = try await AuthenticationManager.shared.createUser(email: email, password: password)
                print("Success")
                print(returnedData)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

struct SignInEmailView: View {
    @StateObject private var vm = SignInEmailViewModel()
    
    var body: some View {
        VStack {
            TextField("Email...", text: $vm.email)
                .padding()
                .background(.gray.opacity(0.4))
                .cornerRadius(10)
            
            SecureField("Password...", text: $vm.password)
                .padding()
                .background(.gray.opacity(0.4))
                .cornerRadius(10)
            
            Button {
                vm.signIn()
            } label: {
                Text("Sign in")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .cornerRadius(10)
            }

        }
        .padding()
        .navigationTitle("Sign In With Email")
    }
}

#Preview {
    NavigationStack {
        SignInEmailView()
    }
}
