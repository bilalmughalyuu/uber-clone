import SwiftUI

struct LocationSearchActivationView: View {
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .frame(width: 20, height: 20)

            Text("Where to?")
                .foregroundColor(.gray)
                .font(.system(size: 16, weight: .semibold))

            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 4)
        )
        .padding(.horizontal)
    }
}

#Preview {
    LocationSearchActivationView()
}
