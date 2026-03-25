import SwiftUI
import CoreData

final class AppCoordinator: ObservableObject, Coordinator {
    typealias Content = AnyView

    @Published var navigationPath = NavigationPath()

    private let itemsListViewFactory: () -> AnyView
    private let itemDetailsViewFactory: (NSManagedObjectID) -> AnyView

    init(
        itemsListViewFactory: @escaping () -> AnyView,
        itemDetailsViewFactory: @escaping (NSManagedObjectID) -> AnyView
    ) {
        self.itemsListViewFactory = itemsListViewFactory
        self.itemDetailsViewFactory = itemDetailsViewFactory
    }

    func start() -> AnyView {
        let pathBinding = Binding<NavigationPath>(
            get: { self.navigationPath },
            set: { self.navigationPath = $0 }
        )

        return AnyView(
            NavigationStack(path: pathBinding) {
                itemsListViewFactory()
            }
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .itemDetails(let objectID):
                    self.itemDetailsViewFactory(objectID)
                }
            }
        )
    }

    func showItemDetails(objectID: NSManagedObjectID) {
        navigationPath.append(AppRoute.itemDetails(objectID: objectID))
    }
}

