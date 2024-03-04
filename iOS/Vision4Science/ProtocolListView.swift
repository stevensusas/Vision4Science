import SwiftUI

struct ProtocolListView: View {
    @ObservedObject var viewModel: ProtocolViewModel
    var userId: String
    
    init(userId: String) {
        self.userId = userId
        self.viewModel = ProtocolViewModel(userId: userId)
    }

    var body: some View {
        NavigationView {
            List(viewModel.protocols) { protocolItem in
                NavigationLink(destination: ProtocolDetailView(viewModel: ProtocolDetailViewModel(userId: userId), protocolId: protocolItem.id)) {
                    VStack(alignment: .leading) {
                        Text(protocolItem.title)
                            .font(.headline)
                        Text(protocolItem.description)
                            .font(.subheadline)
                    }
                }
            }
            .navigationTitle("Protocols")
            .navigationBarItems(trailing: NavigationLink(destination: ProtocolInputView(viewModel: viewModel)) {
                Image(systemName: "plus")
            })
        }
    }
}
