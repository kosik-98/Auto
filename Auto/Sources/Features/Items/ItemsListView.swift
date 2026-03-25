import CoreData
import SwiftUI

struct ItemsListView: View {
    @StateObject private var viewModel: ItemsListViewModel
    @State private var editMode: EditMode = .inactive

    init(viewModel: ItemsListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        List {
            ForEach(viewModel.items, id: \.objectID) { item in
                Button {
                    guard editMode == .inactive else { return }
                    viewModel.itemTapped(objectID: item.objectID)
                } label: {
                    HStack {
                        Text(item.timestamp ?? Date(), formatter: itemFormatter)
                            .lineLimit(1)
                    }
                }
                .disabled(editMode != .inactive)
            }
            .onDelete(perform: deleteItems)
        }
        .environment(\.editMode, $editMode)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    editMode = (editMode == .active) ? .inactive : .active
                } label: {
                    Label(editMode == .active ? "Done" : "Edit", systemImage: editMode == .active ? "checkmark" : "pencil")
                }
            }
            ToolbarItem {
                Button(action: viewModel.addItem) {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
        .navigationTitle("Items")
    }

    private func deleteItems(offsets: IndexSet) {
        viewModel.deleteItems(offsets: offsets)
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ItemsListView(
        viewModel: ItemsListViewModel(
            repository: ItemsRepositoryImpl(context: PersistenceController.preview.container.viewContext),
            onItemSelected: { _ in }
        )
    )
}

