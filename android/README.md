# Android native stub

This is the first native interaction boundary: NativeActivity + `android_native_app_glue`, EGL/GLES 3 setup, one-finger camera pan, and two-finger pinch zoom.

It is intentionally still a rendering stub. The current frame is only a dark clear; the intended first playable renderer is a full-screen GLES fragment shader for one bundled Kleinian-group limit set.

Mathematical/group state should remain separate from Android touch dispatch so it can move into Idriç/Edriç ownership cleanly.

## Build

Use the same Android toolchain as the other native math toys: JDK 17, Android SDK 36, NDK `29.0.14206865`, CMake 3.22.1, and Gradle 8.13.

```sh
gradle :android:app:assembleDebug
```

The APK is written under `android/app/build/outputs/apk/debug/`.

## Touch contract

- one finger: pan the complex plane
- two fingers: zoom
- lift: leave the camera where it is

No group-parameter gestures are wired yet.
