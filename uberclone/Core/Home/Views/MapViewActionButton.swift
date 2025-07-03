import SwiftUI

struct MapViewActionButton: View {
    @Binding var mapState: MapViewState
    @EnvironmentObject var locationVieWModel: LocationSearchViewModel
    
    func actionForState(_ state: MapViewState) {
        switch state {
        case .noInput:
            print("No input")
        case .searchingForLocation:
            mapState = .noInput
        case .locationSelected:
            locationVieWModel.selectedLocationCoordinates = nil
            mapState = .noInput
        }
    } 
    
    func imageNameForState(_ state: MapViewState) -> String{
        switch state {
        case .noInput:
            return "line.3.horizontal"
        case .searchingForLocation, .locationSelected:
            return "arrow.left"
        }
    }
    
    var body: some View {
        Button {
            actionForState(mapState)
        } label: {
            Image(systemName: imageNameForState(mapState))
                .font(.title2)
                .foregroundColor(.black)
                .padding()
                .background(.white)
                .clipShape(Circle())
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
    
}

#Preview {
    MapViewActionButton(mapState: .constant(.noInput))
}
