import SwiftUI

struct CastCard: View {
    let name: String
    let index: Int

    private static let avatarColors: [Color] = [.blue, .orange, .teal, .purple, .green, .pink]

    var body: some View {
        VStack(spacing: 6) {
            Circle()
                .fill(Self.avatarColors[index % Self.avatarColors.count].opacity(0.25))
                .frame(width: 56, height: 56)
                .overlay(
                    Text(initials)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(Self.avatarColors[index % Self.avatarColors.count])
                )

            Text(firstName)
                .font(.system(size: 11, weight: .medium))
                .foregroundStyle(.primary)
                .lineLimit(1)
        }
        .frame(width: 64)
    }

    private var initials: String {
        name.split(separator: " ").compactMap { $0.first }.map { String($0) }.joined()
    }

    private var firstName: String {
        String(name.split(separator: " ").first ?? "")
    }
}
