import CoreData
import Foundation

final class ItemDetailsViewModel: ObservableObject {
    @Published private(set) var timestamp: Date?

    private let objectID: NSManagedObjectID
    private let repository: ItemsRepository

    init(objectID: NSManagedObjectID, repository: ItemsRepository) {
        self.objectID = objectID
        self.repository = repository
        load()
    }

    func load() {
        do {
            timestamp = try repository.fetchItem(objectID: objectID)?.timestamp
        } catch {
            assertionFailure("Failed to load item: \(error)")
            timestamp = nil
        }
    }
}

