import SwiftUI

enum Sound {
    case tap
}

enum GameMenuItemType {
    case trueFalse, level
}

enum Command {
    case about, back, gameHelp(GameDescriptor), help, play(GameDescriptor), playSound(Sound), playResource(String), solved(GameDescriptor), settings
}

protocol HostedGame {
    var isDirty: Bool { get }
    var sharedContent: String? { get }
    var solvedView: AnyView? { get }
    func almostSolve() // debugging only
    func saveNotification()
    func start(viewModel: AnyObject)
    func menuItems() -> [String: GameMenuItemType]
}

protocol Host {
    func solved()
    func load() -> Decodable?
    func save(obj: Encodable)
    func delete()
    func playSound(_ id: Sound)
    func playResource(bundleName: String)
    func showHelp()
    func incMissCount()
    func incHintCount()
}

enum Page: Identifiable, Hashable {
    case home, game(GameDescriptor)

    var id: String { rawValue }

    var rawValue: String {
        switch self {
            case .home:
                return "home"
            case .game(let descriptor):
                return "game_\(descriptor.id)"
        }
    }
}

enum Sheet: Identifiable, Hashable {
    case help, gameHelp(GameDescriptor), share(String)

    var id: String { rawValue }

    var rawValue: String {
        switch self {
            case .help:
                return "help"
            case .gameHelp(let descriptor):
                return "help_\(descriptor.id)"
            case .share:
                return "share"
        }
    }
}

enum Cover: String, Identifiable, Hashable {
    case about, settings
    var id: String { rawValue }
}

let orderedGames: [GameDescriptor] = [.cryptogram, .crypto_families, .quotefalls, .sudoku, .word_search, .memory, .triplets, .sample_game]

enum GameDescriptor: String, Identifiable, CaseIterable {

    case cryptogram, crypto_families, quotefalls, sudoku, word_search, memory, triplets, sample_game

    var displayName: String {
        var name: String
        switch self {
            case .cryptogram:
                name = "Cryptogram"
            case .crypto_families:
                name = "Crypto-Families"
            case .quotefalls:
                name = "Quotefalls"
            case .sudoku:
                name = "Sudoku"
            case .word_search:
                name = "Word Search"
            case .memory:
                name = "Memory"
            case .triplets:
                name = "Triplets"
            case .sample_game:
                name = "Sample Game"
        }
        return name
    }

    var id: String { self.rawValue }

    var color: Color {
        switch self {
            case .cryptogram:
                return .red
            case .crypto_families:
                return .yellow
            case .quotefalls:
                return .green
            case .sudoku:
                return .blue
            case .word_search:
                return .pink
            case .memory:
                return .purple
            case .triplets:
                return .orange
            case .sample_game:
                return .cyan
        }
    }
}
