import CoreData
import SwiftUI
import Swinject

final class AppContainer {
    let container: Container

    init() {
        let container = Container()

        container.register(PersistenceController.self) { _ in
            PersistenceController.shared
        }

        container.register(NSManagedObjectContext.self) { r in
            r.resolve(PersistenceController.self)!.container.viewContext
        }

        container.register(ItemsRepository.self) { r in
            let context = r.resolve(NSManagedObjectContext.self)!
            return ItemsRepositoryImpl(context: context)
        }

        container.register(ItemsListViewModel.self) { (r: Resolver, onItemSelected: Any) in
            let repository = r.resolve(ItemsRepository.self)!
            let onItemSelected = onItemSelected as! (NSManagedObjectID) -> Void
            return ItemsListViewModel(repository: repository, onItemSelected: onItemSelected)
        }

        container.register(ItemDetailsViewModel.self) { (r: Resolver, objectID: Any) in
            let repository = r.resolve(ItemsRepository.self)!
            let objectID = objectID as! NSManagedObjectID
            return ItemDetailsViewModel(objectID: objectID, repository: repository)
        }

        container.register(AppCoordinator.self) { r in
            var coordinator: AppCoordinator?

            let itemsListViewFactory: () -> AnyView = {
                let repository = r.resolve(ItemsRepository.self)!
                let viewModel = ItemsListViewModel(
                    repository: repository,
                    onItemSelected: { (objectID: NSManagedObjectID) in
                        coordinator?.showItemDetails(objectID: objectID)
                    }
                )
                return AnyView(ItemsListView(viewModel: viewModel))
            }

            let itemDetailsViewFactory: (NSManagedObjectID) -> AnyView = { objectID in
                let repository = r.resolve(ItemsRepository.self)!
                let viewModel = ItemDetailsViewModel(objectID: objectID, repository: repository)
                return AnyView(ItemDetailsView(viewModel: viewModel))
            }

            coordinator = AppCoordinator(
                itemsListViewFactory: itemsListViewFactory,
                itemDetailsViewFactory: itemDetailsViewFactory
            )

            return coordinator!
        }

        self.container = container
    }
}

