import Foundation
import MapKit

class LocationSearchViewModel: NSObject, ObservableObject {
    @Published var startLocationText: String = ""
    @Published var destinationLocationText: String = "" {
        didSet {
            searchCompleter.queryFragment = destinationLocationText
        }
    }
    
    @Published var results = [MKLocalSearchCompletion]()
    private var searchCompleter = MKLocalSearchCompleter()
    
    var queryFragment: String = ""
    
    
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = destinationLocationText
    }
    
}


extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
