---
created: 2025-02-24 05:31:26

---



---


<div align="center">
  <blockquote>
  As a visual learner student, I created these personal study notes from the cited source(s) to aid my understanding.<br/>
  While my firm intention is to provide full credit, the blended format of notes and diagrams may sometimes obscure the original source, for which I apologize.<br/>
  I am committed to making corrections and welcome any feedback.<br/>
  This is a non-commercial project for my humble educational purposes only since the start.<br/>
  My goal is to share my perspective and contribute to the great work already being done.
  <br/>
  <br/>
  I want to extend my genuine apologies to the creators of the original material.<br/>
  Their work was the direct inspiration for this project, and I adapted it without first reaching out.<br/>
  My intent comes from a place of deep respect, and I hope this is received in the spirit of homage.
  </blockquote>
</div>


----

# Documentation - A Consolidated version - Draft 2


## 1. Project Overview and Structure

This project demonstrates various Metal rendering techniques and integrations within iOS and macOS applications. It leverages Swift, Objective-C, and Metal to showcase different rendering approaches, including:

*   **2D Rendering:** A simple triangle rendered using Metal.
*   **3D Rendering:** A rotating cube rendered with Metal.
*   **Lighting:** Rendering a teapot with lighting effects using Metal.
*   **Texturing:** Rendering a textured object (likely a cow or similar) using Metal.
*   **ARKit Integration:** Integrating ARKit to display a sphere in an augmented reality scene.
*   **SwiftUI Integration:** Uses SwiftUI `Representable` to embed UIKit/AppKit views.
*   **Objective-C Interoperability:** Utilizes Objective-C code ( `ObjCMetalPlainViewController`, `ObjCCAMetalPlainView` ) within a Swift project.


```mermaid
---
title: Project Structure
config:
  layout: elk
  look: handDrawn
  theme: dark
---
%%{
  init: {
    'fontFamily': 'verdana',
    'themeVariables': {
      'primaryColor': '#BB2528',
      'primaryTextColor': '#f529',
      'primaryBorderColor': '#7C0000',
      'lineColor': '#F8B229',
      'secondaryColor': '#006100',
      'tertiaryColor': '#fff'
    }
  }
}%%
graph LR
    A["Metal-Primitives Project"] --> B{"Platform"}
    B --> C["iOS"]
    B --> D["macOS"]

    C --> E["SwiftUI App<br>(MetalPrimitivesApp.swift)"]
    C --> F["SwiftUI Views<br>(ContentView.swift, MetalViews.swift, iOS_ViewControllerRepresentable.swift, ObjCMetalPlainViewControllerRepresentable.swift)"]
    C --> G["UIKit View Controllers<br>(ARKitViewController.swift, MyUIKitViewController.swift, ObjC_MetalPlainViewController_UIKitWrapperViewController.swift)"]
    C --> H["Swift Metal Renderers<br>(CubeRenderer.swift, TeapotRenderer.swift, CowRenderer.swift)"]
    C --> I["Swift Metal Shaders<br>(ShaderFor2DView.swift, ShaderFor3DView.swift, ShaderForLightingView.swift, ShaderForTexturingView.swift)"]
    C --> J["Objective-C Components<br>(ObjCMetalPlainViewController.h/m, ObjCCAMetalPlainView.h/m, Metal-Primitives-Bridging-Header.h)"]
    C --> K[Metal-Primitives-Bridging-Header.h]

    D --> L["SwiftUI App (MetalPrimitivesApp.swift)"]
    D --> M["SwiftUI Views<br>(ContentView.swift, MetalViews.swift, MetalPlainViewControllerRepresentable.swift)"]
    D --> N["Swift Metal Renderers<br>(CubeRenderer.swift, TeapotRenderer.swift, CowRenderer.swift)"]
    D --> O["Swift Metal Shaders (ShaderFor2DView.swift, ShaderFor3DView.swift, ShaderForLightingView.swift, ShaderForTexturingView.swift)"]
    D --> P["Objective-C Components<br>(ObjCMetalPlainViewController.h/m, ObjCCAMetalPlainView.h/m, Metal-Primitives-Bridging-Header.h)"]
    D --> Q["CoreGraphics+Extensions.swift"]
    D --> R["Foundation+Extensions.swift"]
    D --> S["FrameTimer.swift"]
    D --> T["SIMD+Extensions.swift"]

    classDef iOS_Style fill:#f455,stroke:#333,stroke-width:2px
    class C,E,F,G,H,I,J,K iOS_Style

    classDef macOS_Style fill:#f955,stroke:#333,stroke-width:2px
    class D,L,M,N,O,P,Q,R,S,T macOS_Style

    click E "https://developer.apple.com/documentation/swiftui/app"
    click F "https://developer.apple.com/documentation/swiftui/viewrepresentable"
    click G "https://developer.apple.com/documentation/uikit/uiviewcontroller"
    click H "https://developer.apple.com/documentation/metal"
    click I "https://developer.apple.com/documentation/metal"
    click J "https://developer.apple.com/documentation/objectivec"
    click K "https://developer.apple.com/documentation/swift/using-swift-with-cocoa-and-objective-c"
    click L "https://developer.apple.com/documentation/swiftui/app"
    click M "https://developer.apple.com/documentation/swiftui/viewrepresentable"
    click N "https://developer.apple.com/documentation/metal"
    click O "https://developer.apple.com/documentation/metal"
    click P "https://developer.apple.com/documentation/objectivec"
    click Q "https://developer.apple.com/documentation/coregraphics"
    click R "https://developer.apple.com/documentation/foundation"
    click S "https://developer.apple.com/documentation/foundation/nstimer"
    click T "https://developer.apple.com/documentation/simd"

```

