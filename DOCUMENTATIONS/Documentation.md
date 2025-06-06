---
created: 2024-12-20 04:58:55
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
copyright: Copyright (c) 2025 Cong Le. All Rights Reserved.
---

> ⚠️🏗️🚧🦺🧱🪵🪨🪚🛠️👷
> 
> This is a working draft in progress
> 
> ![Loading...](https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExNjllNjMyMGg2Mnl5cDJjZ3F3MTN3bHhrdHR4M3drYXNsbWQ3cTF1ZiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/FaAxdPWZ7HKGmlnku7/giphy.gif)
> 
> ⚠️🏗️🚧🦺🧱🪵🪨🪚🛠️👷


----

# Documentation
> This content is dual-licensed under your choice of the following licenses:
> 1.  **MIT License:** For the code implementations in Swift and Mermaid provided in this document.
> 2.  **Creative Commons Attribution 4.0 International License (CC BY 4.0):** For all other content, including the text, explanations, and the Mermaid diagrams and illustrations.

---

In this documentation, we will provide a comprehensive set of diagrams and illustrations explaining the functionalities and complexities of the Metal Primitives App. These diagrams are intended to serve as a reference for iOS developers who are interested in understanding the app's architecture, rendering pipeline, and how it implements advanced Metal rendering techniques across both iOS and macOS platforms.

---

