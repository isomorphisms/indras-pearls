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

## Separate renderer repositories

Dependency surface inside the main repository is not a reason to avoid renderer experiments. A renderer can always get its own repository. That makes a bakeoff cheap: different renderers can consume the same mathematical description without forcing their runtimes or libraries into the Indra's Pearls repository.

The question is therefore less “which dependency can we tolerate?” and more “which renderer expresses the ruffles/frills mathematics cleanly and works well on Android?”

## Processing

Processing is an obvious serious candidate for the first experiment.

Why it fits:

- It is close to the mathematical-sketch workflow: construct points, curves, triangles or a parametric surface and draw them directly.
- It does not require adopting a browser architecture or JavaScript just to get interactive 3D geometry.
- It is suitable for quickly determining what the ruffles/frills construction should actually look like before designing a lower-level renderer around it.
- If the experiment lives in its own repository, there is little cost to discovering later that Processing should not be the final renderer.

Processing should therefore be included in the renderer bakeoff, and may be the best first prototype precisely because the initial problem is mathematical visualization rather than engine architecture.

## Other candidate directions

Candidates worth comparing include:

- Processing
- raw OpenGL ES
- Filament
- bgfx
- libGDX
- Three.js
- Vulkan only if the lower-level control turns out to be necessary

This is not a ranking yet.

## Current bias

Prefer the rendering path that makes the mathematics easiest to express and runs acceptably on Android. Because experiments can live in separate repositories, do not reject a candidate merely because it brings its own library or runtime.

Do not choose an engine yet. In particular, do not choose Three.js merely because it is familiar or convenient for browser graphics.

## Things to determine before choosing a renderer

- What are ruffles and frills geometrically in the examples we actually want to reproduce?
- Do we need a triangle mesh, line/curve rendering, a shader-defined surface, or some combination?
- Which parts should live in the mathematical core and which parts are merely display code?
- How much interaction is needed: static view, rotation/pan, parameter changes, animation?
- Can the renderer consume a small neutral geometry representation so that renderer experiments do not infect the mathematical code?
- What is the smallest Android-native path if a prototype needs to become a production renderer?

## Design rule for now

Keep the mathematical description of the ruffles/frills separate from whichever renderer is tried first. The first renderer should be replaceable rather than becoming the architecture.

This file should accumulate the arguments, failed experiments, and decisions as the rendering design develops.
