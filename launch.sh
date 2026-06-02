#!/bin/bash
# ECHOES OF 2076 - Quick Launch Script

echo "🎮 ECHOES OF 2076 - Cyberpunk Narrative RPG"
echo "=========================================="
echo ""
echo "⚠️  CRITICAL: Have you added your Gemini API key?"
echo "   → Edit: lib/main.dart line 12"
echo "   → Get key: https://aistudio.google.com/app/apikeys"
echo ""
echo "📦 Installing dependencies..."
flutter pub get

echo ""
echo "✅ Running code analysis..."
flutter analyze

echo ""
echo "🧪 Running tests..."
flutter test

echo ""
echo "🚀 Launching app..."
echo "   Select your target device when prompted:"
echo "   - Android: type 'a'"
echo "   - iOS: type 'i'"
echo "   - Windows: type 'w'"
echo "   - macOS: type 'm'"
echo "   - Chrome: type 'c'"
echo ""
flutter run
