//
//  LoginSignupView.swift
//  DreamJournal
//
//  Created by Soham Purushan on 4/10/24.
//

import SwiftUI

struct LoginSignupView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @Binding var isLoggedIn: Bool

    var body: some View {
        ZStack {
            // Gradient Background
            LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            Image(systemName: "star.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30)
                .position(x: 75, y: 470)
                .foregroundColor(.white)

            Image(systemName: "cloud.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 35)
                .position(x:320, y: 470)
                .foregroundColor(.white)

            Image(systemName:"moon.stars.fill")
                .resizable()
                .scaledToFit()
                .frame(width :50)
                .position(x: 190, y: 200)
                .foregroundColor(.white)

            // Login/Signup Form
            VStack {
                // Dream Journal Text
                Text("Dream Journal")
                    .font(.system(size: 45, weight: .bold, design: .rounded)) // Larger and bubbly font
                    .foregroundColor(.white)
                    .shadow(color: .gray, radius: 2, x: 0, y: 2) // Drop shadow
                    .padding(.bottom, 5)

                TextField("Username", text: $username)
                    .padding(.horizontal, 20) // Smaller horizontally
                    .padding(.vertical, 8) // Smaller vertically
                    .background(Color.white)
                    .cornerRadius(10)
                    .frame(width: 280, height: 40) // Set the height and maximum width of the text field
                    .padding(.bottom, 20)

                SecureField("Password", text: $password)
                    .padding(.horizontal, 20) // Smaller horizontally
                    .padding(.vertical, 8) // Smaller vertically
                    .background(Color.white)
                    .cornerRadius(10)
                    .frame(width: 280, height: 40) // Set the height and maximum width of the text field
                    .padding(.bottom, 20)

                Button(action: {
                    isLoggedIn = true
                }) {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 180, height: 50)
                        .background(Color.purple)
                        .cornerRadius(15.0)
                }

                NavigationLink(destination: Text("")) {
                    Text("Sign Up")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .underline()
                }
            }
            .padding()
        }
    }
}

struct LoginSignupView_Previews: PreviewProvider {
    static var previews: some View {
        LoginSignupView(isLoggedIn: .constant(true))
    }
}
