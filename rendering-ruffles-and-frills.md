# Rendering ruffles and frills

Living design-debate notes for a ruffle/frill visualization **inspired by the hyperbolic geometry in _Indra's Pearls_**.

## Current decision

Use **Processing** for the current prototype and stop the renderer/backend bakeoff for now.

The immediate unknown is mathematical: what finite hyperbolic object we want to visualize and how to place an approximation to it in ordinary Euclidean 3-space.

The Processing stub lives in `processing/RuffleStub/`.

## What is actually in _Indra's Pearls_

Do not talk as if the book contains a ruffle/frill construction. It does not give us a 3-D Euclidean ruffled surface to reproduce.

The book is primarily about Möbius transformations, Kleinian groups, and the limit-set pictures produced by iterating them. Its direct pictures are overwhelmingly pictures in the complex plane / Riemann sphere rather than physical embeddings of hyperbolic surfaces in ordinary 3-space.

The explicit hyperbolic-geometry discussion is concentrated at the end of the book. Cambridge lists the Epilogue as pp. 373–392 and describes it as explaining the two previously deferred topics of hyperbolic geometry and Teichmüller theory. The book index points to hyperbolic geometry at pp. 373 and 376, the hyperbolic plane at pp. 379 and 381, and hyperbolic 3-space at pp. 386 and 388.

That gives us the correct book-grounded chain:

```
Möbius/Kleinian group pictures
        |
        v
hyperbolic geometry underlying the group action
        |
        v
hyperbolic plane / hyperbolic 3-space discussion in the Epilogue
```

There is **not** another book step saying

```
hyperbolic plane -> ruffled sheet in R^3
```

That last arrow is our proposed visualization.

A contemporary review by Albert Marden makes the boundary especially clear: Kleinian groups naturally act on hyperbolic 3-space and are associated with 3-manifolds and surfaces, but the authors deliberately keep the elementary presentation focused on the action on the sphere/complex plane rather than opening that larger 3-dimensional subject.

## A related explanation by Series and Wright — but not the book

Caroline Series and David Wright later wrote a public explanation of the same mathematics for Plus (2007). There they give exactly the physical intuition we have been discussing: circumference in the hyperbolic plane grows exponentially with radius, so a large hyperbolic disk, if one tries to fit it into ordinary Euclidean 3-space, has to crinkle toward its edge, compared to a kale leaf.

This is useful evidence that the ruffle intuition is mathematically connected to the authors' intended picture of hyperbolic growth. But it is a **post-book explanatory analogy**, not a rendered frill in _Indra's Pearls_. Keep that distinction visible.

## The safest first book-grounded picture

Rather than inventing a decorative frill and calling it hyperbolic, carry along something the book actually uses: a hyperbolic tiling.

In a Poincaré-disk picture, intrinsically equal tiles appear smaller and smaller as they approach the circle at infinity. A complementary 3-D experiment would take a **finite patch of the same intrinsic tiling**, try to keep neighboring edge lengths approximately equal in ordinary 3-space, and allow the sheet to buckle/crinkle as more intrinsic circumference has to fit into successive layers.

This gives the Processing picture something testable:

- the combinatorics of the tiling are fixed;
- intrinsic tile edge lengths are fixed or prescribed by the hyperbolic metric;
- the 3-D shape is allowed to bend;
- metric error can be measured instead of judged only by whether the result looks ruffly.

That would be our picture, not a reconstruction of a figure from the book.

## Target

The eventual target is Android. For the present mathematical prototype this only matters insofar as Processing gives us a straightforward path to draw and rotate a finite triangulated surface.

## What Processing will actually draw

At the rendering boundary, the object is a finite triangulated surface in 3-space.

Processing receives 3-D vertex positions and triangles and draws them with `P3D`.

Before rendering, however, there are two separate geometries:

1. **Intrinsic hyperbolic geometry** says what distances and areas the surface itself should have.
2. **Extrinsic 3-D placement** says where those points are placed in ordinary Euclidean 3-space while trying to preserve the intrinsic geometry.

