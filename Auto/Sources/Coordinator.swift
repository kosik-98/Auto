import SwiftUI

protocol Coordinator: AnyObject {
    associatedtype Content: View

    var navigationPath: NavigationPath { get set }

    func start() -> Content
}