*   This diagram shows the main components of the project, separated by platform (iOS and macOS).
*   It illustrates the dependencies between Swift code (SwiftUI, renderers, shaders), UIKit/AppKit, and Objective-C code.
*   The `Metal-Primitives-Bridging-Header.h` file is crucial for enabling Swift to interact with Objective-C code.

----

## 2.  Rendering Architectures

The project uses several different approaches to render the graphics.


```mermaid
---
title: Rendering Approaches
config:
  layout: elk
  look: handDrawn
  theme: dark
---
%%{
  init: {
    'fontFamily': 'verdana',
    'themeVariables': {
      'primaryColor': '#BB2528',
      'primaryTextColor': '#f529',
      'primaryBorderColor': '#7C0000',
      'lineColor': '#F8B229',
      'secondaryColor': '#006100',
      'tertiaryColor': '#fff'
    }
  }
}%%
graph LR
    A[Rendering Architectures] --> B{Metal}
    B --> C[CAMetalLayer]
    C --> D["Plain View<br>(Clear Screen)"]
    C --> E["2D View<br>(Triangle)"]
    C --> F["3D View<br>(Cube)"]
    C --> G["Lighting View<br>(Teapot)"]
    C --> H["Texturing View<br>(Cow)"]
    
    B --> I[MTKView]
    I --> J["Lighting View<br>(Teapot)"]
    I --> K["Texturing View<br>(Cow)"]

    A --> L{ARKit}

    L --> M[ARSCNView]
    M --> N[Sphere Anchors]
    M --> O[Plane Detection]


    classDef Metal fill:#fff4,stroke:#333,stroke-width:2px
    class B Metal

    
    classDef Style_for_ARKit_Framework fill:#1555,stroke:#333,stroke-width:2px
    class L Style_for_ARKit_Framework

    classDef CAMetalLayer fill:#f455,stroke:#333,stroke-width:2px
    class C,D,E,F,G,H CAMetalLayer
    
    
    classDef MTKView fill:#f955,stroke:#333,stroke-width:2px
    class I,J,K MTKView

    classDef ARSCNView fill:#f129,stroke:#333,stroke-width:2px
    class M,N,O ARSCNView

```

*   **`CAMetalLayer`:** This is a Core Animation layer that allows direct drawing with Metal.
    *   Used in  `CAMetalPlainView`, `CAMetal2DView`, and `CAMetal3DView`.
    *   Offers more control over the rendering process.
*   **`MTKView`:**  A MetalKit view that simplifies Metal integration by handling setup and rendering loop.
    *   Used in `MetalLightingViewRepresentable` and `MetalTexturingViewRepresentable`.
    *   Provides a convenient delegate-based approach.
*   **ARKit:** Used to create an augmented reality experience with ARKit:
    *   The  `ARKitViewController`  class manages an  `ARSession`  and uses an  `ARSCNView`  to display the AR scene.
    *   Detects horizontal planes.
    *   Adds a  `SphereAnchor`  on a tap gesture.

---

## 3. Swift and Objective-C Interaction

The project demonstrates how to integrate Objective-C code into a Swift project.

