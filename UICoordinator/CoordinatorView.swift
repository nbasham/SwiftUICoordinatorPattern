import SwiftUI

/*
 Showing sheets I'm getting
 Presenting view controller from detached view controller is discouraged.

 Sound https://github.com/twostraws/Subsonic?ref=iosexample.com
 */
struct CoordinatorView: View {
    @StateObject private var coordinator = Coordinator ()

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(page: .home)
                .navigationDestination(for: Page.self) { page in
                    coordinator.build(page: page)
                }
                .sheet(item: $coordinator.sheet) { sheet in
                    coordinator.build(sheet: sheet)
                }
                .fullScreenCover (item: $coordinator.cover) { cover in
                    coordinator.build(cover: cover)
                }
        }
        .environmentObject(coordinator)
    }
}

struct CoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        CoordinatorView()
    }
}


/*  VIEW MODEL

 HOME

 HOST
    save
    load
    delete
    solved

 GAME
    isDirty
    saveNotification
    sharedContent
    menuOptions (name and type)
    show(GameViewModel)
    solvedView
 */

/*
 ROUTES
 home page
 game page
 help
 about
 contact
 options
 gameHelp(descriptor)
 share

 */

/*      COMMANDS
 SHARED
 play(.sound)
 play("sound")
 gameCompleted(descriptor)

 HOME
 show survey
 contact us
 show message
 help
 play game
 options
    use sound
    show incorrect
    show timer
    use haptics

 GAME
 appDidBecomeActive
 appWillResign
 back
 help(descriptor)
 options(descriptor)
    solve
    almost solve
    help
    start again
    level

CRYPTOGRAM
 CRYPTO-FAMILIES
 QUOTEFALLS
 SUDOKU
    keyboard side
    show col/row highlight
    undo
    complete last number
 MEMORY
 WORD-SEARCH
    show hide clues
 */
