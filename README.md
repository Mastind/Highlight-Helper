# Highlight-Helper


A macOS screen reading highlight bar tool that helps you focus on the current line while reading documents.

Born out of personal necessity as someone with ADHD, this tool brings the familiar experience of physical reading guides to the digital world, making screen reading more manageable and less overwhelming.

## ✨ Features

- 🎯 **Smart Tracking** - Transparent highlight bar follows your mouse cursor
- 🎨 **Customizable** - Adjust color, opacity, and height to your preference
- ⌨️ **Keyboard Shortcuts** - Quick toggle with ⌘T
- 💾 **Auto-Save** - Your settings are automatically saved
- 🖥️ **Always on Top** - Works over any application
- 🌙 **Unobtrusive** - Mouse events pass through the highlight bar

## 📋 System Requirements

- macOS 12.0 or later
- Accessibility permissions required

## 🚀 Installation

### Download Pre-built App

1. Download the latest release from [Release](https://github.com/Mastind/Highlight-Helper/releases/tag/v1.0.0)
2. Unzip the downloaded file
3. Drag `HighlightHelper.app` to your Applications folder
4. Double-click to launch

### First Launch Setup

On first launch, you'll need to grant accessibility permissions:

1. macOS will prompt you to open **System Settings**
2. Go to **Privacy & Security** → **Accessibility**
3. Click the 🔒 lock icon to unlock
4. Click the **+** button and add **HighlightHelper**
5. Make sure it's checked ✅
6. Restart the app

## 📖 Usage

### Basic Operation

- **Move your mouse** - The highlight bar automatically follows
- **Menu bar icon** - Click to access settings and controls

### Keyboard Shortcuts

- `⌘T` - Toggle highlight bar visibility
- `⌘,` - Open settings
- `⌘Q` - Quit application

### Settings

Customize your highlight bar:

- **Color** - Choose any color you like
- **Opacity** - Adjust from 10% to 80%
- **Height** - Set from 20px to 150px

All settings are automatically saved and restored on next launch.

## 🛠️ Development

### Prerequisites

- Xcode 14.0 or later
- macOS 12.0 or later
- Swift 5.0 or later

### Building from Source

```bash
# Clone the repository
git clone https://github.com/Mastind/Highlight-Helper.git

# Navigate to project directory
cd HighlightHelper

# Open in Xcode
open HighlightHelper.xcodeproj

# Build and run (⌘R in Xcode)
```

### Project Structure

```
HighlightHelper/
├── HighlightBarApp.swift      # Main app delegate and menu bar
├── HighlightWindow.swift      # Floating window implementation
├── SettingsView.swift         # Settings interface
├── SettingsManager.swift      # Persistent settings storage
└── Assets.xcassets/           # App icons and assets
```

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🐛 Known Issues

- The app requires accessibility permissions to track mouse position globally
- On first launch, you may need to manually restart the app after granting permissions

## 👏 Acknowledgments

- Claude (Anthropic) - For the patient guidance and coding assistance throughout this project. As someone new to Swift development, I couldn't have built this without the step-by-step help and explanations.
- Inspired by physical reading guides and book highlighters
- Built with Swift and SwiftUI

---

**Made with ❤️ for better reading experience**

⭐ Star this repo if you find it helpful!
