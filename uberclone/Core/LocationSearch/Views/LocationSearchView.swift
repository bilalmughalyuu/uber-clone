import SwiftUI

struct LocationSearchView: View {
    @EnvironmentObject private var viewModel: LocationSearchViewModel
    @Binding var mapState: MapViewState
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(alignment: .top, spacing: 12) {
                VStack(spacing: 6) {
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width: 8, height: 8)
                    
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 1, height: 40)
                    
                    Circle()
                        .fill(.black)
                        .frame(width: 8, height: 8)
                }
                .padding(.vertical)
                
                VStack(spacing: 12) {
                    TextField("Current Location", text: $viewModel.startLocationText)
                        .padding(10)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    
                    TextField("Where to?", text: $viewModel.destinationLocationText)
                        .padding(10)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal)
            .padding(.top)
            
            //            Divider()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(viewModel.results, id: \.self) { result in
                        LocationSearchResultCell(
                            title: result.title,
                            subtitle: result.subtitle
                        )
                        .onTapGesture {
                            viewModel.selectLocation(result)
                            withAnimation(.spring()) {
                                mapState = .locationSelected
                            }
                            
                        }
                    }
                }
                .padding(.top, 8)
            }
        }
        .background(Color.white)
    }
}

#Preview {
    LocationSearchView(mapState: .constant(.searchingForLocation))
        .environmentObject(LocationSearchViewModel())
}
