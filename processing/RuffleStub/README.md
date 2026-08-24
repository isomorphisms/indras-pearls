# Processing ruffle stub

For now, use Processing and stop choosing rendering infrastructure.

The immediate problem is not the renderer. It is specifying the map from the intrinsic hyperbolic geometry to the Euclidean 3-space positions that Processing will draw.

## What Processing will actually draw

A finite triangulated surface in 3-space.

Each vertex ultimately needs only

```
(x, y, z)
```

and each triangle needs three vertex indices. Processing can draw those triangles with `P3D`.

The mathematical work happens before that.

## Intrinsic hyperbolic patch

Use polar coordinates `(r, theta)` for a first stub. For curvature `-1`, the hyperbolic metric is

```
ds^2 = dr^2 + sinh(r)^2 dtheta^2
```

so a circle at hyperbolic radius `r` wants circumference

```
C(r) = 2 pi sinh(r)
```

and the disk through that radius has area

```
A(r) = 2 pi (cosh(r) - 1).
```

The important point for rendering is that **area is not converted directly into height or wave amplitude**. The formulas tell us the intrinsic amount of surface and edge length that has to fit into each outward band.

For a mesh with radial step `dr` and `N` angular samples, a ring at radius `r` has a target tangential edge length of approximately

```
2 pi sinh(r) / N
```

while neighboring rings have target radial separation approximately `dr`.

That gives us an intrinsic triangulated mesh with desired edge lengths.

## Where the ruffle enters

If the same intrinsic radial distance `r` were laid flat in an ordinary Euclidean disk, the available circumference would only be

```
2 pi r.
```

But hyperbolic circumference is

```
2 pi sinh(r),
```

which grows much faster.

The ruffling is a way of putting that excess intrinsic circumference into 3-space by bending the surface instead of simply stretching it flat.

So the missing mathematical object is a placement

```
X(r, theta) = (x, y, z)
```

or, discretely, one 3-D position per mesh vertex, such that the ordinary Euclidean distances between nearby 3-D vertices approximate the hyperbolic target edge lengths.

That is the piece we have **not specified yet**. Do not invent a formula for ruffle height from hyperbolic area.

## First pipeline

The first implementation should have only these stages:

```
(r, theta) sample grid
        |
        v
hyperbolic target lengths / intrinsic mesh
        |
        v
3-D embedding or approximation       <-- missing mathematics goes here
        |
        v
triangle vertex positions
        |
        v
Processing P3D draw loop
```

Processing should know nothing about group theory, Kleinian groups, or the eventual application beyond receiving the vertex positions and triangles it needs to draw.

## What the current sketch stubs

`RuffleStub.pde` deliberately keeps one function as the boundary:

```
PVector surfacePoint(float r, float theta)
```

For the moment that function returns a flat Euclidean annulus so that the mesh, camera, and triangle drawing can be exercised. **That flat return value is not a proposed model of a hyperbolic ruffle.** It is the placeholder to replace once the actual embedding rule has been decided.

## Next mathematical question

Before making the picture more elaborate, decide what we mean by the ruffle/frill construction:

- an explicit parametric immersion/embedding;
- a discrete mesh whose edge lengths are constrained by the hyperbolic metric and then relaxed in 3-space;
- some construction particular to the surfaces in *Indra's Pearls*;
- or something else.

Until that is decided, renderer work should stop at the triangulated-surface stub.