import SwiftUI
import AVFoundation

struct LocalFrameReader<Content>: View where Content: View {
    let content: (CGRect) -> Content

    @inlinable public init(@ViewBuilder content: @escaping (CGRect) -> Content) {
        self.content = content
    }

    var body: some View {
        GeometryReader { geometry in
            content(geometry.frame(in: .local))
        }
    }
}

extension CTFont {
    var capHeight: CGFloat { CTFontGetCapHeight(self) }
    var ascent: CGFloat { CTFontGetAscent(self) }
    var pointSize: CGFloat { CTFontGetSize(self) }

    var capTopDistance: CGFloat {
        ascent - capHeight
    }

    var capCenterTopDistance: CGFloat {
        capTopDistance + capHeight / 2
    }

    var capCenterLineCenterDistance: CGFloat {
        capCenterTopDistance - pointSize / 2
    }
}

final class AudioPlayer: ObservableObject {
    private let player = try! AVAudioPlayer(
        contentsOf: Bundle.main.url(
            forResource: "bell", withExtension: "wav")!)

    func play() {
        player.play()
    }
}

extension Color {
    static let nonacoOrange = Color(
        .displayP3,
        red: 223/255, green: 100/255, blue: 56/255, opacity: 1)

    static let tire = Color.black
    static let rim = Color(white: 211/255)
    static let valveTop = Color(white: 85/255)
    static let spokes = Color(white: 155/255)
    static let tread = Color(white: 120/255)
}

public struct NonacoLogo: View {
    @StateObject var player = AudioPlayer()
    @State var angle: Angle = .radians(0)

    func wheel(_ font: CTFont) -> some View {
        Wheel(angle: angle)
            .contentShape(Rectangle())
            .frame(width: font.capHeight, height: font.capHeight)
            .offset(y: font.capCenterLineCenterDistance)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 3).delay(0.25)) {
                    angle += .radians(.pi * 5)
                }
            }
    }

    public var body: some View {
        LocalFrameReader { frame in
            let helveticaBoldAspectRatio = 4.483
            let fontSize = min(
                frame.height,
                frame.width / helveticaBoldAspectRatio)

            let font = CTFont("Helvetica-Bold" as CFString, size: fontSize)

            HStack(alignment: .top, spacing: 0) {
                Text("N")

                Text("O")
                    .opacity(0)
                    .overlay(wheel(font))

                Text("NAC")

                Text("O")
                    .opacity(0)
                    .overlay(wheel(font))
                    .padding(.trailing, 8)
            }

            .lineLimit(1)
            .font(Font(font))
            .foregroundColor(.nonacoOrange)
            .fixedSize()
//            .background(.white)
            .onAppear {
                player.play()

                withAnimation(.easeIn(duration: 2).delay(1)) {
                    angle += .radians(.pi * 4)
                }

                withAnimation(.easeOut(duration: 8).delay(3)) {
                    angle += .radians(.pi * 16)
                }

            }
        }
    }
}

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

struct Tire: View {
    let frame: CGRect
    var body: some View {
        Circle()
            .strokeBorder(Color.tire, lineWidth: frame.height / 14)

        Path { path in
            let patternCount = 120
            let angles: [Double] = (0..<patternCount)
                .map { Double($0) / Double(patternCount) * 2 * .pi }

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

struct Spokes: View {
    var body: some View {
        let angles = (0..<16)
            .map { Double($0) / 8 * .pi }

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

struct NonacoLogo_Previews: PreviewProvider {
    static var previews: some View {
        NonacoLogo()
    }
}
