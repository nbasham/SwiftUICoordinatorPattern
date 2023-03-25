import SwiftUI

struct HelpView: View {
    var body: some View {
        Text("This is how you do this and that.")
            .navigationTitle("Help")
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
