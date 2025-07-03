import Foundation
import MapKit

class LocationSearchViewModel: NSObject, ObservableObject {
    @Published var startLocationText: String = ""
    @Published var destinationLocationText: String = "" {
        didSet {
            searchCompleter.queryFragment = destinationLocationText
        }
    }
    @Published var selectedUberLocation: UberLocation?
    @Published var pickupTime: String?
    @Published var dropTime: String?
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
            self.selectedUberLocation = UberLocation(title: localSearch.title, coordinate: coordinates)
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
        guard let destCoordinate = selectedUberLocation?.coordinate else { return 0.0 }
        guard let userCoordinate = self.userLocation else { return 0.0 }
        
        let userLocation = CLLocation(latitude: userCoordinate.latitude, longitude: userCoordinate.longitude)
        let destinationLocation = CLLocation(latitude: destCoordinate.latitude, longitude: destCoordinate.longitude)
        
        let tripDistance = userLocation.distance(from: destinationLocation)
        return type.computePrice(for: tripDistance)
    }
    
    func getDestinationRoute(
        from userLocation: CLLocationCoordinate2D,
        to destinationLocation: CLLocationCoordinate2D,
        completion: @escaping(MKRoute) -> Void) {
            let userPlacemark = MKPlacemark(coordinate: userLocation)
            let destionationPlacemark = MKPlacemark(coordinate: destinationLocation)
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: userPlacemark)
            request.destination = MKMapItem(placemark: destionationPlacemark)
            let directions = MKDirections(request: request)
            
            directions.calculate { response, error in
                if let error = error {
                    print("Failed to get direction \(error)")
                    return
                }
                guard let route = response?.routes.first else { return }
                self.configurePickupAndDropOffTime(with: route.expectedTravelTime)
                completion(route)
            }
        }
    
    func configurePickupAndDropOffTime(with expectedTravelTime: Double) {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        
        pickupTime = formatter.string(from: Date())
        dropTime = formatter.string(from: Date() + expectedTravelTime)
    }
}


extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
