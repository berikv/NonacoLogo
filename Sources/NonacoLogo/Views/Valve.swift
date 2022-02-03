
import SwiftUI

struct Valve: View {
    var body: some View {
        LocalFrameReader { frame in
            Path { path in
                path.move(to: CGPoint(
                    x: frame.midX,
                    y: frame.minY))

                path.addLine(to: CGPoint(
                    x: frame.midX,
                    y: frame.minY + frame.height / 30))
            }
            .stroke(Color.rim, lineWidth: frame.height / 50)

            Path { path in
                path.move(to: CGPoint(
                    x: frame.midX,
                    y: frame.minY + frame.height / 30))

                path.addLine(to: CGPoint(
                    x: frame.midX,
                    y: frame.minY + frame.height / 30 + frame.height / 50))
            }
            .stroke(Color.valveTop, lineWidth: frame.height / 50)
        }
        .rotationEffect(.radians(.pi * 1/16))
        .animation(.none, value: false)
    }
}
