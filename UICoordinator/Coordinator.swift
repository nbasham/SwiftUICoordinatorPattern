import SwiftUI

class Coordinator: ObservableObject {
    @Published var path = NavigationPath()
    @Published var sheet: Sheet?
    @Published var cover: Cover?

    private func push(_ page: Page) { path.append(page) }
    private func pop(_ page: Page) { path.removeLast() }
    private func popToRoot() { path.removeLast(path.count) }
    private func present(_ sheet: Sheet) { self.sheet = sheet }
    private func cover(_ cover: Cover) { self.cover = cover }
    private func dismissSheet() { self.sheet = nil }
    private func dismissCover() { self.cover = nil }

    func command(_ command: Command) {
        switch command {
            case .about:
                cover(.about)
            case .back:
                popToRoot()
            case .gameHelp(let game):
                present(.gameHelp(game))
            case .help:
                present(.help)
            case .play(let game):
                push(.game(game))
            case .playSound(_):
                print(command)
            case .playResource(_):
                print(command)
            case .solved(_):
                print(command)
            case .settings:
                print(command)
        }
    }

    @ViewBuilder
    func build(page: Page) -> some View {
        switch page {
            case .home:
                HomePageView()
            case .game(let descriptor):
                let vm = GamePageView.ViewModel(coordinator: self)
                GamePageView(game: descriptor, viewModel: vm)
        }
    }

    @ViewBuilder
    func build(sheet: Sheet) -> some View {
        switch sheet {
            case .help:
                HelpView()
            case .gameHelp(let descriptor):
                Text("\(descriptor.id)")
            case .share(let message):
                Text("\(message)")
        }
    }

    @ViewBuilder
    func build(cover: Cover) -> some View {
        switch cover {
            case .about:
                Text("About")
            case .settings:
                Text("Settings")
        }
    }
}
