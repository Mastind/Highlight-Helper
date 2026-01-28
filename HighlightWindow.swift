import Cocoa

class HighlightWindow: NSWindow {
    var isBarVisible = true
    var barHeight: CGFloat = 60
    var barColor: NSColor = NSColor.yellow
    var barOpacity: CGFloat = 0.3
    
    init() {
        // 读取保存的设置
        let settings = SettingsManager.shared.loadSettings()
        
        // 获取屏幕尺寸
        let screen = NSScreen.main!
        let screenRect = screen.frame
        
        super.init(
            contentRect: NSRect(x: 0, y: screenRect.height / 2, width: screenRect.width, height: settings.height),  // 使用保存的高度
            styleMask: [.borderless],
            backing: .buffered,
            defer: false
        )
        
        // 应用保存的设置
        self.barHeight = settings.height
        self.barOpacity = settings.opacity
        self.barColor = settings.color
        
        // 窗口设置
        self.isOpaque = false
        self.backgroundColor = .clear
        self.level = .floating
        self.ignoresMouseEvents = true
        self.collectionBehavior = [.canJoinAllSpaces, .stationary, .fullScreenAuxiliary]
        
        // 创建高亮条视图
        let highlightView = HighlightView(frame: self.contentView!.bounds)
        highlightView.autoresizingMask = [.width, .height]
        highlightView.barColor = self.barColor  // 设置颜色
        highlightView.barOpacity = self.barOpacity  // 设置透明度
        self.contentView?.addSubview(highlightView)
        
        // 监听全局鼠标移动
        NSEvent.addGlobalMonitorForEvents(matching: .mouseMoved) { [weak self] event in
            self?.updatePosition(mouseLocation: NSEvent.mouseLocation)
        }
        
        // 监听本地鼠标移动
        NSEvent.addLocalMonitorForEvents(matching: .mouseMoved) { [weak self] event in
            self?.updatePosition(mouseLocation: NSEvent.mouseLocation)
            return event
        }
    }
    
    func updatePosition(mouseLocation: NSPoint) {
        let screen = NSScreen.main!
        let screenHeight = screen.frame.height
        
        // macOS 的坐标系统原点在左下角，需要转换
        let yPosition = mouseLocation.y - barHeight / 2
        
        var newFrame = self.frame
        newFrame.origin.y = yPosition
        self.setFrame(newFrame, display: true, animate: false)
    }
    
    func updateAppearance() {
        if let view = self.contentView?.subviews.first as? HighlightView {
            view.barColor = barColor
            view.barOpacity = barOpacity
            view.needsDisplay = true
        }
        
        var newFrame = self.frame
        newFrame.size.height = barHeight
        self.setFrame(newFrame, display: true)
        
        // 保存设置
        SettingsManager.shared.saveSettings(height: barHeight, opacity: barOpacity, color: barColor)
    }
}

class HighlightView: NSView {
    var barColor: NSColor = .yellow
    var barOpacity: CGFloat = 0.3
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        // 绘制半透明矩形
        barColor.withAlphaComponent(barOpacity).setFill()
        dirtyRect.fill()
        
        // 绘制边框
        barColor.withAlphaComponent(barOpacity + 0.2).setStroke()
        let topLine = NSBezierPath()
        topLine.move(to: NSPoint(x: 0, y: dirtyRect.height))
        topLine.line(to: NSPoint(x: dirtyRect.width, y: dirtyRect.height))
        topLine.lineWidth = 2
        topLine.stroke()
        
        let bottomLine = NSBezierPath()
        bottomLine.move(to: NSPoint(x: 0, y: 0))
        bottomLine.line(to: NSPoint(x: dirtyRect.width, y: 0))
        bottomLine.lineWidth = 2
        bottomLine.stroke()
    }
}