```mermaid
---
title: Swift and Objective-C Interaction
config:
  layout: elk
  look: handDrawn
  theme: dark
---
%%{
  init: {
    'fontFamily': 'verdana',
    'themeVariables': {
      'primaryColor': '#BB2528',
      'primaryTextColor': '#f529',
      'primaryBorderColor': '#7C0000',
      'lineColor': '#F8B229',
      'secondaryColor': '#006100',
      'tertiaryColor': '#fff'
    }
  }
}%%
graph LR
    A[Swift Project] --> B[Objective-C Code]
    B --> C[ObjCMetalPlainViewController]
    B --> D[ObjCCAMetalPlainView]
    A --> E[Metal-Primitives-Bridging-Header.h]
    E --> C
    E --> D
    A --> F[SwiftUI Views]
    F --> G[ObjCMetalPlainViewControllerRepresentable]
    G --> C

    classDef Style_for_Swift_Code fill:#f129,stroke:#333,stroke-width:2px
    class F,G Style_for_Swift_Code
   
    classDef Style_for_Bridging_Header_File fill:#f455,stroke:#333,stroke-width:2px
    class E Style_for_Bridging_Header_File

    classDef Style_for_ObjC_code fill:#f3f4,stroke:#333,stroke-width:2px
    class B,D,C Style_for_ObjC_code

```

*   `Metal-Primitives-Bridging-Header.h`: This header file is the bridge between Swift and Objective-C. It's where you import Objective-C header files, making their classes and methods accessible in Swift.
*   `ObjCMetalPlainViewController` and `ObjCCAMetalPlainView`:  These are Objective-C classes that are likely used to create and manage a basic Metal view. The `ObjCMetalPlainViewControllerRepresentable`  wraps the Objective-C controller so that it can be displayed within a SwiftUI environment.

---

## 4. Code Highlights

*   **Metal Setup:**  The code initializes the Metal device (`MTLCreateSystemDefaultDevice()`) and command queue (`makeCommandQueue()`).
*   **Renderers:** `CubeRenderer`, `TeapotRenderer`, and `CowRenderer` encapsulate the logic for drawing 3D objects using Metal. They manage the Metal pipeline, vertex and index buffers, and uniforms.
*   **Shaders:** The Metal shader files (e.g., `ShaderFor2DView.metal`, `ShaderFor3DView.metal`) define the vertex and fragment shaders, which are responsible for transforming vertices and calculating pixel colors.
*   **SwiftUI Integration:**  The `UIViewRepresentable` and `NSViewRepresentable` protocols are used to embed UIKit/AppKit views (including Metal views) within SwiftUI.
*   **ARKit Integration:** The  `ARKitViewController`  class sets up the AR session, detects planes, and adds virtual objects to the AR scene.

---

## 5.  Key Components and Relationships


```mermaid
---
title: Core Data Flow
config:
  layout: elk
  look: handDrawn
  theme: dark
---
%%{
  init: {
    'fontFamily': 'verdana',
    'themeVariables': {
      'primaryColor': '#BB2528',
      'primaryTextColor': '#f529',
      'primaryBorderColor': '#7C0000',
      'lineColor': '#F8B229',
      'secondaryColor': '#006100',
      'tertiaryColor': '#fff'
    }
  }
}%%
graph LR
    A[MetalPrimitivesApp] --> B[SwiftUI Root View]
    B --> C{Platform}
    C --> D[iOS]
    C --> E[macOS]

    D --> F[iOS_SwiftUI_RootContentView]
    F --> G[ObjCMetalPlainViewControllerRepresentable]
    G --> H[ObjCMetalPlainViewController]
    H --> I[ObjCCAMetalPlainView]
    I --> J[CAMetalLayer]

    E --> K[macOS_SwiftUI_RootContentView]
    K --> L[MetalPlainViewControllerRepresentable]
    L --> H
    H --> I
    I --> J

    subgraph Metal_Rendering_Simplified["Metal Rendering<br>(Simplified)"]
    style Metal_Rendering_Simplified fill:#ff45,stroke:#333,stroke-width:2px
        J --> M[Metal Device]
        J --> N[Command Queue]
        J --> O[Render Pipeline]
        J --> P[Vertex Data]
        J --> Q[Fragment Shader]
    end


    classDef Style_for_Swift_Code fill:#f129,stroke:#333,stroke-width:2px
    class B,L,G Style_for_Swift_Code

    classDef Style_for_Bridging_Header_File fill:#f455,stroke:#333,stroke-width:2px
    

    classDef Style_for_ObjC_Code fill:#f3f4,stroke:#333,stroke-width:2px
    class H,I Style_for_ObjC_Code
    
    classDef Style_for_iOS_Platform fill:#f455,stroke:#333,stroke-width:2px
    class D,F Style_for_iOS_Platform

    classDef Style_for_macOS_Platform fill:#f955,stroke:#333,stroke-width:2px
    class E,K Style_for_macOS_Platform
    

    classDef Metal fill:#fff4,stroke:#333,stroke-width:2px
    

    click A "https://developer.apple.com/documentation/swiftui/app"
    click B "https://developer.apple.com/documentation/swiftui/view"
    click C "https://developer.apple.com/documentation/swiftui/view"
    click D "https://developer.apple.com/documentation/swiftui/view"
    click E "https://developer.apple.com/documentation/swiftui/view"
    click F "https://developer.apple.com/documentation/swiftui/view"
    click G "https://developer.apple.com/documentation/swiftui/view"
    click H "https://developer.apple.com/documentation/uikit/uiviewcontroller"
    click I "https://developer.apple.com/documentation/uikit/uiview"
    click J "https://developer.apple.com/documentation/quartzcore/cametallayer"
    click K "https://developer.apple.com/documentation/swiftui/view"
    click L "https://developer.apple.com/documentation/swiftui/view"
    click M "https://developer.apple.com/documentation/metal"
    click N "https://developer.apple.com/documentation/metal"
    click O "https://developer.apple.com/documentation/metal"
    click P "https://developer.apple.com/documentation/metal"
    click Q "https://developer.apple.com/documentation/metal"

```

