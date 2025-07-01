# Firebase Messaging
-keep class com.google.firebase.messaging.** { *; }
-keep class com.google.firebase.iid.FirebaseInstanceIdService { *; }
-keep class com.google.firebase.iid.FirebaseInstanceId { *; }
-keep class com.google.firebase.** { *; }

# Google services
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.android.gms.**

# Gson (agar use ho raha hai)
-keepattributes Signature
-keepattributes *Annotation*
-keep class com.google.gson.** { *; }

# Flutter related (optional)
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
# Please add these rules to your existing keep rules in order to suppress warnings.
# This is generated automatically by the Android Gradle plugin.
-dontwarn com.google.android.play.core.splitcompat.SplitCompatApplication
-dontwarn com.google.android.play.core.splitinstall.SplitInstallException
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManager
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManagerFactory
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest$Builder
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest
-dontwarn com.google.android.play.core.splitinstall.SplitInstallSessionState
-dontwarn com.google.android.play.core.splitinstall.SplitInstallStateUpdatedListener
-dontwarn com.google.android.play.core.tasks.OnFailureListener
-dontwarn com.google.android.play.core.tasks.OnSuccessListener
-dontwarn com.google.android.play.core.tasks.Task