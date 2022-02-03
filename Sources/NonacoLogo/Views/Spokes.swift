
import SwiftUI

struct Spokes: View {
    var body: some View {
        let angles = (0..<16)
            .map { CGFloat($0) / 8 * .pi }

        LocalFrameReader { frame in
            ForEach(angles, id: \.self) { angle in
                Path { path in
                    path.move(to: CGPoint(
                        x: frame.midX,
                        y: frame.midY))

                    path.addLine(to: CGPoint(
                        x: frame.midX + cos(angle) * frame.midX,
                        y: frame.midY + sin(angle) * frame.midY))
                }
                .stroke(Color.spokes, lineWidth: frame.height / 50)
            }
        }
    }
}
