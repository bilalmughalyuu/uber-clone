import SwiftUI

struct LocationSearchView: View {
    @State private var startLocationText: String = ""
    @State private var destinationLocationText: String = ""

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
                    TextField("Current Location", text: $startLocationText)
                        .padding(10)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)

                    TextField("Where to?", text: $destinationLocationText)
                        .padding(10)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal)
            .padding(.top)

//            Divider()

            // Results
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(0..<10, id: \.self) { _ in
                        LocationSearchResultCell()
                    }
                }
                .padding(.horizontal)
                .padding(.top, 8)
            }
        }
        .background(Color.white)
    }
}

#Preview {
    LocationSearchView()
}