*   This diagram illustrates the flow of data and control within the application.
*   It shows how the SwiftUI app ( `MetalPrimitivesApp` ) presents views which eventually lead to Metal rendering through the Objective-C Metal views.
*   The simplified Metal rendering section highlights the key steps in Metal's rendering pipeline.

---

## 6. ARKit Workflow

```mermaid
---
title: ARKit Workflow
config:
  layout: elk
  look: handDrawn
  theme: dark
---
%%{
  init: {
    'fontFamily': 'verdana',
    'themeVariables': {
      'primaryColor': '#BB2528',
      'primaryTextColor': '#f529',
      'primaryBorderColor': '#7C0000',
      'lineColor': '#F8B229',
      'secondaryColor': '#006100',
      'tertiaryColor': '#fff'
    }
  }
}%%
graph LR
    A["ARKitViewController"] --> B["ARSession"]
    B --> C["ARWorldTrackingConfiguration"]
    A --> D["ARSCNView"]
    D --> E["ARSessionDelegate<br>(ARSceneRendererDelegate)"]
    E --> F["Camera Tracking State"]
    E --> G["Plane Detection"]
    G --> H["Create SCNPlaneGeometry"]
    A --> I["Tap Gesture Recognizer"]
    I --> J["Get Camera Transform"]
    I --> K["Create SphereAnchor"]
    B --> K

    classDef Style_for_ARKit_Framework fill:#1555,stroke:#333,stroke-width:2px
    class A Style_for_ARKit_Framework

    click A "https://developer.apple.com/documentation/arkit"
    click B "https://developer.apple.com/documentation/arkit/arsession"
    click C "https://developer.apple.com/documentation/arkit/arworldtrackingconfiguration"
    click D "https://developer.apple.com/documentation/scenekit/arscnview"
    click E "https://developer.apple.com/documentation/arkit/arscnviewdelegate"
    click F "https://developer.apple.com/documentation/arkit/arcamera"
    click G "https://developer.apple.com/documentation/arkit/arplanedetection"
    click H "https://developer.apple.com/documentation/scenekit/scngeometry"
    click I "https://developer.apple.com/documentation/uikit/uitapgesturerecognizer"
    click J "https://developer.apple.com/documentation/arkit/arframe/3242800-camera"
    click K "https://developer.apple.com/documentation/arkit/aranchor"
    
```

*   This diagram outlines the core steps in the ARKit integration.
*   The  `ARKitViewController`  configures the AR session, sets up the  `ARSCNView`, and handles user interactions.
*   Plane detection is used to create a visual representation of the detected planes.
*   Tap gestures trigger the creation of a  `SphereAnchor`  at the camera's position.


---

## 7. Metal Rendering Pipeline (Simplified)


```mermaid
---
title: Metal Rendering Pipeline
config:
  layout: elk
  look: handDrawn
  theme: dark
---
%%{
  init: {
    'fontFamily': 'verdana',
    'themeVariables': {
      'primaryColor': '#BB2528',
      'primaryTextColor': '#f529',
      'primaryBorderColor': '#7C0000',
      'lineColor': '#F8B229',
      'secondaryColor': '#006100',
      'tertiaryColor': '#fff'
    }
  }
}%%
graph LR
    A[Vertex Data] --> B[Vertex Shader]
    B --> C[Primitive Assembly]
    C --> D[Rasterization]
    D --> E[Fragment Shader]
    E --> F[Depth Testing]
    F --> G[Blending]
    G --> H[Frame Buffer]

classDef Metal_Rendering_Pipeline fill:#ff45,stroke:#333,stroke-width:2px
class A Metal_Rendering_Pipeline

```

