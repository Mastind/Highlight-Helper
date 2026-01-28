import SwiftUI

@main
struct HighlightBarApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var highlightWindow: HighlightWindow?
    var statusItem: NSStatusItem?
    var settingsWindow: NSWindow?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        // Create highlight window
        highlightWindow = HighlightWindow()
        highlightWindow?.makeKeyAndOrderFront(nil)
        
        // Create menu bar icon
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        if let button = statusItem?.button {
            button.image = NSImage(systemSymbolName: "highlighter", accessibilityDescription: "highlighter")
        }
        
        let menu = NSMenu()
        // Command+T (Toggle)
        menu.addItem(NSMenuItem(title: "Toggle Highlight Bar", action: #selector(toggleHighlight), keyEquivalent: "t"))
        // Command+, (Standard settings shortcut)
        menu.addItem(NSMenuItem(title: "Settings", action: #selector(openSettings), keyEquivalent: ","))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(quit), keyEquivalent: "q"))
        
        statusItem?.menu = menu
        
        // Request accessibility permission
        requestAccessibilityPermission()
        
        // Register global shortcuts
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) { [weak self] event in
            // Command+T to toggle highlight bar
            if event.modifierFlags.contains(.command) && event.charactersIgnoringModifiers == "t" {
                self?.toggleHighlight()
                return nil
            }
            return event
        }
    }
    
    @objc func toggleHighlight() {
        if let window = highlightWindow {
            window.isBarVisible.toggle()
            if window.isBarVisible {
                window.orderFront(nil)
            } else {
                window.orderOut(nil)
            }
        }
    }
    
    @objc func openSettings() {
        if settingsWindow == nil {
            let settingsView = SettingsView(highlightWindow: highlightWindow!)
            settingsWindow = NSWindow(
                contentRect: NSRect(x: 0, y: 0, width: 480, height: 320),
                styleMask: [.titled, .closable],
                backing: .buffered,
                defer: false
            )
            settingsWindow?.center()
            settingsWindow?.title = "Highlight Bar Settings"
            settingsWindow?.contentView = NSHostingView(rootView: settingsView)
        }
        settingsWindow?.makeKeyAndOrderFront(nil)
    }
    
    @objc func quit() {
        NSApplication.shared.terminate(nil)
    }
    
    func requestAccessibilityPermission() {
        let options: NSDictionary = [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String: true]
        AXIsProcessTrusted()
        AXIsProcessTrustedWithOptions(options)
    }
}
