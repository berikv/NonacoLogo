
import SwiftUI

struct Wheel: View {
    let angle: Angle

    @State private var startPosition = Double.random(in: 0 ..< .pi * 2)

    var body: some View {
        LocalFrameReader { frame in
            ZStack {
                Tire(frame: frame)

                Circle()
                    .strokeBorder(Color.rim, lineWidth: frame.height / 28)
                    .padding(frame.height / 14)

                Group {
                    Spokes()
                    Valve()
                }
                .padding(frame.height / (9 + 1/3))

                Circle()
                    .padding(frame.height / (2.25))
                    .foregroundColor(Color.rim)

                Circle()
                    .padding(frame.height / (2.1))
                    .foregroundColor(.black)
            }
            .rotationEffect(.radians(startPosition) + angle)
        }
    }
}