*   This diagram shows the general stages of a Metal rendering pipeline.
*   **Vertex Data**: Input data, including positions, colors, and texture coordinates.
*   **Vertex Shader**: Transforms vertex data.
*   **Primitive Assembly**: Assembles vertices into primitives (triangles, lines, etc.).
*   **Rasterization**: Converts primitives into fragments (pixels).
*   **Fragment Shader**: Calculates the color of each fragment.
*   **Depth Testing**: Determines which fragments are visible based on their depth.
*   **Blending**: Combines fragment colors.
*   **Frame Buffer**: The final output, which is displayed on the screen.

---

## 8. SwiftUI Lifecycle (Simplified)


```mermaid
---
title: SwiftUI Lifecycle (Simplified)
config:
  layout: elk
  look: handDrawn
  theme: dark
---
%%{
  init: {
    'fontFamily': 'verdana',
    'themeVariables': {
      'primaryColor': '#BB2528',
      'primaryTextColor': '#f529',
      'primaryBorderColor': '#7C0000',
      'lineColor': '#F8B229',
      'secondaryColor': '#006100',
      'tertiaryColor': '#fff'
    }
  }
}%%
graph LR
    A["App Launch"] --> B["ContentView.init()"]
    B --> C["Environment Setup"]
    C --> D["Scene Creation"]
    D --> E["View Hierarchy Construction"]
    E --> F["Body Computed"]
    F --> G["View Rendering"]
    G --> H["User Interaction"]
    H -- Changes --> F

classDef Style_for_Swift_Code fill:#f129,stroke:#333,stroke-width:2px
class A Style_for_Swift_Code

```

*   This diagram shows a high-level overview of a SwiftUI app's lifecycle.
*   **App Launch:** The application starts.
*   **`ContentView.init()`:** The main view is initialized.
*   **Environment Setup:**  The SwiftUI environment is set up.
*   **Scene Creation:** The app creates the scene.
*   **View Hierarchy Construction:** SwiftUI builds the view hierarchy.
*   **Body Computed:** The `body` property of views is computed to describe their content.
*   **View Rendering:** The view is rendered on the screen.
*   **User Interaction:** User actions trigger updates, potentially causing the `body` to be recomputed and the view to be re-rendered.

---

## 9. Code Compilation and Linking

```mermaid
---
title: Code Compilation and Linking
config:
  layout: elk
  look: handDrawn
  theme: dark
---
%%{
  init: {
    'fontFamily': 'verdana',
    'themeVariables': {
      'primaryColor': '#BB2528',
      'primaryTextColor': '#f529',
      'primaryBorderColor': '#7C0000',
      'lineColor': '#F8B229',
      'secondaryColor': '#006100',
      'tertiaryColor': '#fff'
    }
  }
}%%
graph LR
    A["Source Code<br>(.swift, .m, .h)"] --> B["Compiler"]
    B --> C["Object Code (.o)"]
    C --> D["Linker"]
    D --> E["Executable (.app)"]

    style A fill:#f39f,stroke:#333,stroke-width:2px
    style B fill:#c539,stroke:#333,stroke-width:1px
    style C fill:#c539,stroke:#333,stroke-width:1px
    style D fill:#c539,stroke:#333,stroke-width:1px
    style E fill:#c539,stroke:#333,stroke-width:1px
    
```


*   **Source Code:** The `.swift`, `.m`, and `.h` files.
*   **Compiler:** Transforms the source code into object code (`.o`).
*   **Linker:** Combines the object code files, resolves dependencies, and creates the executable application (`.app`).

---

## 10. Extensions and Utilities

*   **`CoreGraphics+Extensions.swift`:**  Provides extensions to Core Graphics types (like `CGPoint`, `CGSize`, `CGRect`) to make them conform to protocols like `Sequence` and `ExpressibleByArrayLiteral`. This enhances their usability in Swift code.
*   **`Foundation+Extensions.swift`:**  Contains extensions for Foundation classes. This file includes `ConfigurableReference` which simplifies the configuration of objects using a closure-based approach, and also extension for String to create bundle identifier.
*   **`FrameTimer.swift`:** Implements a frame timer to synchronize rendering with the display's refresh rate.  It uses `CVDisplayLink` on macOS and `CADisplayLink` on iOS.
*   **`SIMD+Extensions.swift`:** Provides useful extensions for SIMD (Single Instruction, Multiple Data) types, commonly used in Metal for vector and matrix operations. Includes convenient properties and methods.

----
