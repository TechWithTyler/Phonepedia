import SwiftUI

extension Color {
    var components: (red: Double, green: Double, blue: Double, opacity: Double) {
        #if os(iOS)
        let uiColor = UIColor(self)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return (Double(red), Double(green), Double(blue), Double(alpha))
        #else
        let nsColor = NSColor(self)
        let calibratedColor = nsColor.usingColorSpace(.sRGB) ?? nsColor
        let redComponent = Double(calibratedColor.redComponent)
        let greenComponent = Double(calibratedColor.greenComponent)
        let blueComponent = Double(calibratedColor.blueComponent)
        let alphaComponent = Double(calibratedColor.alphaComponent)
        return (redComponent, greenComponent, blueComponent, alphaComponent)
        #endif
    }
}

func rgbBinding(
    get: @escaping () -> (Double, Double, Double),
    set: @escaping (Double, Double, Double) -> Void
) -> Binding<Color> {
    Binding<Color>(
        get: {
            let (red, green, blue) = get()
            return Color(red: red, green: green, blue: blue)
        },
        set: { color in
            let components = color.components
            set(components.red, components.green, components.blue)
        }
    )
}

func rgbaBinding(
    get: @escaping () -> (Double, Double, Double, Double),
    set: @escaping (Double, Double, Double, Double) -> Void
) -> Binding<Color> {
    Binding<Color>(
        get: {
            let (red, green, blue, alpha) = get()
            return Color(red: red, green: green, blue: blue, opacity: alpha)
        },
        set: { color in
            let components = color.components
            set(components.red, components.green, components.blue, components.opacity)
        }
    )
}
