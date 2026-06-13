---
sidebar_position: 4
title: Network Images (CORS Proxy)
---

# Network Images & CORS Proxy

In the CondorCode monorepo, the **`CCNetworkImageView`** widget is the standard tool for displaying remote images. It is specifically designed to handle browser-side blocking issues known as CORS.

## Why CCNetworkImageView?

- **CORS Fix** — Automatically prepends a proxy prefix to URLs to bypass restrictions in Flutter Web.
- **Consistent UI** — Ensures all external images are handled uniformly across the project.
- **Error Handling** — Provides a simplified interface for loading states and broken image placeholders.

## The Problem (CORS)

When using the standard `Image.network` in Flutter Web, images often fail to load if the host server is not configured to send `Access-Control-Allow-Origin` headers. In the browser console, this appears as a failed request or a "shattered" image icon.

Our proxy (`https://proxy.corsfix.com/?`) acts as a middleman that "authorizes" the browser to display the resource on our domain.

## Usage

Use this widget **everywhere** you need to display a network image (primarily `.png`, `.jpg`, and `.jpeg` formats).

## Implementation Details

The widget is located in the `ui_kit` package. If you need to expose more parameters from the underlying `Image.network`, update the constructor in:
`packages/ui_kit/lib/widgets/condor_code_network_image_view.dart`

If your IDE's auto-import fails to find the widget, you may need to add the import statement manually to your file:
`import 'package:ui_kit/widgets/condor_code_network_image_view.dart';`

### Basic Example

```dart
CCNetworkImageView(
  imageUrl: 'https://example.com/image.png',
)