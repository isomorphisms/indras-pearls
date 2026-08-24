# Rendering ruffles and frills

Living design-debate notes for rendering the ruffles/frills material from *Indra's Pearls*.

## Current decision

Use **Processing** for the current prototype and stop the renderer/backend bakeoff for now.

The immediate unknown is mathematical: how the intrinsic hyperbolic geometry is turned into a finite ruffled or frilled surface in ordinary 3-space. There is no point adding more graphics infrastructure until that map is specified.

The Processing stub lives in `processing/RuffleStub/`.

## Target

The actual target is Android, not a generic browser. Browser portability is therefore not a reason by itself to choose a web rendering stack.

## What we expect to draw

At the rendering boundary, the object is simple: a finite triangulated surface in 3-space.

Processing receives 3-D vertex positions and triangles and draws them with `P3D`.

Before rendering, however, there are two separate geometries:

1. **Intrinsic hyperbolic geometry** says what distances, circumferences, and areas the surface itself should have.
2. **Extrinsic 3-D placement** says where those points are placed in ordinary Euclidean 3-space so that the sheet bends into a ruffle/frill while approximately respecting the intrinsic geometry.

For curvature `-1`, a useful polar-coordinate bookkeeping model is

```
ds^2 = dr^2 + sinh(r)^2 dtheta^2
C(r) = 2 pi sinh(r)
A(r) = 2 pi (cosh(r) - 1)
```

A flat Euclidean disk at the same radial distance would only have circumference `2 pi r`. The hyperbolic surface therefore wants much more material around the outer rings. The ruffle is the 3-D bending that accommodates that excess intrinsic circumference.

Do **not** read the hyperbolic area formula as a formula for ruffle height. Area/circumference give intrinsic target geometry. A separate embedding or approximation determines `(x,y,z)`.

The missing mathematical boundary is therefore

```
X(r, theta) = (x, y, z)
```

or its discrete equivalent: a 3-D position for every mesh vertex whose nearby Euclidean edge lengths approximate the hyperbolic target lengths.

## JavaScript / Three.js question

Three.js was considered because it can plainly render interactive geometry, but it is not the current direction. JavaScript plus Three.js introduces another runtime/library surface, and the target is Android rather than a generic browser.

This is not a permanent rejection of Three.js. It is simply irrelevant to the present mathematical problem.

## Separate renderer repositories

Renderer experiments can always live in separate repositories. Dependency surface inside the main repository is therefore not by itself a reason to reject an experiment.

That point remains true, but it is not a reason to keep starting renderer experiments before the ruffle construction itself is understood.

## Processing

Processing is the current choice because it is close to the mathematical-sketch workflow: construct points/triangles and draw them directly.

The first stub uses a regular `(r, theta)` mesh and isolates the missing mathematics in one function:

```
PVector surfacePoint(float r, float theta)
```

For now that function returns a flat annulus solely so that the mesh/camera/drawing path exists. The flat annulus is **not** a proposed hyperbolic model.

Once the ruffle/frill construction is specified, `surfacePoint` (or a discrete embedding stage replacing it) is where that mathematics enters.

## Other renderer directions — parked

Previously discussed possibilities include raw OpenGL ES, Filament, bgfx, libGDX, Three.js, and Vulkan. They are parked. Do not spend current work comparing or implementing them.

## Next mathematical question

Decide what construction turns the intrinsic hyperbolic patch into the visible ruffle/frill. Possibilities include an explicit parametric immersion, a constrained mesh relaxed in 3-space, or a construction specific to the examples in *Indra's Pearls*.

Until that is decided, the renderer should remain only a triangulated-surface stub.
