import Foundation
import MapKit

class LocationSearchViewModel: NSObject, ObservableObject {
    @Published var startLocationText: String = ""
    @Published var destinationLocationText: String = "" {
        didSet {
            searchCompleter.queryFragment = destinationLocationText
        }
    }
    @Published var selectedLocationCoordinates: CLLocationCoordinate2D?
    
    @Published var results = [MKLocalSearchCompletion]()
    private var searchCompleter = MKLocalSearchCompleter()
    
    var userLocation: CLLocationCoordinate2D?
    
    var queryFragment: String = ""
    
    
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = destinationLocationText
    }
    
    func selectLocation(_ localSearch: MKLocalSearchCompletion) {
        performLocationSearch(for: localSearch) { response, error in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let item = response?.mapItems.first else { return }
            
            let coordinates = item.placemark.coordinate
            self.selectedLocationCoordinates = coordinates
        }
    }
    
    func performLocationSearch(for localSearchCompletion: MKLocalSearchCompletion,
                               completion: @escaping MKLocalSearch.CompletionHandler) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearchCompletion.title.appending(localSearchCompletion.subtitle)
        let search = MKLocalSearch(request: searchRequest)
        
        search.start(completionHandler: completion)
    }
    
    func computeRidePrice(forType type: RideType) -> Double {
        guard let coordinate = selectedLocationCoordinates else { return 0.0 }
        guard let userCoordinate = self.userLocation else { return 0.0 }
        
        let userLocation = CLLocation(latitude: userCoordinate.latitude, longitude: userCoordinate.longitude)
        let destinationLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        let tripDistance = userLocation.distance(from: destinationLocation)
        return type.computePrice(for: tripDistance)
    }
}


extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
