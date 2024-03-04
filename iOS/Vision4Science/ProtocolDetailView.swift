import SwiftUI

struct ProtocolDetailView: View {
    @ObservedObject var viewModel: ProtocolDetailViewModel
    var protocolId: String

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                if let protocolItem = viewModel.protocolItem {
                    Group {
                        Text(protocolItem.title)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.top)

                        Divider()

                        if let reagents = protocolItem.reagents_objects, !reagents.isEmpty {
                            VStack(alignment: .leading) {
                                Text("Reagents and Objects:")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .padding(.vertical, 5)

                                ForEach(reagents, id: \.self) { reagent in
                                    HStack {
                                        Image(systemName: "circle.fill")
                                            .font(.caption)
                                            .foregroundColor(.blue)
                                        Text(reagent)
                                    }
                                    .padding(.leading, 10)
                                }
                            }
                        }

                        Divider()

                        if let steps = protocolItem.steps, !steps.isEmpty {
                            VStack(alignment: .leading) {
                                Text("Steps:")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .padding(.vertical, 5)

                                ForEach(steps.indices, id: \.self) { index in
                                    HStack(alignment: .top) {
                                        Text("\(index + 1).")
                                            .fontWeight(.bold)
                                        Text(steps[index])
                                    }
                                    .padding(.leading, 10)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                } else {
                    Spacer()
                    Text("Loading...")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
            }
        }
        .navigationTitle("Protocol Details")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchProtocolDetail(protocolId: protocolId)
        }
    }
}