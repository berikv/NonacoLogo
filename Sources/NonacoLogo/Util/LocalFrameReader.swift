
import SwiftUI

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
