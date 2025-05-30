import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Welcome")
            .navigationTitle("My App")
            .modifier(UniversalBackButtonModifier())
    }
}

struct UniversalBackButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
    }
}