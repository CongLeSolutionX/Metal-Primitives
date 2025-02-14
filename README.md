# Metal Primitives in Swift and Objective-C

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)  [![License: CC BY 4.0](https://licensebuttons.net/l/by/4.0/88x31.png)](LICENSE-CC-BY)

---
Copyright (c) 2025 Cong Le. All Rights Reserved.

---


This project demonstrates the basic primitives of the Metal framework by Apple, showcasing how to render various graphics using Metal in both **Swift** and **Objective-C**. It serves as an educational resource for developers interested in graphics programming on **iOS** and **macOS** platforms.

## Overview

The project covers a range of rendering examples:

- **Clear Screen**: Basics of setting up a Metal view and clearing the screen with a solid color.
- **Draw 2D Triangle**: Rendering a simple 2D triangle on the screen.
- **Draw Spinning 3D Cube**: Displaying a rotating 3D cube with basic transformations.
- **Draw Spinning Teapot with Manual Lighting**: Rendering a spinning teapot model with custom lighting effects.
- **Draw Spinning Cow with Manual Lighting and Custom Texture**: Displaying a textured cow model with lighting.

Each example is fully programmatic—**no Storyboards, XIBs, or NIBs** are used—providing a clear understanding of the code involved in setting up and rendering Metal views.

## Demo

Here is the previews of multiple metal screens rendering on an iOS simulator:


![Demo-on-iOS-devices](Resources/Demo-on-iOS-devices.gif)

Here is the previews of multiple metal screens rendering on a macOS simulator:


![Demo-on-macOS-devices](Resources/Demo-macOS-devices.gif)

## Motivation

This project is a migration and enhancement of the code from Warren Moore's book, [*Metal by Example*](https://warrenmoore.net/), originally written in 2015. By updating the code to support the latest versions of Swift and Objective-C, and integrating it with both iOS and macOS platforms, we aim to make Metal's functionalities more accessible to modern developers.

The project also incorporates cross-platform support from [dehesa/sample-metal](https://github.com/dehesa/sample-metal), allowing the examples to run seamlessly on different operating systems and frameworks. By connecting all the code into a single app, we've streamlined the learning experience.

## Features

- **Cross-Platform Rendering**: Examples run on both **iOS devices** and **macOS** systems.
- **Swift and Objective-C**: Implementations in both languages to cater to a wider range of developers.
- **Mermaid Diagrams**: Each Metal view includes **Mermaid diagrams** explaining code functionalities and the relationships among code blocks.
- **100% Programmatic UI**: No Interface Builder files; all views are created via code for better transparency.
- **Educational Focus**: Code is well-documented and structured to facilitate learning.

## Code Structure

### High-Level Architecture Diagram

This diagram provides an overview of the entire app's architecture, highlighting the conditional compilation for iOS and macOS platforms and how different views are integrated.

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph TD
    %% Define styles
    classDef iOS fill:#43F6,stroke:#4285F4
    classDef macOS fill:#F4F6,stroke:#34A853

    %% App Structure
    A["MetalPrimitivesApp<br>@main App"]
    A -->|contains| B[WindowGroup]

    %% Platform Conditional Views
    B -->|Platform: iOS| C[iOS Views]
    B -->|Platform: macOS| D[macOS Views]

    %% iOS Views
    subgraph iOS Views
        direction TB
        C1[ObjCMetalPlainViewControllerRepresentable]:::iOS
        C2[MetalTexturingViewRepresentable]:::iOS
        C3[MetalLightingViewRepresentable]:::iOS
        C4[Metal3DViewRepresentable]:::iOS
        C5[Metal2DViewRepresentable]:::iOS
        C6[MetalPlainViewRepresentable]:::iOS
        C7[iOS_ViewControllerRepresentable]:::iOS
        C8[iOS_SwiftUI_RootContentView]:::iOS
    end
    C --> C1 & C2 & C3 & C4 & C5 & C6 & C7 & C8

    %% macOS Views
    subgraph macOS Views
        direction TB
        D1[MetalTexturingViewRepresentable]:::macOS
        D2[MetalLightingViewRepresentable]:::macOS
        D3[Metal3DViewRepresentable]:::macOS
        D4[NSMetal2DViewRepresentable]:::macOS
        D5[NSMetalPlainViewRepresentable]:::macOS
    end
    D --> D1 & D2 & D3 & D4 & D5
```

**Explanation:**

- The `MetalPrimitivesApp` uses a `WindowGroup` to host the main content.
- Based on the platform (iOS or macOS), it conditionally includes different views.
- The iOS Views and macOS Views are grouped under their respective platforms.
- Each platform includes a set of representable views that integrate Metal rendering into SwiftUI.

---

### App Structure Overview

This class diagram illustrates the overall structure of the app, focusing on the relationships between the main app entry point, SwiftUI views, and UIKit/AppKit view controllers.

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
classDiagram
    %% Main App Entry Point
    class MetalPrimitivesApp {
        +var body: some Scene
    }
    MetalPrimitivesApp --> WindowGroup

    %% SwiftUI Views
    WindowGroup --> iOS_SwiftUI_RootContentView
    iOS_SwiftUI_RootContentView --> ObjCMetalPlainViewControllerRepresentable

    %% UIViewControllerRepresentable Wrapper
    class ObjCMetalPlainViewControllerRepresentable {
        +makeUIViewController()
        +updateUIViewController()
    }
    ObjCMetalPlainViewControllerRepresentable ..|> UIViewControllerRepresentable

    %% UIKit View Controllers
    ObjCMetalPlainViewControllerRepresentable --> ObjCMetalPlainViewController

    %% Typealiases and Base Classes
    class MySwiftViewController
    MySwiftViewController <|-- UIViewController
    MySwiftViewController <|-- NSViewController
    ObjCMetalPlainViewController <|-- MySwiftViewController
```

**Explanation:**

- `MetalPrimitivesApp` is the main entry point of the app, containing the `WindowGroup`.
- `iOS_SwiftUI_RootContentView` is the main SwiftUI view for iOS, which uses `ObjCMetalPlainViewControllerRepresentable` to bridge UIKit components.
- `ObjCMetalPlainViewControllerRepresentable` conforms to `UIViewControllerRepresentable` to integrate a UIKit view controller within SwiftUI.
- `ObjCMetalPlainViewController` is an Objective-C view controller that handles Metal rendering.


For more details and illustrations, please check out [Documentation.md](/Documentation.md).

## Getting Started

### Prerequisites

- **Xcode 13** or later (supports both Swift and Objective-C)
- **iOS 13** or later / **macOS 10.15** or later
- **Swift 5** or later

### Installation

1. **Clone the Repository**:

   ```bash
   git clone https://github.com/CongLeSolutionX/Metal-Primitives.git
   ```

2. **Open the Project in Xcode**:

   ```bash
   cd Metal-Primitives
   open MetalPrimitives.xcodeproj
   ```

3. **Select the Target**:

   - Choose either the **iOS** or **macOS** target depending on your development environment.

4. **Build and Run**:

   - Press `Cmd + R` to build and run the project on your device or simulator.

## Understanding the Code

### Programmatic Views

All views in this project are created programmatically. This approach provides:

- **Full Transparency**: Understanding exactly how views are initialized and managed.
- **Flexibility**: Easier to manipulate views dynamically.
- **No Storyboard Constraints**: Avoids issues related to storyboard merges in collaborative environments.

### Mermaid Diagrams

To help visualize the architecture and flow of each example, we've included **Mermaid diagrams** in the documentation of each module.

#### Example: Metal Views and Renderers Class Diagram

This diagram shows the relationship between the Metal views and their respective renderers.

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
classDiagram
    %% SwiftUI Representable Views
    class Metal3DViewRepresentable {
        +makeUIView()
        +updateUIView()
        +makeCoordinator()
    }
    class MetalLightingViewRepresentable {
        +makeUIView()
        +updateUIView()
        +makeCoordinator()
    }
    class MetalTexturingViewRepresentable {
        +makeUIView()
        +updateUIView()
        +makeCoordinator()
    }

    Metal3DViewRepresentable ..|> UIViewRepresentable
    MetalLightingViewRepresentable ..|> UIViewRepresentable
    MetalTexturingViewRepresentable ..|> UIViewRepresentable

    %% Underlying Metal Views
    class CAMetal3DView {
        +device: MTLDevice
        +renderer: RendererFor3DView
    }
    class MTKView

    Metal3DViewRepresentable --> CAMetal3DView
    MetalLightingViewRepresentable --> MTKView
    MetalTexturingViewRepresentable --> MTKView

    %% Coordinators (Renderers)
    Metal3DViewRepresentable --> CubeRenderer : makeCoordinator()
    MetalLightingViewRepresentable --> TeapotRenderer : makeCoordinator()
    MetalTexturingViewRepresentable --> CowRenderer : makeCoordinator()

    %% Renderers
    class RendererFor3DView {
        <<Protocol>>
        + device: MTLDevice
        + draw(layer: CAMetalLayer, time: (now: Double, display: Double))
    }
    RendererFor3DView <|.. CubeRenderer
    RendererFor3DView <|.. TeapotRenderer
    RendererFor3DView <|.. CowRenderer

    CubeRenderer ..|> RendererFor3DView
    TeapotRenderer ..|> MTKViewDelegate
    CowRenderer ..|> MTKViewDelegate
```

**Explanation:**

- Each representable view conforms to `UIViewRepresentable` and integrates a Metal view into SwiftUI.
- `Metal3DViewRepresentable` uses `CAMetal3DView`, which utilizes a custom renderer (`CubeRenderer`).
- `MetalLightingViewRepresentable` and `MetalTexturingViewRepresentable` use `MTKView` and custom renderers (`TeapotRenderer` and `CowRenderer` respectively).
- Renderers conform to either `RendererFor3DView` protocol or `MTKViewDelegate`.


## Learning Objectives

By exploring this project, you will:

- **Understand Metal Basics**: Learn how to set up a Metal environment and render basic shapes.
- **Work with Shaders**: Write and modify vertex and fragment shaders for custom rendering effects.
- **Implement Transformations**: Apply translations, rotations, and scaling to 3D objects.
- **Apply Lighting Models**: Understand how lighting affects rendering and how to implement it manually.
- **Work with Textures**: Load and apply textures to 3D models for more realistic effects.
- **Develop Cross-Platform Code**: Write code that runs on both iOS and macOS platforms.

## Resources and References

- **Warren Moore's Blog**: [warrenmoore.net](https://warrenmoore.net/)
- **Metal Official Documentation**: [Apple Developer - Metal](https://developer.apple.com/metal/)
- **dehesa/sample-metal Repository**: [GitHub - dehesa/sample-metal](https://github.com/dehesa/sample-metal)
- **Metal by Example Book**: *Metal by Example* by Warren Moore

## Contributing

We welcome contributions! If you'd like to improve the project, please:

1. **Fork the Repository**: Create your own fork on GitHub.
2. **Create a Feature Branch**: 

   ```bash
   git checkout -b feature/YourFeature
   ```

3. **Commit Your Changes**:

   ```bash
   git commit -m 'Add your feature'
   ```

4. **Push to the Branch**:

   ```bash
   git push origin feature/YourFeature
   ```

5. **Open a Pull Request**: Submit your changes for review.

## License

- **MIT License:**  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) - Full text in [LICENSE](LICENSE) file.
- **Creative Commons Attribution 4.0 International:** [![License: CC BY 4.0](https://licensebuttons.net/l/by/4.0/88x31.png)](LICENSE-CC-BY) - Legal details in [LICENSE-CC-BY](LICENSE-CC-BY) and at [Creative Commons official site](http://creativecommons.org/licenses/by/4.0/).

---