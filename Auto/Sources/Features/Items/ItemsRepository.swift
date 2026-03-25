import CoreData
import Foundation

protocol ItemsRepository {
    func addItem(date: Date) throws
    func deleteItems(_ items: [Item]) throws
    func fetchItems() throws -> [Item]
    func fetchItem(objectID: NSManagedObjectID) throws -> Item?
}

final class ItemsRepositoryImpl: ItemsRepository {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func addItem(date: Date) throws {
        let newItem = Item(context: context)
        newItem.timestamp = date
        try context.save()
    }

    func deleteItems(_ items: [Item]) throws {
        items.forEach(context.delete)
        try context.save()
    }

    func fetchItems() throws -> [Item] {
        let request = NSFetchRequest<Item>(entityName: "Item")
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)
        ]
        return try context.fetch(request)
    }

    func fetchItem(objectID: NSManagedObjectID) throws -> Item? {
        guard let item = try? context.existingObject(with: objectID) as? Item else {
            return nil
        }
        return item
    }
}

