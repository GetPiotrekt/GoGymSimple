# Usuwa wszystkie wywołania print i println z System.out
-assumenosideeffects class java.io.PrintStream {
    public void println(...);
    public void print(...);
}

# Flutter - podstawowe reguły (możesz dopasować do swojego projektu)
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.embedding.** { *; }

-keep class * extends io.flutter.embedding.android.FlutterActivity { *; }

-keep class * implements io.flutter.plugin.common.PluginRegistry$PluginRegistrantCallback { *; }

-keepclasseswithmembernames class * {
    native <methods>;
}

-keepclassmembers class * {
    @com.google.gson.annotations.SerializedName <fields>;
}

-keep @androidx.annotation.Keep class * { *; }
