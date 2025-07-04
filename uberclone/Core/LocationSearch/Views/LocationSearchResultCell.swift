import SwiftUI

struct LocationSearchResultCell: View {
    var title: String
    var subtitle: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 36, height: 36)
                .foregroundColor(.blue)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(2)
            }
            
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.08), radius: 6, x: 0, y: 4)
        .padding(.horizontal)
    }
}

#Preview {
    LocationSearchResultCell(title: "Starbucks Coffee", subtitle: "123 Main Street, Dubai")
}
