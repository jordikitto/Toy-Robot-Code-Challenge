![App Icon](/Toy%20Robot/Assets.xcassets/AppIcon.appiconset/AppIcon128x128@2x.png)

# Toy Robot: Code Challenge
Coding challenging in SwiftUI/Swift where you can control a virtual Toy Robot

## Features
- Place and move robot
- Placement preview
- Responsive/resizable window
- Unit tests (*not to completion, just to show good practice*)

## Notes
- Built for Mac since then you don't need to run the simulator! However, could easily migrate to iOS.
- Some minor duplication in areas where it felt reasonably ok
- Had issues with top level `EnvironmentObject` (due to 2 `StateObject`s of same class) and `Environment`, so used "prop drilling" for now. However for a large project I would have liked to avoid this drilling.

**Open to any and all feedback on ways to improve**
