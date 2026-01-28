import Cocoa

class SettingsManager {
    static let shared = SettingsManager()
    
    private let defaults = UserDefaults.standard
    
    private enum Keys {
        static let barHeight = "barHeight"
        static let barOpacity = "barOpacity"
        static let barColorRed = "barColorRed"
        static let barColorGreen = "barColorGreen"
        static let barColorBlue = "barColorBlue"
    }
    
    // 保存设置
    func saveSettings(height: CGFloat, opacity: CGFloat, color: NSColor) {
        defaults.set(height, forKey: Keys.barHeight)
        defaults.set(opacity, forKey: Keys.barOpacity)
        
        // 保存颜色的 RGB 值
        if let rgbColor = color.usingColorSpace(.deviceRGB) {
            defaults.set(rgbColor.redComponent, forKey: Keys.barColorRed)
            defaults.set(rgbColor.greenComponent, forKey: Keys.barColorGreen)
            defaults.set(rgbColor.blueComponent, forKey: Keys.barColorBlue)
        }
    }
    
    // 读取设置
    func loadSettings() -> (height: CGFloat, opacity: CGFloat, color: NSColor) {
        let height = defaults.object(forKey: Keys.barHeight) as? CGFloat ?? 60
        let opacity = defaults.object(forKey: Keys.barOpacity) as? CGFloat ?? 0.3
        
        let red = defaults.object(forKey: Keys.barColorRed) as? CGFloat ?? 1.0
        let green = defaults.object(forKey: Keys.barColorGreen) as? CGFloat ?? 1.0
        let blue = defaults.object(forKey: Keys.barColorBlue) as? CGFloat ?? 0.0
        
        let color = NSColor(red: red, green: green, blue: blue, alpha: 1.0)
        
        return (height, opacity, color)
    }
}
