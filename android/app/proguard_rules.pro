## 🧹 Usuwa wszystkie print/println (logi)
#-assumenosideeffects class java.io.PrintStream {
#    public void println(...);
#    public void print(...);
#}

## ✅ FLUTTER embedding, pluginy i registry
#-keep class io.flutter.** { *; }
#-keep class * extends io.flutter.embedding.android.FlutterActivity { *; }
#-keep class * extends io.flutter.embedding.android.FlutterFragmentActivity { *; }
#-keep class * implements io.flutter.plugin.common.PluginRegistry$PluginRegistrantCallback { *; }
#
## ✅ JNI/metody native
#-keepclasseswithmembernames class * {
#    native <methods>;
#}
#
## ✅ Serializacja JSON
#-keepclassmembers class * {
#    @com.google.gson.annotations.SerializedName <fields>;
#}
#
## ✅ Zachowaj klasy oznaczone @Keep
#-keep @androidx.annotation.Keep class * { *; }
#
## ✅ Billing (jeśli używasz zakupów w aplikacji)
#-keep class com.android.billingclient.** { *; }
#
## ❗ NIE dodawaj keep/dontwarn dla `com.google.ads.**` – są już w SDK.
