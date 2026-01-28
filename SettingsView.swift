import SwiftUI

struct SettingsView: View {
    var highlightWindow: HighlightWindow
    
    @State private var barHeight: Double
    @State private var barOpacity: Double
    @State private var barColor: Color
    
    init(highlightWindow: HighlightWindow) {
        self.highlightWindow = highlightWindow
        _barHeight = State(initialValue: Double(highlightWindow.barHeight))
        _barOpacity = State(initialValue: Double(highlightWindow.barOpacity * 100))
        _barColor = State(initialValue: Color(highlightWindow.barColor))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Highlight Bar Settings")
                .font(.title)
                .padding(.bottom, 10)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Color")
                    .font(.headline)
                ColorPicker("Select Color", selection: $barColor)
                    .onChange(of: barColor) { oldValue, newValue in  //
                        highlightWindow.barColor = NSColor(newValue)
                        highlightWindow.updateAppearance()
                    }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Opacity: \(Int(barOpacity))%")
                    .font(.headline)
                Slider(value: $barOpacity, in: 10...80, step: 1)
                    .onChange(of: barOpacity) { oldValue, newValue in  //
                        highlightWindow.barOpacity = newValue / 100
                        highlightWindow.updateAppearance()
                    }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Height: \(Int(barHeight))px")
                    .font(.headline)
                Slider(value: $barHeight, in: 20...150, step: 1)
                    .onChange(of: barHeight) { oldValue, newValue in  //
                        highlightWindow.barHeight = newValue
                        highlightWindow.updateAppearance()
                    }
            }
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Press ⌘T to quickly show/hide the highlight bar.")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text("Settings are automatically saved.")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(20)
        .frame(width: 480, height: 320)
    }
}
