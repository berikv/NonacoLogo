
import SwiftUI

struct Tire: View {
    let frame: CGRect
    var body: some View {
        Circle()
            .strokeBorder(Color.tire, lineWidth: frame.height / 14)

        Path { path in
            let patternCount = 120
            let angles: [CGFloat] = (0..<patternCount)
                .map { CGFloat($0) / CGFloat(patternCount) * 2 * .pi }

            for radians in angles {
                path.move(to: CGPoint(
                    x: frame.midX + cos(radians) * frame.midX,
                    y: frame.midY + sin(radians) * frame.midY))
                path.addLine(to: CGPoint(
                    x: frame.midX + cos(radians) * (frame.midX - frame.height / 40),
                    y: frame.midY + sin(radians) * (frame.midY - frame.height / 40)))
            }
        }
        .stroke(Color.tread, lineWidth: frame.height / 100)
    }
}
