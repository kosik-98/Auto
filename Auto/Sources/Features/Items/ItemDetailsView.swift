import SwiftUI

struct ItemDetailsView: View {
    @StateObject private var viewModel: ItemDetailsViewModel

    init(viewModel: ItemDetailsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Item details")
                .font(.headline)

            if let timestamp = viewModel.timestamp {
                Text(timestamp, formatter: itemFormatter)
                    .font(.body)
            } else {
                Text("Not found")
                    .foregroundStyle(.secondary)
            }

            Spacer(minLength: 0)
        }
        .padding()
        .navigationTitle("Details")
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