For constant curvature `-1`, standard hyperbolic geometry gives the polar metric and circle/disk formulas

```
ds^2 = dr^2 + sinh(r)^2 dtheta^2
C(r) = 2 pi sinh(r)
A(r) = 2 pi (cosh(r) - 1)
```

These formulas are mathematical bookkeeping for our experiment; do not present them as quotations or a ruffle recipe from _Indra's Pearls_.

A flat Euclidean disk at radial distance `r` has circumference `2 pi r`, while the corresponding hyperbolic circle wants circumference `2 pi sinh(r)`. This is the intrinsic growth pressure behind the crinkling analogy.

Do **not** read the hyperbolic area formula as a formula for ruffle height. Area and circumference give intrinsic target geometry. A separate immersion/embedding/mesh procedure determines `(x,y,z)`.

## There cannot be one perfect global `surfacePoint`

There is also a mathematical obstruction outside the book which matters for the implementation: Hilbert's theorem says the complete hyperbolic plane cannot be regularly isometrically immersed in ordinary `R^3` as a complete constant-negative-curvature surface.

So the renderer should never promise a smooth exact realization of the whole hyperbolic plane in 3-space.

The experiment must instead choose some combination of:

- a finite patch;
- approximate preservation of lengths;
- self-intersection;
- singular/creased behavior;
- or a discrete mesh notion rather than a smooth global surface.

That makes the finite tiled patch a better first target than pretending there is a global closed-form `X(r, theta)` waiting to be typed in.

## Processing

The first stub uses a regular `(r, theta)` mesh and isolates the missing mathematics in one function:

```
PVector surfacePoint(float r, float theta)
```

For now that function returns a flat annulus solely so that the mesh/camera/drawing path exists. The flat annulus is **not** a proposed hyperbolic model.

The current function boundary may itself disappear. If the first serious construction is a discrete tiling/mesh with constrained edge lengths, the useful object will probably be an array of solved 3-D vertex positions rather than an explicit formula `X(r, theta)`.

## Things not to conflate

There are several related but different surfaces in this subject:

- the complete hyperbolic plane `H^2`;
- finite patches of `H^2` used for a visualization;
- quotient hyperbolic surfaces associated with Fuchsian/Kleinian groups;
- boundaries and pleated surfaces associated with hyperbolic 3-manifolds;
- the sphere at infinity / complex plane where the book's limit sets are actually drawn.

The current Processing stub is only trying to understand a finite patch of intrinsic hyperbolic geometry in `R^3`. Do not silently identify it with all of the other objects.

## Other renderer directions — parked

Raw OpenGL ES, Filament, bgfx, libGDX, Three.js, and Vulkan are parked. Do not spend current work comparing or implementing them.

## Next mathematical question

Choose the first intrinsic patch from the book's geometry. A regular hyperbolic tiling is a good candidate because the equality of tile sizes gives us a concrete metric condition to preserve and a direct visual comparison with the Poincaré-disk presentation.

Then decide how the finite mesh finds its 3-D positions. Until that is decided, the renderer should remain only a triangulated-surface stub.

## Sources used for this grounding

- David Mumford, Caroline Series, David Wright, _Indra's Pearls: The Vision of Felix Klein_, especially the Epilogue, pp. 373–392, and the index entries for hyperbolic geometry/plane/3-space.
- Caroline Series and David Wright, “Non-Euclidean geometry and Indra's pearls,” Plus, 2007 — useful for the kale-leaf/crinkling analogy, but not part of the book.
- Albert Marden's 2003 review in _Notices of the AMS_ — useful for distinguishing the book's sphere/complex-plane presentation from the associated hyperbolic 3-manifold/surface picture.
- Hilbert's theorem on complete constant-negative-curvature surfaces in `R^3` — an external differential-geometric constraint on our proposed renderer, not a claim from _Indra's Pearls_.
