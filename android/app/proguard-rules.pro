#Flutter Wrapper
-keep class com.shockwave.**
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

#Image Cropper
-keep class io.flutter.plugin.editing.** { *; }
-keep class androidx.lifecycle.DefaultLifecycleObserver
-dontwarn com.yalantis.ucrop**
-keep class com.yalantis.ucrop** { *; }
-keep interface com.yalantis.ucrop** { *; }
-keep class androidx.appcompat.** { *; }

-keep class com.google.android.gms.** { *; }