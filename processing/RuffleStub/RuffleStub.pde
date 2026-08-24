// Processing/P3D stub for the eventual hyperbolic ruffle renderer.
//
// This file intentionally does NOT contain the missing mathematics that maps
// the intrinsic hyperbolic metric to a ruffled surface in R^3.  The single
// replacement boundary is surfacePoint(r, theta).

int radialSteps = 32;
int angularSteps = 160;

float innerR = 0.20;
float outerR = 2.40;
float drawingScale = 90.0;

void settings() {
  size(800, 800, P3D);
}

void setup() {
  smooth(8);
}

void draw() {
  background(245);
  lights();

  translate(width * 0.5, height * 0.5, 0);
  rotateX(-0.85);
  rotateZ(frameCount * 0.002);

  stroke(30, 80);
  fill(210);
  drawSurface();
}

void drawSurface() {
  float dr = (outerR - innerR) / radialSteps;
  float dtheta = TWO_PI / angularSteps;

  beginShape(TRIANGLES);

  for (int i = 0; i < radialSteps; i++) {
    float r0 = innerR + i * dr;
    float r1 = r0 + dr;

    for (int j = 0; j < angularSteps; j++) {
      float t0 = j * dtheta;
      float t1 = (j + 1) * dtheta;

      PVector a = surfacePoint(r0, t0);
      PVector b = surfacePoint(r1, t0);
      PVector c = surfacePoint(r1, t1);
      PVector d = surfacePoint(r0, t1);

      emitVertex(a);
      emitVertex(b);
      emitVertex(c);

      emitVertex(a);
      emitVertex(c);
      emitVertex(d);
    }
  }

  endShape();
}

void emitVertex(PVector p) {
  vertex(
    drawingScale * p.x,
    drawingScale * p.y,
    drawingScale * p.z
  );
}

// THIS IS THE PLACEHOLDER.
//
// It currently returns a flat Euclidean annulus merely so that the mesh and
// Processing drawing path exist.  It is NOT a proposed hyperbolic embedding.
// Replace this function when the actual ruffle/frill construction is specified.
PVector surfacePoint(float r, float theta) {
  return new PVector(
    r * cos(theta),
    r * sin(theta),
    0
  );
}

// Intrinsic hyperbolic bookkeeping for curvature -1.
// These functions do not yet control surfacePoint().
float hyperbolicCircumference(float r) {
  return TWO_PI * (float)Math.sinh(r);
}

float hyperbolicDiskArea(float r) {
  return TWO_PI * ((float)Math.cosh(r) - 1.0);
}

float targetTangentialEdgeLength(float r) {
  return hyperbolicCircumference(r) / angularSteps;
}
