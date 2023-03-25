import SwiftUI

struct HomePageView: View {
    @EnvironmentObject private var coordinator: Coordinator

    var body: some View {
        VStack {
            Button(action: {
                coordinator.command(.play(.sample_game))
            }, label: {
                Text("Play sample game")
            })
            Button(action: {
                coordinator.command(.help)
            }, label: {
                Text("Show help")
            })
        }
        .environmentObject(coordinator)
            .navigationTitle("Home")
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
