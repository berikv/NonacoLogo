
import CoreText

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
