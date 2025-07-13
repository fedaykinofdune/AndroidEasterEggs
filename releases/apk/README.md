# Baklava Landroid APK Releases - Gravity Fix

## 🚀 Release Information
- **Version**: 4.0.1_65
- **Date**: July 13, 2024
- **Fix**: Gravity interaction issue in Baklava Landroid resolved

## 🐛 Issue Fixed
The Baklava Landroid app had broken gravity interactions where the red ringed "gravity wells" around planetary bodies weren't properly interacting with the spacecraft.

## 🛠️ Technical Solution
- Added missing `VisibleUniverse` class implementation
- Fixed state management and recomposition triggers
- Updated function signatures to use proper VisibleUniverse type
- Restored proper gravity visualization matching VanillaIceCream reference

## 📱 Available APK Variants

### Production Builds (Recommended)
- **`baklava-landroid-gravity-fixed-foss-product.apk`** - FOSS Production version (5.4 MB)
- **`baklava-landroid-gravity-fixed-market-product.apk`** - Market Production version (5.4 MB)

### Beta Builds
- **`baklava-landroid-gravity-fixed-foss-beta.apk`** - FOSS Beta version (5.4 MB)
- **`baklava-landroid-gravity-fixed-market-beta.apk`** - Market Beta version (5.4 MB)

### Alpha Build
- **`baklava-landroid-gravity-fixed-foss-alpha.apk`** - FOSS Alpha version (5.4 MB)

## 📋 Installation Instructions
1. Download the desired APK file
2. Enable "Unknown sources" in your Android device settings
3. Install the APK
4. Launch the app and navigate to "Baklava Landroid"
5. Test the gravity interaction with spacecraft

## ✅ Verification
- Gravity wells (red rings) now properly interact with spacecraft
- Physics simulation matches reference VanillaIceCream implementation
- All build variants tested and working

## 🔧 Build Environment
- Java 17 (OpenJDK)
- Android SDK 34
- Gradle with configuration cache enabled
- All dependencies up to date

## 🧪 Testing
Test the gravity interaction by:
1. Opening Baklava Landroid
2. Observing red-ringed gravity wells around planetary bodies
3. Verifying spacecraft responds to gravity fields
4. Comparing behavior with VanillaIceCream reference app

---
*Built with ❤️ and proper gravity physics*