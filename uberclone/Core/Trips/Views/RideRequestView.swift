import SwiftUI

struct RideRequestView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            // Drag indicator
            Capsule()
                .fill(Color(.systemGray4))
                .frame(width: 48, height: 6)
                .frame(maxWidth: .infinity)
                .padding(.top, 8)
            
            // Location Timeline
            HStack(alignment: .top, spacing: 12) {
                VStack {
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
                
                VStack(spacing: 40) {
                    HStack {
                        Text("Current Location")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.gray)
                        Spacer()
                        Text("1:30 PM")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                    
                    HStack {
                        Text("Starbucks Coffee")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.gray)
                        Spacer()
                        Text("2:10 PM")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(.horizontal)
            
            Divider()
                .padding(.horizontal)
            
            // Section Title
            Text("Suggested Rides")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.gray)
                .padding(.horizontal)
            
            // Ride Options
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(0..<3, id: \.self) { _ in
                        VStack(spacing: 8) {
                            Image("uber-x")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 60)
                            
                            VStack(spacing: 4) {
                                Text("Uber X")
                                    .font(.system(size: 14, weight: .semibold))
                                
                                Text("$22.04")
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding()
                        .frame(width: 120, height: 150)
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                    }
                }
                .padding(.horizontal)
            }
            
            // Payment Method
            HStack(spacing: 12) {
                Text("Visa")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(6)
                    .background(.blue)
                    .cornerRadius(6)
                    .foregroundColor(.white)
                
                Text("**** 1234")
                    .fontWeight(.semibold)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .imageScale(.medium)
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color(.systemGroupedBackground))
            .cornerRadius(12)
            .padding(.horizontal)
            
            // Confirm Ride Button
            Button {
                // Action here
            } label: {
                Text("Confirm Ride")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            
            Spacer(minLength: 16)
        }
        .padding(.top)
        .background(Color(.systemBackground))
    }
}

#Preview {
    RideRequestView()
}
