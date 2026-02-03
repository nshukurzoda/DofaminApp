import SwiftUI

class Palette {
     static let neutral1 = Color(hex: "#FFFFFF")
     static let neutral2 = Color(hex: "#FAFAFA")
     static let neutral3 = Color(hex: "#F5F5F5")
     static let neutral4 = Color(hex: "#F0F0F0")
     static let neutral5 = Color(hex: "#D9D9D9")
     static let neutral6 = Color(hex: "#BFBFBF")
     static let neutral7 = Color(hex: "#8C8C8C")
     static let neutral8 = Color(hex: "#595959")
     static let neutral9 = Color(hex: "#3F3F3F")
     static let neutral10 = Color(hex: "#262626")
     static let neutral11 = Color(hex: "#1C1C1C")
     static let neutral12 = Color(hex: "#141414")
     static let neutral13 = Color(hex: "#000000")
     static let brand1 = Color(hex: "#F9EDFC")
     static let brand2 = Color(hex: "#E3BDF0")
     static let brand3 = Color(hex: "#CB90E3")
     static let brand4 = Color(hex: "#B265D6")
     static let brand5 = Color(hex: "#993EC9")
     static let brand6 = Color(hex: "#801DBD")
     static let brand7 = Color(hex: "#801DBD")
     static let brand8 = Color(hex: "#400671")
     static let brand9 = Color(hex: "#26004A")
     static let brand10 = Color(hex: "#110024")
     static let yellow1 = Color(hex: "#FEFCE6")
     static let yellow2 = Color(hex: "#FEF3C7")
     static let yellow3 = Color(hex: "#FFE779")
     static let yellow4 = Color(hex: "#FFD952")
     static let yellow5 = Color(hex: "#FFC92A")
     static let yellow6 = Color(hex: "#F1AD00")
     static let yellow7 = Color(hex: "#CB8B02")
     static let yellow8 = Color(hex: "#A66C01")
     static let yellow9 = Color(hex: "#804F00")
     static let yellow10 = Color(hex: "#472A00")
     static let red1 = Color(hex: "#FFE9E5")
     static let red2 = Color(hex: "#FFD9D4")
     static let red3 = Color(hex: "#FFB3AA")
     static let red4 = Color(hex: "#FF8A82")
     static let red5 = Color(hex: "#FC5E58")
     static let red6 = Color(hex: "#EF2D2D")
     static let red7 = Color(hex: "#CA1C22")
     static let red8 = Color(hex: "#A30F19")
     static let red9 = Color(hex: "#7D0411")
     static let red10 = Color(hex: "#2C0207")
     static let green1 = Color(hex: "#EEF7E9")
     static let green2 = Color(hex: "#D1FAE5")
     static let green3 = Color(hex: "#ADDE99")
     static let green4 = Color(hex: "#88D16F")
     static let green5 = Color(hex: "#63C449")
     static let green6 = Color(hex: "#41B726")
     static let green7 = Color(hex: "#299116")
     static let green8 = Color(hex: "#176B0D")
     static let green9 = Color(hex: "#0A4504")
     static let green10 = Color(hex: "#031F02")
     static let white90 = Color(hex: "rgba(255, 255, 255, 0.9)")
     static let white80 = Color(hex: "rgba(255, 255, 255, 0.8)")
     static let white70 = Color(hex: "rgba(255, 255, 255, 0.7)")
     static let white60 = Color(hex: "rgba(255, 255, 255, 0.6)")
     static let white50 = Color(hex: "rgba(255, 255, 255, 0.5)")
     static let white40 = Color(hex: "rgba(255, 255, 255, 0.4)")
     static let white30 = Color(hex: "rgba(255, 255, 255, 0.3)")
     static let white20 = Color(hex: "rgba(255, 255, 255, 0.2)")
     static let white10 = Color(hex: "rgba(255, 255, 255, 0.1)")
     static let black90 = Color(hex: "rgba(20, 20, 20, 0.9)")
     static let black80 = Color(hex: "rgba(20, 20, 20, 0.8)")
     static let black70 = Color(hex: "rgba(20, 20, 20, 0.7)")
     static let black60 = Color(hex: "rgba(20, 20, 20, 0.6)")
     static let black50 = Color(hex: "rgba(20, 20, 20, 0.5)")
     static let black40 = Color(hex: "rgba(20, 20, 20, 0.4)")
     static let black30 = Color(hex: "rgba(20, 20, 20, 0.3)")
     static let black20 = Color(hex: "rgba(20, 20, 20, 0.2)")
     static let black10 = Color(hex: "rgba(20, 20, 20, 0.1)")

}


extension Color {
    init(hex: String) {
        if hex.hasPrefix("rgba") {
            // Regex to capture the rgba values (e.g., rgba(255, 255, 255, 0.9))
            let pattern = #"^rgba\((\d+), (\d+), (\d+), (\d*(?:\.\d+)?)\)$"#
            
            // Check if the pattern matches the rgba string
            if let regex = try? NSRegularExpression(pattern: pattern, options: []),
               let match = regex.firstMatch(in: hex, options: [], range: NSRange(location: 0, length: hex.utf16.count)) {
                
                // Extract the rgba components
                let rString = (hex as NSString).substring(with: match.range(at: 1))
                let gString = (hex as NSString).substring(with: match.range(at: 2))
                let bString = (hex as NSString).substring(with: match.range(at: 3))
                let aString = (hex as NSString).substring(with: match.range(at: 4))
                
                // Convert to integers for RGB (0-255) and Float for alpha (0.0-1.0)
                if let r = Int(rString), let g = Int(gString), let b = Int(bString), let a = Float(aString) {
                    // Normalize RGB values to [0.0, 1.0] and create the Color
                    self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, opacity: CGFloat(a))
                    return
                }
            }
        }
    
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
