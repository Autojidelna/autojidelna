plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

import java.util.Properties
import java.io.FileInputStream

var localProperties = Properties().apply {
    val file = rootProject.file("local.properties")
    if(file.exists()) {
        file.inputStream().use {load(it) }
    }
}

var flutterVersionCode = localProperties.getProperty("flutter.versionCode") ?: "1"
var flutterVersionName = localProperties.getProperty("flutter.versionName") ?: "1.0"

// Load release keystore properties
var keystoreProperties = Properties().apply {
    val file = rootProject.file("key.properties")
    if (file.exists()) {
        file.inputStream().use { load(it) }
    }
}

android {
    namespace = "cz.appelevate.autojidelna"
    compileSdk = rootProject.extra["compileSdkVersion"] as Int
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "cz.appelevate.autojidelna"
        // You can update the following values to match your application needs.
        // For more information, see: https://docs.flutter.dev/deployment/android#reviewing-the-gradle-build-configuration.
        minSdk = 24 // less than 24 breaks dex
        targetSdk = rootProject.extra["targetSdkVersion"] as Int
        versionCode = flutterVersionCode.toInt()
        versionName = flutterVersionName
    }

    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as? String
            keyPassword = keystoreProperties["keyPassword"] as? String
            storeFile = (keystoreProperties["storeFile"] as? String)?.let { file(it) }
            storePassword = keystoreProperties["storePassword"] as? String
        }
        getByName("debug") {}
    }
    
    buildTypes {
        getByName("release") {
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                // Default file with automatically generated optimization rules.
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )

            signingConfig = if (
                project.hasProperty("useDebugSigningConfig") &&
                project.property("useDebugSigningConfig").toString().toBoolean()
            ) {
                signingConfigs.getByName("debug")
            } else {
                signingConfigs.getByName("release")
            }

        }
        getByName("debug") {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
