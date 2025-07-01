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
}


extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
