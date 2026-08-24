# Nico Belmonte / philogb

This project was prompted in part by Nico Belmonte's interactive WebGPU exploration of *Indra's Pearls*. His implementation is a useful reference for the visual and computational possibilities of the material.

## Indra's Pearls work

- Interactive visualization: https://philogb.github.io/page/indraspearls/
- Article, "Exploring Indra's Pearls with WebGPU": https://medium.com/@philogb/exploring-indras-pearls-with-webgpu-e0f4a745c2f6
- Video, "Indra's pearls interactive": https://www.youtube.com/watch?v=6Gd3fnSK_d4
- Public GitHub deployment repository: https://github.com/philogb/page
- Deployed `indraspearls/` directory: https://github.com/philogb/page/tree/gh-pages/indraspearls
- Deployed `index.html`: https://github.com/philogb/page/blob/gh-pages/indraspearls/index.html
- Commit that introduced the deployed visualization: https://github.com/philogb/page/commit/23b79b95981a5103a3870f63ef2e0636dd0faf07
- Hacker News discussion submitted by `philogb`: https://news.ycombinator.com/item?id=40098597

## Touch points in the deployed implementation

The public deployment is a compiled web application rather than a clean source tree, so these are the concrete mathematical and interaction touch points visible in the deployed HTML and controls. They are more reliable than pretending we have reconstructed the internals of the minified bundle.

Belmonte's presentation walks through:

- a pair of Möbius generators and their repeated action;
- Schottky groups;
- the tangent-circle/Fuchsian case;
- quasi-Fuchsian limit sets and "Indra's necklace";
- the Apollonian gasket as a special limit set;
- conjugating the gasket to related configurations such as Ford circles;
- Möbius transformations through the Riemann-sphere picture;
- bending and other limit-set deformations;
- the Maskit slice and the boundary between discrete and non-discrete groups.

The exposed controls include the complex parameter `µ`, trace, Farey numerator/denominator, a cusp-formula toggle, projection rotation/phase, and several coloring choices. In rough program terms the touch points are therefore: choose group parameters -> build/iterate transformations -> generate a limit-set approximation -> project/color -> render interactively with WebGPU.

One mathematically important layer is not spelled out in the HTML but sits underneath any such traversal: products of the two generators and their inverses are **words**. A breadth-first or depth-first traversal can enumerate reduced words while forbidding immediate cancellation/backtracking. See `words.md` for the free-monoid/free-group distinction.

## Nico Belmonte

- GitHub: https://github.com/philogb
- Medium: https://medium.com/@philogb

## License note

The `philogb/page` repository is public, and the deployed JavaScript/WGSL can therefore be inspected, but GitHub currently reports no repository-level license. The generated bundle license files cover third-party dependencies such as Complex.js, Fraction.js, and a Modernizr-derived fragment; they do not appear to grant a license for Belmonte's own Indra's Pearls application code.

Accordingly, this repository credits and links to Belmonte's work and treats it as a reference to study. Code here should be independently implemented rather than copied from his application unless a license or explicit permission covering that code is found later.
