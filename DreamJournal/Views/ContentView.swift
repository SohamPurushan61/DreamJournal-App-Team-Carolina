import SwiftUI
import OpenAI

struct ContentView: View {
    @State private var isLoggedIn = false

    var body: some View {
        Group {
            if isLoggedIn {
                MainAppView()
            } else {
                LoginSignupView(isLoggedIn: $isLoggedIn)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



