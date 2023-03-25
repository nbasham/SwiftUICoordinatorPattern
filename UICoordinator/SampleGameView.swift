import SwiftUI

struct SampleGameView: View {
    let host: Host
    let viewModel: SampleGameView.ViewModel

    var body: some View {
        VStack {
            Text("SampleGameView")
            Button(action: {
                host.playSound(.tap)
                host.showHelp()
            }, label: {
                Text("Sample button")
            })
        }
    }
}

extension SampleGameView {
    class ViewModel: ObservableObject, HostedGame {
        var isDirty: Bool = false

        var sharedContent: String?

        var solvedView: AnyView?

        func almostSolve() {
            print("almostSolve")
        }

        func saveNotification() {
            print("saveNotification")
        }

        func start(viewModel: AnyObject) {
            print("")
        }

        func menuItems() -> [String : GameMenuItemType] {
            print("menuItems")
            return [:]
        }

    }
}

struct SampleGameView_Previews: PreviewProvider {
    static var previews: some View {
        SampleGameView(host: GamePageView.ViewModel(coordinator: Coordinator()), viewModel: SampleGameView.ViewModel())
    }
}
