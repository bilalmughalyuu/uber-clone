import SwiftUI

struct HomeView: View {
    @State private var showLocationSearchView: Bool = false
    var body: some View {
        ZStack(alignment: .top) {
            UberMapViewRepresentable()
                .ignoresSafeArea()
            
            if showLocationSearchView {
                LocationSearchView()
            } else {
                LocationSearchActivationView()
                    .padding(.top, 60)
                    .padding(.horizontal)
                    .onTapGesture {
                        showLocationSearchView.toggle()
                    }
            }
            
            MapViewActionButton(showLocationSearchView: $showLocationSearchView)
        }
    }
}

#Preview {
    HomeView()
}