## Table of Contents
- [Documentation](#documentation)
  - [Table of Contents](#table-of-contents)
  - [1. High-Level Architecture Diagram](#1-high-level-architecture-diagram)
  - [2. App Structure Overview](#2-app-structure-overview)
  - [3. Class Diagram of View Controllers and Wrappers](#3-class-diagram-of-view-controllers-and-wrappers)
  - [4. App Initialization Sequence Diagram](#4-app-initialization-sequence-diagram)
  - [5. Metal Views and Renderers Class Diagram](#5-metal-views-and-renderers-class-diagram)
  - [6. Metal View Rendering Flow Sequence Diagram](#6-metal-view-rendering-flow-sequence-diagram)
  - [7. Platform-Specific View Creation Flowchart](#7-platform-specific-view-creation-flowchart)
  - [8. Extensions and Utilities Relationships Diagram](#8-extensions-and-utilities-relationships-diagram)
  - [9. Metal Rendering Process Flowchart](#9-metal-rendering-process-flowchart)
  - [10. Metal View Hierarchy and Custom Views Diagram](#10-metal-view-hierarchy-and-custom-views-diagram)
  - [11. Configurable References and Protocol Extensions Diagram](#11-configurable-references-and-protocol-extensions-diagram)
  - [12. Core Graphics Extensions and Iterators Diagram](#12-core-graphics-extensions-and-iterators-diagram)
  - [13. CAMetal2DView Class Diagram](#13-cametal2dview-class-diagram)
    - [Class Diagram of `CAMetal2DView` and `MetalState`](#class-diagram-of-cametal2dview-and-metalstate)
    - [Code Architecture Emphasizing Protocols and Extensions](#code-architecture-emphasizing-protocols-and-extensions)
    - [Expanded Class Diagram with `FrameTimer` and Rendering Pipeline](#expanded-class-diagram-with-frametimer-and-rendering-pipeline)
    - [High-Level Overview of Cross-Platform Support](#high-level-overview-of-cross-platform-support)
    - [Platform-Specific Implementation Flowchart](#platform-specific-implementation-flowchart)
  - [14. CAMetal2DView Initialization and Rendering Sequence Diagram](#14-cametal2dview-initialization-and-rendering-sequence-diagram)
  - [15. CAMetal2DView Draw Method Flowchart](#15-cametal2dview-draw-method-flowchart)
  - [16. Shader Structures and Render Pipeline Diagram](#16-shader-structures-and-render-pipeline-diagram)
    - [Timing and Rendering Synchronization with `FrameTimer`](#timing-and-rendering-synchronization-with-frametimer)
    - [Data Flow Diagram of Vertex Data Setup](#data-flow-diagram-of-vertex-data-setup)
    - [Activity Diagram of `MetalState` Initialization](#activity-diagram-of-metalstate-initialization)
  - [17. Thread Safety and Synchronization Diagram](#17-thread-safety-and-synchronization-diagram)
  - [Conclusion](#conclusion)

---

## 1. High-Level Architecture Diagram

This diagram provides an overview of the entire app's architecture, highlighting the conditional compilation for iOS and macOS platforms and how different views are integrated.

```mermaid
---
title: "High-Level Architecture Diagram"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY-SA 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  layout: elk
  theme: dark
  look: handDrawn
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%%%%%%% Available curve styles include the following keywords:
%% basis, bumpX, bumpY, cardinal, catmullRom, linear, monotoneX, monotoneY, natural, step, stepAfter, stepBefore.
%%{
  init: {
    'securityLevel': 'loose',
    'flowchart': { 'htmlLabels': true, 'curve': 'basis' },
    'fontFamily': 'Comic Sans MS, cursive, sans-serif',
    'themeVariables': {
      'primaryColor': '#F3E333',
      'primaryTextColor': '#145A32',
      'lineColor': '#F8B229',
      'primaryBorderColor': '#27AE60',
      'secondaryColor': '#EBDEF0',
      'secondaryTextColor': '#6C3483',
      'secondaryBorderColor': '#A569BD',
      'fontSize': '15px'
    }
  }
}%%
flowchart LR
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
	direction LR
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
        direction LR
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

## 2. App Structure Overview

This class diagram illustrates the overall structure of the app, focusing on the relationships between the main app entry point, SwiftUI views, and UIKit/AppKit view controllers.

```mermaid
---
title: "App Structure Overview"
config:
  layout: elk
  look: handDrawn
  theme: base
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%{
  init: {
    "classDiagram": { "htmlLabels": false },
    'fontFamily': 'Fantasy',
    'themeVariables': {
      'primaryColor': '#B2C3',
      'primaryTextColor': '#B92',
      'primaryBorderColor': '#7c2',
      'lineColor': '#F8B229'
    }
  }
}%%
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

---

## 3. Class Diagram of View Controllers and Wrappers

This diagram shows how the SwiftUI views, UIKit/AppKit view controllers, and Objective-C view controllers interact.

```mermaid

---
title: "Class Diagram of View Controllers and Wrappers"
config:
  layout: elk
  look: handDrawn
  theme: base
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%{
  init: {
    "classDiagram": { "htmlLabels": false },
    'fontFamily': 'Fantasy',
    'themeVariables': {
      'primaryColor': '#B2C3',
      'primaryTextColor': '#B92',
      'primaryBorderColor': '#7c2',
      'lineColor': '#F8B229'
    }
  }
}%%
classDiagram

    %% SwiftUI Views
    class iOS_SwiftUI_RootContentView {
        +body: some View
    }
    class iOS_SwiftUI_RootContentView:::SwiftUIView

    class iOS_ViewControllerRepresentable {
        +makeUIViewController()
        +updateUIViewController()
    }
    class iOS_ViewControllerRepresentable:::UIViewControllerRepresentable
    iOS_ViewControllerRepresentable ..|> UIViewControllerRepresentable

    iOS_SwiftUI_RootContentView --> iOS_ViewControllerRepresentable

    %% UIKit View Controller Wrapper
    class ObjC_MetalPlainViewController_UIKitWrapperViewController {
        +viewDidLoad()
        +addChildViewController()
    }
    class ObjC_MetalPlainViewController_UIKitWrapperViewController:::ViewController
    iOS_ViewControllerRepresentable --> ObjC_MetalPlainViewController_UIKitWrapperViewController : UIViewControllerType

    %% Objective-C View Controller
    class ObjCMetalPlainViewController {
        +Metal rendering code
    }
    class ObjCMetalPlainViewController:::ObjectiveCVC
    ObjC_MetalPlainViewController_UIKitWrapperViewController --> ObjCMetalPlainViewController : adds Child VC

    %% Typealiases and Base Classes
    class MySwiftViewController
    MySwiftViewController <|-- UIViewController
    MySwiftViewController <|-- NSViewController
    ObjC_MetalPlainViewController_UIKitWrapperViewController <|-- MySwiftViewController

    %%%%Note: GitHub does not support this ssyntax for now%%%%
    %% Define styles
    %%classDef UIViewControllerRepresentable fill:#E810F,stroke:#F54
    %%classDef ViewController fill:#FCE8E,stroke:#E51
    %%classDef SwiftUIView fill:#FFF7E,stroke:#F05
    %%classDef ObjectiveCVC fill:#E6F4E,stroke:#F53

```

**Explanation:**

- `iOS_SwiftUI_RootContentView` is a SwiftUI view that includes `iOS_ViewControllerRepresentable`.
- `iOS_ViewControllerRepresentable` bridges the UIKit view controller (`ObjC_MetalPlainViewController_UIKitWrapperViewController`) into SwiftUI.
- `ObjC_MetalPlainViewController_UIKitWrapperViewController` is a UIKit view controller that adds the Objective-C Metal view controller as a child.
- `ObjCMetalPlainViewController` is the Objective-C view controller that handles Metal rendering.

---

## 4. App Initialization Sequence Diagram

This sequence diagram illustrates the flow of control during the app's initialization, highlighting how views and view controllers are created and connected.

```mermaid
---
title: "App Initialization Sequence"
author: "Cong Le"
version: "0.1"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  layout: elk
  theme: base
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%{
  init: {
    'sequence': { 'mirrorActors': true, 'showSequenceNumbers': true, 'actorMargin': 50 },
    'fontFamily': 'Monaco',
    'themeVariables': {
      'primaryColor': '#2BB8',
      'primaryBorderColor': '#7C0000',
      'lineColor': '#F8B229',
      'secondaryColor': '#6122',
      'tertiaryColor': '#fff',
      'fontSize': '15px',
      'textColor': '#F8B229',
      'actorTextColor': '#E2E',
      'stroke':'#033',
      'stroke-width': '0.2px'
    }
  }
}%%
sequenceDiagram
    autonumber
    participant App as MetalPrimitivesApp
    participant WG as WindowGroup
    participant View as iOS_SwiftUI_RootContentView
    participant Wrapper as iOS_ViewControllerRepresentable
    participant VC as ObjC_MetalPlainViewController_UIKitWrapperViewController
    participant ObjC_VC as ObjCMetalPlainViewController

    App->>+WG: Instantiate WindowGroup
    WG->>+View: Instantiate iOS_SwiftUI_RootContentView
    View->>+Wrapper: Instantiate iOS_ViewControllerRepresentable
    Wrapper->>+VC: makeUIViewController()
    VC->>+VC: viewDidLoad()
    VC->>+ObjC_VC: addChild(ObjCMetalPlainViewController)
    ObjC_VC->>+ObjC_VC: viewDidLoad()
    VC-->>-Wrapper: didMove(toParent: VC)
    Wrapper-->>-View: UIViewControllerType is VC
    View-->>-WG: Body content is View
    WG-->>-App: Display window with content
```

**Explanation:**

- The app starts by instantiating the `WindowGroup`.
- `WindowGroup` creates the `iOS_SwiftUI_RootContentView`.
- The `iOS_SwiftUI_RootContentView` initializes the `iOS_ViewControllerRepresentable`.
- `iOS_ViewControllerRepresentable` creates the `ObjC_MetalPlainViewController_UIKitWrapperViewController`.
- The wrapper view controller adds `ObjCMetalPlainViewController` as a child.
- Each view controller's `viewDidLoad` method is called appropriately.
- Control returns up the chain, and the window displays the content.

---

## 5. Metal Views and Renderers Class Diagram

This diagram shows the relationship between the Metal views and their respective renderers.

```mermaid
---
title: "Metal Views and Renderers"
config:
  layout: elk
  look: handDrawn
  theme: base
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%{
  init: {
    "classDiagram": { "htmlLabels": false },
    'fontFamily': 'Fantasy',
    'themeVariables': {
      'primaryColor': '#B2C3',
      'primaryTextColor': '#B92',
      'primaryBorderColor': '#7c2',
      'lineColor': '#F8B229'
    }
  }
}%%
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

---

## 6. Metal View Rendering Flow Sequence Diagram

The following sequence diagram demonstrates how the Metal views are created and rendered within the app, showcasing the interaction between SwiftUI, `UIViewRepresentable`, and the Metal rendering pipeline.

```mermaid
---
title: "Metal View Rendering Flow Sequence"
author: "Cong Le"
version: "0.1"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  layout: elk
  theme: base
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%{
  init: {
    'sequence': { 'mirrorActors': true, 'showSequenceNumbers': true, 'actorMargin': 50 },
    'fontFamily': 'Monaco',
    'themeVariables': {
      'primaryColor': '#2BB8',
      'primaryBorderColor': '#7C0000',
      'lineColor': '#F8B229',
      'secondaryColor': '#6122',
      'tertiaryColor': '#fff',
      'fontSize': '15px',
      'textColor': '#F8B229',
      'actorTextColor': '#E2E',
      'stroke':'#033',
      'stroke-width': '0.2px'
    }
  }
}%%
sequenceDiagram
    autonumber
    participant SwiftUI as SwiftUI View
    participant Representable as UIViewRepresentable
    participant MetalView as CAMetal3DView / MTKView
    participant Renderer as Renderer <br/>(Coordinator)
    participant Device as MTLDevice
    participant Queue as MTLCommandQueue

    SwiftUI->>+Representable: makeUIView(context)
    Representable->>+MetalView: Instantiate Metal View
    MetalView->>+Device: Acquire MTLDevice
    Device->>+Queue: Create MTLCommandQueue
    Representable->>+Renderer: makeCoordinator()
    MetalView->>Renderer: Set delegate / renderer
    MetalView->>Renderer: draw(in: MetalView)
    Renderer->>MetalView: Render Frame
```

**Explanation:**

- The SwiftUI view calls `makeUIView(context)` on the `UIViewRepresentable`.
- The representable creates an instance of the Metal view (`CAMetal3DView` or `MTKView`).
- The Metal view acquires the `MTLDevice` and creates a `MTLCommandQueue`.
- The representable creates a coordinator, which acts as the renderer.
- The Metal view sets its delegate or renderer.
- On each frame, the Metal view calls the renderer's `draw` method to render the frame.

---

## 7. Platform-Specific View Creation Flowchart

This flowchart demonstrates how the code handles platform-specific view creation using conditional compilation.

```mermaid
---
title: "Platform-Specific View Creation"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY-SA 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  layout: elk
  theme: dark
  look: handDrawn
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%%%%%%% Available curve styles include the following keywords:
%% basis, bumpX, bumpY, cardinal, catmullRom, linear, monotoneX, monotoneY, natural, step, stepAfter, stepBefore.
%%{
  init: {
    'securityLevel': 'loose',
    'flowchart': { 'htmlLabels': true, 'curve': 'basis' },
    'fontFamily': 'Comic Sans MS, cursive, sans-serif',
    'themeVariables': {
      'primaryColor': '#F3E333',
      'primaryTextColor': '#145A32',
      'lineColor': '#F8B229',
      'primaryBorderColor': '#27AE60',
      'secondaryColor': '#EBDEF0',
      'secondaryTextColor': '#6C3483',
      'secondaryBorderColor': '#A569BD',
      'fontSize': '15px'
    }
  }
}%%
flowchart TD
    %% Define styles
    classDef ProcessStep fill:#F7E6,stroke:#FBBC05

    Start([Start]):::ProcessStep
    Start --> CheckOS{Is the OS iOS?}
    class CheckOS decision

    CheckOS -- Yes --> ImportUIKit[Import UIKit]:::ProcessStep
    ImportUIKit --> DefineMySwiftViewController[Define MySwiftViewController<br>as UIViewController]:::ProcessStep

    CheckOS -- No --> ImportAppKit[Import AppKit]:::ProcessStep
    ImportAppKit --> DefineMySwiftViewControllerMac[Define MySwiftViewController<br>as NSViewController]:::ProcessStep

    DefineMySwiftViewController --> Continue[Continue with Shared Logic]:::ProcessStep
    DefineMySwiftViewControllerMac --> Continue

    Continue --> ImplementViews[Implement Views using<br>UIKit or AppKit]:::ProcessStep
    ImplementViews --> WrapViews[Wrap Views into SwiftUI using<br>UIViewRepresentable or NSViewRepresentable]:::ProcessStep
```

**Explanation:**

- The app starts and checks the operating system.
- If the OS is iOS, it imports UIKit and defines `MySwiftViewController` as `UIViewController`.
- If the OS is macOS, it imports AppKit and defines `MySwiftViewController` as `NSViewController`.
- Shared logic continues, and views are implemented using the appropriate framework.
- Views are wrapped into SwiftUI using the respective representable protocols.

---

## 8. Extensions and Utilities Relationships Diagram

The class diagram below shows how extensions and utilities are designed to add functionality to existing structures like `CGPoint`, `CGSize`, and `CGRect`.

```mermaid
---
title: "Extensions and Utilities Relationships"
config:
  layout: elk
  look: handDrawn
  theme: base
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%{
  init: {
    "classDiagram": { "htmlLabels": false },
    'fontFamily': 'Fantasy',
    'themeVariables': {
      'primaryColor': '#B2C3',
      'primaryTextColor': '#B92',
      'primaryBorderColor': '#7c2',
      'lineColor': '#F8B229'
    }
  }
}%%
classDiagram
    %% Core Graphics Structures
    class CGPoint {
        +x: CGFloat
        +y: CGFloat
    }
    class CGSize {
        +width: CGFloat
        +height: CGFloat
    }
    class CGRect {
        +origin: CGPoint
        +size: CGSize
    }

    %% Extensions
    CGPoint ..|> Sequence
    CGSize ..|> Sequence
    CGRect ..|> Sequence

    CGPoint ..|> ExpressibleByIntegerLiteral
    CGSize ..|> ExpressibleByIntegerLiteral
    CGRect ..|> ExpressibleByIntegerLiteral

    CGPoint ..|> ExpressibleByFloatLiteral
    CGSize ..|> ExpressibleByFloatLiteral
    CGRect ..|> ExpressibleByFloatLiteral

    CGPoint ..|> ExpressibleByArrayLiteral
    CGSize ..|> ExpressibleByArrayLiteral
    CGRect ..|> ExpressibleByArrayLiteral

    %% Iterators
    class PairIterator~T~
    class QuadIterator~T~

    CGPoint --> PairIterator
    CGSize --> PairIterator
    CGRect --> QuadIterator
```

**Explanation:**

- `CGPoint`, `CGSize`, and `CGRect` are extended to conform to `Sequence` and various literal protocols.
- Custom iterators (`PairIterator` and `QuadIterator`) are used to enable iteration over the components of these structures.
- This adds syntactic sugar and convenience when working with these types in code.

---

## 9. Metal Rendering Process Flowchart

This flowchart outlines the steps involved in the `CAMetalPlainView`'s rendering process.

```mermaid
---
title: "Metal Rendering Process"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY-SA 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  layout: elk
  theme: dark
  look: handDrawn
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%%%%%%% Available curve styles include the following keywords:
%% basis, bumpX, bumpY, cardinal, catmullRom, linear, monotoneX, monotoneY, natural, step, stepAfter, stepBefore.
%%{
  init: {
    'securityLevel': 'loose',
    'flowchart': { 'htmlLabels': true, 'curve': 'basis' },
    'fontFamily': 'Comic Sans MS, cursive, sans-serif',
    'themeVariables': {
      'primaryColor': '#F3E333',
      'primaryTextColor': '#145A32',
      'lineColor': '#F8B229',
      'primaryBorderColor': '#27AE60',
      'secondaryColor': '#EBDEF0',
      'secondaryTextColor': '#6C3483',
      'secondaryBorderColor': '#A569BD',
      'fontSize': '15px'
    }
  }
}%%
flowchart TD
    %% Define styles
    classDef ProcessStep fill:#E6F4,stroke:#34A853
    classDef Decision fill:#FFF7,stroke:#FBBC05

    Start([Start Drawing]):::ProcessStep
    Start --> CheckDrawableSize{Is Drawable Size Valid?}:::Decision
    CheckDrawableSize -- No --> End([Return]):::ProcessStep
    CheckDrawableSize -- Yes --> GetDrawable[Get Next Drawable]:::ProcessStep
    GetDrawable --> CreateCommandBuffer[Create Command Buffer]:::ProcessStep
    CreateCommandBuffer --> CreateRenderPassDescriptor[Create Render Pass Descriptor]:::ProcessStep
    CreateRenderPassDescriptor --> CreateRenderCommandEncoder[Create Render Command Encoder]:::ProcessStep
    CreateRenderCommandEncoder --> EndEncoding[End Encoding]:::ProcessStep
    EndEncoding --> PresentDrawable[Present Drawable]:::ProcessStep
    PresentDrawable --> CommitCommandBuffer[Commit Command Buffer]:::ProcessStep
    CommitCommandBuffer --> End([End Drawing]):::ProcessStep
```

**Explanation:**

- The rendering process starts by checking if the drawable size is valid.
- If valid, it proceeds to get the next drawable from the layer.
- A command buffer is created, along with a render pass descriptor.
- A render command encoder is created to encode rendering commands.
- After encoding, the encoder is ended.
- The drawable is presented, and the command buffer is committed.
- The process ends, ready for the next frame.

---

## 10. Metal View Hierarchy and Custom Views Diagram

This class diagram shows the hierarchy and relationships between custom Metal views and their UIKit/AppKit counterparts, emphasizing the shared logic across platforms.

```mermaid
---
title: "Metal View Hierarchy and Custom Views"
config:
  layout: elk
  look: handDrawn
  theme: base
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%{
  init: {
    "classDiagram": { "htmlLabels": false },
    'fontFamily': 'Fantasy',
    'themeVariables': {
      'primaryColor': '#B2C3',
      'primaryTextColor': '#B92',
      'primaryBorderColor': '#7c2',
      'lineColor': '#F8B229'
    }
  }
}%%
classDiagram
    %% Base Classes
    class CAMetalPlainView
    class CAMetal2DView
    class CAMetal3DView

    %% Platform-Specific Subclasses
    CAMetalPlainView <|-- iOS_CAMetalPlainView
    CAMetalPlainView <|-- macOS_CAMetalPlainView

    CAMetal2DView <|-- iOS_CAMetal2DView
    CAMetal2DView <|-- macOS_CAMetal2DView

    CAMetal3DView <|-- iOS_CAMetal3DView
    CAMetal3DView <|-- macOS_CAMetal3DView

    %% Conformance
    iOS_CAMetalPlainView ..|> UIView
    macOS_CAMetalPlainView ..|> NSView

    iOS_CAMetal2DView ..|> UIView
    macOS_CAMetal2DView ..|> NSView

    iOS_CAMetal3DView ..|> UIView
    macOS_CAMetal3DView ..|> NSView

    %% Renderers
    class CubeRenderer
    class TeapotRenderer
    class CowRenderer

    CAMetal3DView --> CubeRenderer
    CAMetal2DView --> TeapotRenderer
    CAMetalPlainView --> CowRenderer
```

**Explanation:**

- Custom Metal views (`CAMetalPlainView`, `CAMetal2DView`, `CAMetal3DView`) are subclassed for iOS and macOS.
- These subclasses conform to their respective platform's view classes (`UIView` or `NSView`).
- Each Metal view uses a renderer that handles the drawing logic.

---

## 11. Configurable References and Protocol Extensions Diagram

The class diagram below illustrates how protocols and extensions are used to provide configurable references across different types, enhancing code reusability and readability.

```mermaid
---
title: "Configurable References and Protocol Extensions"
config:
  layout: elk
  look: handDrawn
  theme: base
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%{
  init: {
    "classDiagram": { "htmlLabels": false },
    'fontFamily': 'Fantasy',
    'themeVariables': {
      'primaryColor': '#B2C3',
      'primaryTextColor': '#B92',
      'primaryBorderColor': '#7c2',
      'lineColor': '#F8B229'
    }
  }
}%%
classDiagram
    %% Protocol
    class ConfigurableReference {
        <<protocol>>
        +configure(block: (Self) -> Void): Self
    }

    %% Types Conforming to ConfigurableReference
    NSObjectProtocol ..|> ConfigurableReference
    MTLCommandQueue ..|> ConfigurableReference
    CAMetalLayer ..|> ConfigurableReference
    MTKView ..|> ConfigurableReference
    MTLBuffer ..|> ConfigurableReference
    NSLock ..|> ConfigurableReference

```

**Explanation:**

- The `ConfigurableReference` protocol allows objects to be configured using a closure.
- Several classes conform to this protocol, making it convenient to chain configurations.
- The protocol extension provides a default implementation for any `NSObjectProtocol` conforming type.

---

## 12. Core Graphics Extensions and Iterators Diagram

This class diagram demonstrates how custom iterators are implemented for `CGPoint`, `CGSize`, and `CGRect`, enabling them to conform to `Sequence` and various literal protocols.

```mermaid
---
title: "Core Graphics Extensions and Iterators"
config:
  layout: elk
  look: handDrawn
  theme: base
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%{
  init: {
    "classDiagram": { "htmlLabels": false },
    'fontFamily': 'Fantasy',
    'themeVariables': {
      'primaryColor': '#B2C3',
      'primaryTextColor': '#B92',
      'primaryBorderColor': '#7c2',
      'lineColor': '#F8B229'
    }
  }
}%%
classDiagram
    %% Core Graphics Structures
    class CGPoint {
        +x: CGFloat
        +y: CGFloat
    }
    class CGSize {
        +width: CGFloat
        +height: CGFloat
    }
    class CGRect {
        +origin: CGPoint
        +size: CGSize
    }

    %% Extensions
    CGPoint ..|> Sequence
    CGSize ..|> Sequence
    CGRect ..|> Sequence

    CGPoint ..|> ExpressibleByIntegerLiteral
    CGSize ..|> ExpressibleByIntegerLiteral
    CGRect ..|> ExpressibleByIntegerLiteral

    CGPoint ..|> ExpressibleByFloatLiteral
    CGSize ..|> ExpressibleByFloatLiteral
    CGRect ..|> ExpressibleByFloatLiteral

    CGPoint ..|> ExpressibleByArrayLiteral
    CGSize ..|> ExpressibleByArrayLiteral
    CGRect ..|> ExpressibleByArrayLiteral

    %% Iterators
    class PairIterator~T~
    class QuadIterator~T~

    CGPoint --> PairIterator
    CGSize --> PairIterator
    CGRect --> QuadIterator
```

---

## 13. CAMetal2DView Class Diagram

This diagram shows the class hierarchy and composition of `CAMetal2DView` and its inner class `MetalState`.

```mermaid
---
title: "CAMetal2DView Class"
config:
  layout: elk
  look: handDrawn
  theme: base
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%{
  init: {
    "classDiagram": { "htmlLabels": false },
    'fontFamily': 'Fantasy',
    'themeVariables': {
      'primaryColor': '#B2C3',
      'primaryTextColor': '#B92',
      'primaryBorderColor': '#7c2',
      'lineColor': '#F8B229'
    }
  }
}%%
classDiagram
    %% Base Class
    class CAMetal2DView {
        +state: MetalState
        +draw(now: Double, frame: Double)
    }

    %% MetalState Inner Class
    class MetalState {
        -device: MTLDevice
        -queue: MTLCommandQueue
        -pipeline: MTLRenderPipelineState
        -buffer: MTLBuffer
        -layer: CAMetalLayer
        -lock: NSLock
        -_timer: FrameTimer?
        +timer: FrameTimer?
    }
    
    %% Platform-Specific View Classes
    class CAMetal2DViewMac {
        +makeBackingLayer() : CALayer
        +viewDidMoveToWindow()
        +setBoundsSize(newSize: NSSize)
        +setFrameSize(newSize: NSSize)
    }
    class CAMetal2DViewiOS {
        +layerClass : AnyClass
        +didMoveToWindow()
        +layoutSubviews()
    }
    CAMetal2DView <|-- CAMetal2DViewMac : inherits
    CAMetal2DView <|-- CAMetal2DViewiOS : inherits

    %% Dependencies
    CAMetal2DView --> MetalState : has a
    MetalState --> MTLDevice
    MetalState --> MTLCommandQueue
    MetalState --> MTLRenderPipelineState
    MetalState --> MTLBuffer
    MetalState --> CAMetalLayer
    MetalState --> NSLock
    MetalState --> FrameTimer

    %% ShaderVertexFor2DView Struct
    class ShaderVertexFor2DView {
        +position: float4
        +color: float4
    }
    
    MetalState --> ShaderVertexFor2DView

```

**Explanation:**
- `CAMetal2DView` is a final class that represents the Metal view, with platform-specific subclasses for macOS (`CAMetal2DViewMac`) and iOS (`CAMetal2DViewiOS`).
- The `MetalState` class encapsulates the Metal rendering state, including the device, command queue, render pipeline state, vertex buffer, Metal layer, and frame timer.
- `MetalState` owns the Metal resources and manages synchronization using a lock.
- `ShaderVertexFor2DView` is a struct representing the vertex data for rendering the triangle.

---


### Class Diagram of `CAMetal2DView` and `MetalState`

This diagram shows the class hierarchy and composition of `CAMetal2DView` and its inner class `MetalState`.

```mermaid
---
title: "Class Diagram of `CAMetal2DView` and `MetalState`"
config:
  layout: elk
  look: handDrawn
  theme: base
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%{
  init: {
    "classDiagram": { "htmlLabels": false },
    'fontFamily': 'Fantasy',
    'themeVariables': {
      'primaryColor': '#B2C3',
      'primaryTextColor': '#B92',
      'primaryBorderColor': '#7c2',
      'lineColor': '#F8B229'
    }
  }
}%%
classDiagram
    %% Platform-Specific Classes
    class CAMetal2DView {
        +state: MetalState
        +init(device: MTLDevice, queue: MTLCommandQueue)
        +draw(now: Double, frame: Double)
    }

    %% MetalState Inner Class
    class MetalState {
        -device: MTLDevice
        -queue: MTLCommandQueue
        -pipeline: MTLRenderPipelineState
        -buffer: MTLBuffer
        -layerPointer: UnsafeMutablePointer<CAMetalLayer>
        -lock: NSLock
        -_timer: FrameTimer?
        +init(device: MTLDevice, queue: MTLCommandQueue)
        +layer: CAMetalLayer
        +timer: FrameTimer?
    }
    
    %% Relationships between CAMetal2DView 
    %% and other Protocols and Extensions
    CAMetal2DView --> MetalState : has
    MetalState *-- CAMetalLayer : layerPointer
    MetalState --> NSLock : lock
    MetalState --> FrameTimer : timer

    %% Relationship betwwen CAMetal2DView 
    %% and Platform Conditional Compilation
    CAMetal2DView <|-- UIView : iOS
    CAMetal2DView <|-- NSView : macOS
```

**Explanation:**

- `CAMetal2DView` is a custom view subclassing either `UIView` (for iOS) or `NSView` (for macOS) based on the platform.
- It contains a `MetalState` instance, which holds the Metal rendering state and resources.
- `MetalState` manages the Metal device, command queue, render pipeline state, vertex buffer, and a pointer to the `CAMetalLayer`.
- The `layerPointer` in `MetalState` holds an unsafe pointer to the `CAMetalLayer` associated with the view.
- The `NSLock` is used to synchronize access to the `_timer` property, which manages the rendering loop via `FrameTimer`.

---


### Code Architecture Emphasizing Protocols and Extensions

This diagram highlights how protocols and extensions are used to enhance functionality and maintain code clarity.

```mermaid
---
title: "Code Architecture Emphasizing Protocols and Extensions"
config:
  layout: elk
  look: handDrawn
  theme: base
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%{
  init: {
    "classDiagram": { "htmlLabels": false },
    'fontFamily': 'Fantasy',
    'themeVariables': {
      'primaryColor': '#B2C3',
      'primaryTextColor': '#B92',
      'primaryBorderColor': '#7c2',
      'lineColor': '#F8B229'
    }
  }
}%%
classDiagram
    class ConfigurableReference {
        <<protocol>>
        +configure(block: (Self) -> Void) : Self
    }

    NSObjectProtocol ..|> ConfigurableReference
    MTLBuffer ..|> ConfigurableReference
    MTLRenderPassDescriptor ..|> ConfigurableReference
    CAMetalLayer ..|> ConfigurableReference
    NSLock ..|> ConfigurableReference

    CAMetal2DView *-- MetalState

    class MetalState {
        +device: MTLDevice
        +queue: MTLCommandQueue
        +pipeline: MTLRenderPipelineState
        +buffer: MTLBuffer
        +layer: CAMetalLayer
        +lock: NSLock
    }
    
```


**Explanation:**

- The `ConfigurableReference` protocol provides a `configure` method that allows for inline configuration of objects.
- Extensions conforming various classes like `MTLBuffer`, `MTLRenderPassDescriptor`, `CAMetalLayer`, and `NSLock` to `ConfigurableReference` enable cleaner and more readable code by chaining configuration calls.
- This approach enhances code maintainability and expressiveness.

---



### Expanded Class Diagram with `FrameTimer` and Rendering Pipeline

This diagram goes deeper into how the `FrameTimer`, shaders, and rendering pipeline are set up and used.

```mermaid
---
title: "Expanded Class Diagram with `FrameTimer` and Rendering Pipeline"
config:
  layout: elk
  look: handDrawn
  theme: base
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%{
  init: {
    "classDiagram": { "htmlLabels": false },
    'fontFamily': 'Fantasy',
    'themeVariables': {
      'primaryColor': '#B2C3',
      'primaryTextColor': '#B92',
      'primaryBorderColor': '#7c2',
      'lineColor': '#F8B229'
    }
  }
}%%
classDiagram
    class CAMetal2DView {
        +state: MetalState
        +draw(now: Double, frame: Double)
    }
    CAMetal2DView --> MetalState
    CAMetal2DView --> FrameTimer : uses

    class MetalState {
        +device: MTLDevice
        +queue: MTLCommandQueue
        +pipeline: MTLRenderPipelineState
        +buffer: MTLBuffer
        +layer: CAMetalLayer
        +timer: FrameTimer?
    }
    MetalState --> MTLDevice
    MetalState --> MTLCommandQueue
    MetalState --> MTLRenderPipelineState
    MetalState --> MTLBuffer
    MetalState --> CAMetalLayer
    MetalState --> FrameTimer

    class ShaderLibrary
    MTLDevice --> ShaderLibrary : makeDefaultLibrary()
    ShaderLibrary --> VertexFunction : main_vertex_for_2D_view
    ShaderLibrary --> FragmentFunction : main_fragment_for_2D_view
    MTLRenderPipelineDescriptor --> VertexFunction
    MTLRenderPipelineDescriptor --> FragmentFunction

    MTLRenderPipelineDescriptor --> MTLRenderPipelineState : makeRenderPipelineState()

    class MTLRenderPipelineDescriptor {
        +vertexFunction
        +fragmentFunction
        +colorAttachments[0].pixelFormat
    }
```

**Explanation:**

- The `MetalState` initializes the Metal pipeline by obtaining the default shader library from the device and setting up the vertex and fragment functions.
- It creates a `MTLRenderPipelineDescriptor`, sets the functions and pixel format, and creates the `MTLRenderPipelineState`.
- The `FrameTimer` is used to synchronize the rendering with the display's refresh rate, calling the `draw` method on each frame.

---


### High-Level Overview of Cross-Platform Support

This diagram highlights how `CAMetal2DView` handles cross-platform support using conditional compilation.

```mermaid
---
title: "High-Level Overview of Cross-Platform Support"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY-SA 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  layout: elk
  theme: dark
  look: handDrawn
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%%%%%%% Available curve styles include the following keywords:
%% basis, bumpX, bumpY, cardinal, catmullRom, linear, monotoneX, monotoneY, natural, step, stepAfter, stepBefore.
%%{
  init: {
    'securityLevel': 'loose',
    'graph': { 'htmlLabels': true, 'curve': 'basis' },
    'fontFamily': 'Comic Sans MS, cursive, sans-serif',
    'themeVariables': {
      'primaryColor': '#F3E333',
      'primaryTextColor': '#145A32',
      'lineColor': '#F8B229',
      'primaryBorderColor': '#27AE60',
      'secondaryColor': '#EBDEF0',
      'secondaryTextColor': '#6C3483',
      'secondaryBorderColor': '#A569BD',
      'fontSize': '15px'
    }
  }
}%%
graph TD
    CAMetal2DView
    CAMetal2DView -->|"#if os(macOS)"| CAMetal2DViewMac
    CAMetal2DView -->|"#elseif canImport(UIKit)"| CAMetal2DViewiOS
    CAMetal2DViewMac --> AppKit
    CAMetal2DViewiOS --> UIKit
    
```


**Explanation:**

- `CAMetal2DView` has platform-specific implementations for macOS and iOS, using `#if` and `#elseif` directives.
- On macOS, `CAMetal2DView` subclasses `NSView` and imports `AppKit`.
- On iOS, `CAMetal2DView` subclasses `UIView` and imports `UIKit`.
- This allows the same class to be used on both platforms with the appropriate behavior and API usage.

---


### Platform-Specific Implementation Flowchart

This flowchart shows the conditional compilation and platform-specific implementations in `CAMetal2DView`.

```mermaid
---
title: "Platform-Specific Implementation"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY-SA 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  layout: elk
  theme: dark
  look: handDrawn
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%%%%%%% Available curve styles include the following keywords:
%% basis, bumpX, bumpY, cardinal, catmullRom, linear, monotoneX, monotoneY, natural, step, stepAfter, stepBefore.
%%{
  init: {
    'securityLevel': 'loose',
    'flowchart': { 'htmlLabels': true, 'curve': 'basis' },
    'fontFamily': 'Comic Sans MS, cursive, sans-serif',
    'themeVariables': {
      'primaryColor': '#F3E333',
      'primaryTextColor': '#145A32',
      'lineColor': '#F8B229',
      'primaryBorderColor': '#27AE60',
      'secondaryColor': '#EBDEF0',
      'secondaryTextColor': '#6C3483',
      'secondaryBorderColor': '#A569BD',
      'fontSize': '15px'
    }
  }
}%%
flowchart TD
    Start([Start])
    Start --> CheckPlatform{Is Platform iOS?}
    CheckPlatform -- Yes --> UseUIView[Subclass UIView]
    UseUIView --> OverrideLayerClass
    UseUIView --> didMoveToWindow["Override didMoveToWindow()"]
    UseUIView --> layoutSubviews["Override layoutSubviews()"]
    CheckPlatform -- No --> UseNSView[Subclass NSView]
    UseNSView --> makeBackingLayer
    UseNSView --> viewDidMoveToWindow["Override viewDidMoveToWindow()"]
    UseNSView --> setBoundsSize["Override setBoundsSize()"]
    UseNSView --> setFrameSize["Override setFrameSize()"]
    
    Both --> InitializeState[Initialize MetalState]
    
```


**Explanation:**

- The code uses `#if` directives to differentiate between platforms.
- On iOS, `CAMetal2DView` subclasses `UIView` and overrides `didMoveToWindow()` and `layoutSubviews()`.
- On macOS, `CAMetal2DView` subclasses `NSView` and overrides `viewDidMoveToWindow()`, `setBoundsSize()`, and `setFrameSize()`.
- Both implementations initialize `MetalState` and set up the `CAMetalLayer`.

---

## 14. CAMetal2DView Initialization and Rendering Sequence Diagram

This diagram shows the sequence of events during initialization and the rendering loop of `CAMetal2DView`.

```mermaid
---
title: "CAMetal2DView Initialization and Rendering Sequence"
author: "Cong Le"
version: "0.1"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  layout: elk
  theme: base
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%{
  init: {
    'sequence': { 'mirrorActors': true, 'showSequenceNumbers': true, 'actorMargin': 50 },
    'fontFamily': 'Monaco',
    'themeVariables': {
      'primaryColor': '#2BB8',
      'primaryBorderColor': '#7C0000',
      'lineColor': '#F8B229',
      'secondaryColor': '#6122',
      'tertiaryColor': '#fff',
      'fontSize': '15px',
      'textColor': '#F8B229',
      'actorTextColor': '#E2E',
      'stroke':'#033',
      'stroke-width': '0.2px'
    }
  }
}%%
sequenceDiagram
    autonumber
    participant View as CAMetal2DView

	box rgb(202, 12, 22, 0.1) The Metal System
    	participant State as MetalState
    	participant Layer as CAMetalLayer
    	participant Timer as FrameTimer
    	participant Device as MTLDevice
    	participant Queue as MTLCommandQueue
	end

    Note over View: Initialization
    View->>+State: Initialize MetalState
    State->>+Device: Create MTLDevice
    State->>+Queue: Create MTLCommandQueue
    State->>+Layer: Set up CAMetalLayer
    View->>+View: didMoveToWindow()
    View->>State: Set up FrameTimer
    State->>+Timer: Initialize with callback
    Timer-->>View: Callback on each frame

    Note over View: Rendering Loop

	rect rgb(200, 15, 255, 0.1)
    	loop Every Frame
        	Timer-->>+View: draw(now, frame)
        	View->>+Layer: Get next drawable
        	View->>State: Create command buffer
        	View->>State: Create render pass descriptor
        	View->>State: Create render command encoder
        	View->>State: Encode drawing commands
        	View->>State: End encoding
        	View->>State: Present drawable
        	View->>State: Commit command buffer
    	end
	end
```

---

## 15. CAMetal2DView Draw Method Flowchart

This flowchart details the steps taken within the `draw(now: frame:)` method during each frame of rendering.

```mermaid
---
title: "CAMetal2DView Draw Method"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY-SA 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  layout: elk
  theme: dark
  look: handDrawn
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%%%%%%% Available curve styles include the following keywords:
%% basis, bumpX, bumpY, cardinal, catmullRom, linear, monotoneX, monotoneY, natural, step, stepAfter, stepBefore.
%%{
  init: {
    'securityLevel': 'loose',
    'flowchart': { 'htmlLabels': true, 'curve': 'basis' },
    'fontFamily': 'Comic Sans MS, cursive, sans-serif',
    'themeVariables': {
      'primaryColor': '#F3E333',
      'primaryTextColor': '#145A32',
      'lineColor': '#F8B229',
      'primaryBorderColor': '#27AE60',
      'secondaryColor': '#EBDEF0',
      'secondaryTextColor': '#6C3483',
      'secondaryBorderColor': '#A569BD',
      'fontSize': '15px'
    }
  }
}%%
flowchart TD
    %% Define styles
    classDef EndOfDrawMethod fill:#64EA,stroke:#34A853
    classDef Decision fill:#F7E6,stroke:#FBBC05
    classDef StartEndEncoding fill:#119F00, stroke:#333, stroke-width:2px
    classDef CheckDrawableSize fill:#ff0000, stroke:#333, stroke-width:2px
    classDef CommandBufferOperators fill:#00008B, stroke:#333, stroke-width:1px
    classDef EncoderSettings fill:#8B8000, stroke:#333, stroke-width:1px


    Start(["Start draw(now, frame)"]):::StartEndEncoding
    Start --> CheckDrawableSize{Is drawable size valid?}:::CheckDrawableSize
    CheckDrawableSize -- No --> End([Return]):::Decision
    CheckDrawableSize -- Yes --> GetDrawable[Get next drawable]:::CommandBufferOperators
    GetDrawable --> CreateCommandBuffer[Create command buffer]:::CommandBufferOperators
    CreateCommandBuffer --> CreateRenderPassDescriptor[Create render pass descriptor]:::CommandBufferOperators
    CreateRenderPassDescriptor --> CreateRenderCommandEncoder[Create render command encoder]:::CommandBufferOperators
    CreateRenderCommandEncoder --> SetPipelineState[Set render pipeline state]:::EncoderSettings
    SetPipelineState --> SetVertexBuffer[Set vertex buffer]:::EncoderSettings
    SetVertexBuffer --> DrawPrimitives["Draw primitives (triangle)"]:::EncoderSettings
    DrawPrimitives --> EndEncoding[End encoding]:::StartEndEncoding
    EndEncoding --> PresentDrawable[Present drawable]:::CommandBufferOperators
    PresentDrawable --> CommitCommandBuffer[Commit command buffer]:::CommandBufferOperators
    CommitCommandBuffer --> End([End of draw method]):::EndOfDrawMethod

```

---

## 16. Shader Structures and Render Pipeline Diagram

This class diagram illustrates the `ShaderVertexFor2DView` struct and its role in the rendering pipeline.

```mermaid
---
title: "Shader Structures and Render Pipeline"
config:
  layout: elk
  look: handDrawn
  theme: base
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%{
  init: {
    "classDiagram": { "htmlLabels": false },
    'fontFamily': 'Fantasy',
    'themeVariables': {
      'primaryColor': '#B2C3',
      'primaryTextColor': '#B92',
      'primaryBorderColor': '#7c2',
      'lineColor': '#F8B229'
    }
  }
}%%
classDiagram
    class ShaderVertexFor2DView {
        +position: SIMD4<Float>
        +color: SIMD4<Float>
    }

    class MTLBuffer
    MetalState --> MTLBuffer : buffer
    MTLBuffer --> ShaderVertexFor2DView

    %% Shaders
    class MTLLibrary
    MetalState --> MTLLibrary : makeDefaultLibrary()
    MTLLibrary --> VertexFunction : makeFunction(name "main_vertex_for_2D_view")
    MTLLibrary --> FragmentFunction : makeFunction(name "main_fragment_for_2D_view")

    MetalState --> MTLRenderPipelineDescriptor : descriptor
    MTLRenderPipelineDescriptor --> VertexFunction
    MTLRenderPipelineDescriptor --> FragmentFunction

```

**Explanation:**

- `ShaderVertexFor2DView` defines the vertex data structure used in the shaders.
- `MTLBuffer` holds the vertex data.
- The Metal library loads the shader functions used in the render pipeline.
- The pipeline descriptor references the vertex and fragment shader functions.



### Timing and Rendering Synchronization with `FrameTimer`

This sequence diagram illustrates how the `FrameTimer` is used to synchronize rendering with the display's refresh rate.

```mermaid
---
title: "Timing and Rendering Synchronization with `FrameTimer`"
author: "Cong Le"
version: "0.1"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  layout: elk
  theme: base
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%{
  init: {
    'sequence': { 'mirrorActors': true, 'showSequenceNumbers': true, 'actorMargin': 50 },
    'fontFamily': 'Monaco',
    'themeVariables': {
      'primaryColor': '#2BB8',
      'primaryBorderColor': '#7C0000',
      'lineColor': '#F8B229',
      'secondaryColor': '#6122',
      'tertiaryColor': '#fff',
      'fontSize': '15px',
      'textColor': '#F8B229',
      'actorTextColor': '#E2E',
      'stroke':'#033',
      'stroke-width': '0.2px'
    }
  }
}%%
sequenceDiagram
    participant View as CAMetal2DView
    participant State as MetalState
    participant Timer as FrameTimer
    participant Display

    View->>State: Initialize MetalState
    View->>State: Set timer to nil
    View->>View: didMoveToWindow / viewDidMoveToWindow
    View->>State: Set up layer properties
    State->>State: Set timer with FrameTimer
    Timer-->>View: draw(now, frame)
    View->>Display: Render frame
    loop Every Frame
        Display-->>Timer: VSync Signal
        Timer-->>View: draw(now, frame)
        View->>Display: Render frame
    end
```

**Explanation:**

- When the view moves to the window, it initializes the `FrameTimer` in the `MetalState`.
- The `FrameTimer` invokes the `draw(now:frame:)` method on every display refresh (VSync).
- This ensures smooth frame updates synchronized with the display's refresh rate.
- The rendering loop continues as long as the timer is active.



---

### Data Flow Diagram of Vertex Data Setup

This diagram shows how the vertex data is set up and supplied to the vertex shader.

```mermaid
---
title: "Data Flow Diagram of Vertex Data Setup"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY-SA 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  layout: elk
  theme: dark
  look: handDrawn
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%%%%%%% Available curve styles include the following keywords:
%% basis, bumpX, bumpY, cardinal, catmullRom, linear, monotoneX, monotoneY, natural, step, stepAfter, stepBefore.
%%{
  init: {
    'securityLevel': 'loose',
    'flowchart': { 'htmlLabels': true, 'curve': 'basis' },
    'fontFamily': 'Comic Sans MS, cursive, sans-serif',
    'themeVariables': {
      'primaryColor': '#F3E333',
      'primaryTextColor': '#145A32',
      'lineColor': '#F8B229',
      'primaryBorderColor': '#27AE60',
      'secondaryColor': '#EBDEF0',
      'secondaryTextColor': '#6C3483',
      'secondaryBorderColor': '#A569BD',
      'fontSize': '15px'
    }
  }
}%%
flowchart LR
    Start[Start_Initialization]
    --> CreateVertices[Create Vertices Array]
    --> CalculateLength[Calculate Buffer Length]
    --> CreateBuffer[Create MTLBuffer with Vertex Data]
    --> SetBufferLabel[Set Buffer Label]
    --> UseBuffer[Use Buffer in Encoder]
    --> VertexShader[Vertex Shader Receives Data]

    subgraph Vertex_Data [Vertex_Data]
        ShaderVertexFor2DView1((Top Vertex))
        ShaderVertexFor2DView2((Left Vertex))
        ShaderVertexFor2DView3((Right Vertex))
    end

    CreateVertices --> Vertex_Data
```

**Explanation:**

- An array of `ShaderVertexFor2DView` structs is created, representing the vertices of a triangle.
- Each vertex includes position and color data.
- The total length is calculated based on the number of vertices and the size of the struct.
- A `MTLBuffer` is created with the vertex data and labeled.
- The buffer is set in the render command encoder for use in the vertex shader.


### Activity Diagram of `MetalState` Initialization

This diagram shows the steps involved in initializing the `MetalState` object.

```mermaid
---
title: "Activity Diagram of `MetalState` Initialization"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY-SA 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  layout: elk
  theme: dark
  look: handDrawn
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%%%%%%% Available curve styles include the following keywords:
%% basis, bumpX, bumpY, cardinal, catmullRom, linear, monotoneX, monotoneY, natural, step, stepAfter, stepBefore.
%%{
  init: {
    'securityLevel': 'loose',
    'flowchart': { 'htmlLabels': true, 'curve': 'basis' },
    'fontFamily': 'Comic Sans MS, cursive, sans-serif',
    'themeVariables': {
      'primaryColor': '#F3E333',
      'primaryTextColor': '#145A32',
      'lineColor': '#F8B229',
      'primaryBorderColor': '#27AE60',
      'secondaryColor': '#EBDEF0',
      'secondaryTextColor': '#6C3483',
      'secondaryBorderColor': '#A569BD',
      'fontSize': '15px'
    }
  }
}%%
flowchart TD
%%%%%% Define styles
%% Define style for crtitical points on the flowchart
classDef Decision fill:#F7E6,stroke:#FBBC05,stroke-width:2px
classDef StartEndInitialization fill:#119F00, stroke:#333, stroke-width:2px
classDef ReturnNil fill:#7222F1, stroke:#34A853, stroke-width:2px

%% Define style for question
classDef CheckLibrary fill:#ff0000, stroke:#333, stroke-width:2px
classDef CheckPipelineState fill:#ff0000, stroke:#333, stroke-width:2px
classDef CheckBuffer fill:#ff0000, stroke:#333, stroke-width:2px

%% Define style for operators
classDef PipelineStateOperators fill:#00008B, stroke:#333, stroke-width:1px
classDef VertexBufferOperators fill:#8B8000, stroke:#333, stroke-width:1px
classDef OtherCommandOperators fill:#2F23, stroke:#333, stroke-width:1px


%%%%%% Starting the flowchart
    Start([Start MetalState.init]):::StartEndInitialization
	Start --> CheckLibrary{Make Default Library?}:::CheckLibrary
    CheckLibrary -- No --> ReturnNil[Return nil]
    CheckLibrary -- Yes --> GetFunctions[Get Vertex and Fragment Functions]:::PipelineStateOperators
    
    
    CreateDescriptor[Create Render Pipeline Descriptor]:::PipelineStateOperators

	GetFunctions -->  CreateDescriptor

    CreatePipelineState[Create Render Pipeline State]:::PipelineStateOperators
	
	CreateDescriptor -->  CreatePipelineState
    
    CreatePipelineState --> CheckPipelineState{Pipeline State Created?}:::CheckPipelineState

    CheckPipelineState -- No --> ReturnNil
    CheckPipelineState -- Yes --> CreateVertices[Create Vertex Data]:::VertexBufferOperators
    CreateVertices --> CreateBuffer[Create Vertex Buffer]:::VertexBufferOperators
    CreateBuffer --> CheckBuffer{Buffer Created?}:::CheckBuffer
    CheckBuffer -- No --> ReturnNil:::ReturnNil
    CheckBuffer -- Yes --> InitLayerPointer[Initialize Layer Pointer]:::OtherCommandOperators
    InitLayerPointer --> InitLock[Initialize NSLock]:::OtherCommandOperators
    InitLock --> End([End Initialization]):::StartEndInitialization
    
```

**Explanation:**

- The `MetalState` initializer first attempts to create the default Metal library.
- It retrieves the vertex and fragment functions needed for the pipeline.
- A render pipeline descriptor is created using these functions.
- The render pipeline state is created from the descriptor.
- Vertex data for the triangle is created and stored in a buffer.
- An unsafe pointer to the `CAMetalLayer` is allocated.
- An `NSLock` is initialized for thread safety.
- If any step fails, the initializer returns `nil`, indicating failure.


---

## 17. Thread Safety and Synchronization Diagram

This diagram illustrates how the `MetalState` class manages thread safety and synchronization using a lock when accessing the `timer` property.

```mermaid
---
title: "Thread Safety and Synchronization"
config:
  layout: elk
  look: handDrawn
  theme: base
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%{
  init: {
    "classDiagram": { "htmlLabels": false },
    'fontFamily': 'Fantasy',
    'themeVariables': {
      'primaryColor': '#B2C3',
      'primaryTextColor': '#B92',
      'primaryBorderColor': '#7c2',
      'lineColor': '#F8B229'
    }
  }
}%%
classDiagram
    class MetalState {
        -lock: NSLock
        -_timer: FrameTimer?
        +timer: FrameTimer?
        +set timer(FrameTimer?)
        +get timer() FrameTimer?
    }
    MetalState o-- NSLock : uses

    class NSLock {
        +lock()
        +unlock()
        +withLock(block)
    }

    %% Accessing Timer Property
    MetalState --> "lock/unlock" NSLock : when accessing timer
```

**Explanation:**

- `MetalState` uses an `NSLock` to ensure thread safety when accessing or modifying the `_timer` property.
- The `timer` getter and setter methods use the lock to synchronize access.
- This prevents race conditions and ensures that the timer is safely managed across threads.

---

## Conclusion

The provided diagrams offer a comprehensive visual representation of the Metal Primitives App's architecture, rendering pipeline, and class relationships. By examining these diagrams, developers can gain a deeper understanding of:

- How SwiftUI integrates with UIKit and AppKit through representable protocols.
- The rendering process using Metal, including device and command queue setup, pipeline configuration, and shader usage.
- The handling of platform-specific code using conditional compilation.
- The advanced rendering techniques implemented, such as lighting and texturing in custom shaders.
- The importance of thread safety and synchronization in managing rendering loops and state.

These visual aids serve as valuable references for developers looking to explore or extend the functionalities of the app, providing insights into best practices for cross-platform Metal rendering applications.


---

```mermaid
---
title: "CongLeSolutionX"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  theme: base
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%{
  init: {
    'flowchart': { 'htmlLabels': false },
    'fontFamily': 'Brush Script MT',
    'themeVariables': {
      'primaryColor': '#fc82',
      'primaryTextColor': '#F8B229',
      'primaryBorderColor': '#27AE60',
      'secondaryColor': '#81c784',
      'secondaryTextColor': '#6C3483',
      'lineColor': '#F8B229',
      'fontSize': '20px'
    }
  }
}%%
flowchart LR
    My_Meme@{ img: "https://github.com/CongLeSolutionX/MY_GRAPHIC_ASSETS/blob/Designing_graphic_syntax/MY_MEME_ICONS/Orange-Cloud-Search-Icon-Base-Color-Black-1024x1024.png?raw=true", label: "Ăn uống gì chưa ngừi đẹp?", pos: "b", w: 200, h: 150, constraint: "on" }

    Closing_quote@{ shape: braces, label: "Math and code work together to bring interactive art to life!" }

My_Meme ~~~ Closing_quote
Link_to_my_profile{{"<a href='https://github.com/CongLeSolutionX/CongLeSolutionX' target='_blank'>Click here if you care about my profile</a>"}}

Closing_quote ~~~ My_Meme
My_Meme animatingEdge@--> Link_to_my_profile
animatingEdge@{ animate: true }


```

----



**Licenses:**

- **MIT License:**  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) - Full text in [LICENSE](LICENSE) file.
- **Creative Commons Attribution 4.0 International:** [![License: CC BY 4.0](https://licensebuttons.net/l/by/4.0/88x31.png)](LICENSE-CC-BY) - Legal details in [LICENSE-CC-BY](LICENSE-CC-BY) and at [Creative Commons official site](http://creativecommons.org/licenses/by/4.0/).

---
