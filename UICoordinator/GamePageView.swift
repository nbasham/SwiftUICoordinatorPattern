import SwiftUI

struct GamePageView: View {
    var game: GameDescriptor
    @ObservedObject var viewModel: GamePageView.ViewModel

    init(game: GameDescriptor, viewModel: GamePageView.ViewModel) {
        self.game = game
        self.viewModel = viewModel
        self.viewModel.start(game)
    }

    var body: some View {
        viewModel.getGameView()
            .navigationBarTitle(viewModel.game?.displayName ?? "", displayMode: .inline)
            .navigationBarBackButtonHidden()
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(viewModel.game?.color ?? .green, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    ZStack(alignment: .trailing) {
                        Button(action: {
                            viewModel.back()
                        }, label: {
                            HStack {
                                Label("back", systemImage: "chevron.left.circle.fill")
                                    .imageScale(.large)
                                Text("back")
                                    .foregroundColor(.white)
                                    .fontWeight(.light)
                            }
                        })
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    if viewModel.showShareMenu {
                        shareMenuView()
                    } else {
                        menuView()
                    }
                }
            }
    }

    private func menuView() -> some View {
        Menu {
            Button("Help", action: { viewModel.showHelp() } )
            Button("Almost solve", action: { viewModel.almostSolve() } )
//            Button("Toggle settings soundOn", action: { settings.soundOn.toggle() } )
        }
    label: {
        HStack {
            Text("menu")
                .foregroundColor(.white)
                .fontWeight(.light)
            Label("menu", systemImage: "info.circle.fill")
                .imageScale(.large)
        }
    }
    }

    private func shareMenuView() -> some View {
        Button(action: { viewModel.showShare() }, label: {
            HStack {
                Text("share")
                    .foregroundColor(.white)
                    .fontWeight(.light)
                Image(systemName: "square.and.arrow.up.fill")
                    .imageScale(.large)
            }
        })
    }
}

extension GamePageView {
    class ViewModel: ObservableObject, Host {
        var game: GameDescriptor?
        var hostedGame: HostedGame?
        @ObservedObject var coordinator: Coordinator
        var isSolved = false

        init(coordinator: Coordinator) {
            self.coordinator = coordinator
        }

        func showShare() {
            print("show share")
        }

        func almostSolve() {
            print("almost solve")
        }

        func start(_ game: GameDescriptor) {
            self.game = game
        }

        func solved() {
            isSolved = true
            print("Solved")
        }

        func back() {
            coordinator.command(.back)
        }

        func load() -> Decodable? {
            print("load")
            return nil
        }

        func save(obj: Encodable) {
            print("save")
        }

        func delete() {
            print("delete")
        }

        func playSound(_ id: Sound) {
            print("playSound(\(id)")
           coordinator.command(.playSound(id))
        }

        func playResource(bundleName: String) {
            coordinator.command(.playResource(bundleName))
        }

        func incMissCount() {
            print("incMissCount")
        }

        func incHintCount() {
            print("incHintCount")
        }

        var showShareMenu: Bool {
            hostedGame?.sharedContent != nil && isSolved
        }

        func showHelp() {
            guard let game = game else {
                return
            }
            coordinator.command(.gameHelp(game))
        }

        func getGameView() -> some View {
            switch game {
                default:
                    isSolved = false
                    let vm = SampleGameView.ViewModel()
                    hostedGame = vm
                    return SampleGameView(host: self, viewModel: vm)
            }
        }
    }
}
struct GamePageView_Previews: PreviewProvider {
    static var previews: some View {
        GamePageView(game: .sample_game, viewModel: GamePageView.ViewModel(coordinator: Coordinator()))
    }
}
