import CoreData
import Foundation

final class ItemsListViewModel: ObservableObject {
    private let repository: ItemsRepository
    private let onItemSelected: (NSManagedObjectID) -> Void
    @Published private(set) var items: [Item] = []

    init(
        repository: ItemsRepository,
        onItemSelected: @escaping (NSManagedObjectID) -> Void
    ) {
        self.repository = repository
        self.onItemSelected = onItemSelected
        load()
    }

    func addItem() {
        do {
            try repository.addItem(date: Date())
            load()
        } catch {
            assertionFailure("Failed to add item: \(error)")
        }
    }

    func deleteItems(offsets: IndexSet) {
        let selectedItems = offsets.map { items[$0] }
        do {
            try repository.deleteItems(selectedItems)
            load()
        } catch {
            assertionFailure("Failed to delete items: \(error)")
        }
    }

    func itemTapped(objectID: NSManagedObjectID) {
        onItemSelected(objectID)
    }

    private func load() {
        do {
            items = try repository.fetchItems()
        } catch {
            assertionFailure("Failed to fetch items: \(error)")
            items = []
        }
    }
}

