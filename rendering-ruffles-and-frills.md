# Rendering ruffles and frills

Living design-debate notes for rendering the ruffles/frills material from *Indra's Pearls*.

## Target

The actual target is Android, not a generic browser. Browser portability is therefore not a reason by itself to choose a web rendering stack.

## JavaScript / Three.js question

Three.js is an obvious JavaScript answer for interactive geometry, but it should not be treated as the default.

Reasons to hesitate:

- JavaScript itself is not yet a comfortable dependency here. We may eventually have our own rewritten/hackable JavaScript implementation, but that is not something to assume today.
- Choosing Three.js also means taking on another substantial library surface that we may then want to modify or understand deeply.
- Every extra runtime, library, bridge, and build layer adds failure points.
- That extra surface area matters especially when the intended program is an Android application rather than a web demo.

So the question is not “can Three.js draw this?” It almost certainly can. The question is whether bringing in JavaScript + Three.js is worth the additional machinery for an Android-first renderer.

## Current bias

Prefer the smallest rendering path that can express the mathematics and run directly on Android.

Do not choose an engine yet. In particular, do not choose Three.js merely because it is familiar or convenient for browser graphics.

## Things to determine before choosing a renderer

- What are ruffles and frills geometrically in the examples we actually want to reproduce?
- Do we need a triangle mesh, line/curve rendering, a shader-defined surface, or some combination?
- Which parts should live in the mathematical core and which parts are merely display code?
- How much interaction is needed: static view, rotation/pan, parameter changes, animation?
- Can the renderer consume a small neutral geometry representation so that renderer experiments do not infect the mathematical code?
- What is the smallest Android-native path: OpenGL ES, Vulkan, Android Canvas for any 2D pieces, or some existing native library?

## Design rule for now

Keep the mathematical description of the ruffles/frills separate from whichever renderer is tried first. The first renderer should be replaceable rather than becoming the architecture.

This file should accumulate the arguments, failed experiments, and decisions as the rendering design develops.
