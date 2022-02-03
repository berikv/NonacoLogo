import SwiftUI
import AVFoundation

final class AudioPlayer: ObservableObject {
    private let player = try! AVAudioPlayer(
        contentsOf: Bundle.module.url(
            forResource: "bell", withExtension: "wav")!)

    func play() {
        player.play()
    }
}

public struct NonacoLogo: View {
    @StateObject var player = AudioPlayer()
    @State var angle: Angle = .radians(0)

    public init() {}

    func wheel(_ font: CTFont) -> some View {
        var wheel = Wheel(angle: angle)
            .contentShape(Rectangle())
            .frame(width: font.capHeight, height: font.capHeight)

#if os(tvOS)
        return wheel
#elseif os(macOS)
        return wheel
            .offset(y: font.capCenterLineCenterDistance)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 3).delay(0.25)) {
                    angle += .radians(.pi * 5)
                }
            }
#else
        return wheel
            .onTapGesture {
                withAnimation(.easeInOut(duration: 3).delay(0.25)) {
                    angle += .radians(.pi * 5)
                }
            }
#endif
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

struct NonacoLogo_Previews: PreviewProvider {
    static var previews: some View {
        NonacoLogo()
    }
}
