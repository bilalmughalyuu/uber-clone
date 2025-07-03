import Foundation

enum RideType: Int, CaseIterable, Identifiable {
    case uberX
    case black
    case uberXL
    
    var id: Int { return rawValue }
    
    var description: String {
        switch self {
        case .uberX: return "UberX"
        case .black: return "Black"
        case .uberXL: return "UberXL"
        }
    }
    
    var imageName: String {
        switch self {
        case .uberX: return "uber-x"
        case .black: return "uber-black"
        case .uberXL: return "uber-x"
        }
    }
    
    var baseFare: Double {
        switch self {
        case .uberX: return 5
        case .black: return 20
        case .uberXL: return 10
        }
    }
    
    func computePrice(for distanceMeter: Double) -> Double {
        let distanceInMiles = distanceMeter / 1609.34
        switch self {
        case .black: return distanceInMiles * 2 + baseFare
        case .uberX: return distanceInMiles * 1.5 + baseFare
        case .uberXL: return distanceInMiles * 1.75 + baseFare
            
        }
    }
}
