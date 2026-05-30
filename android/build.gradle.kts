extra["compileSdk"] = 36
extra["targetSdk"] = 36
extra["minSdk"] = 24 // less than 24 breaks dex


allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    afterEvaluate {
        if (project.hasProperty("android")) {
            val androidExtension = project.extensions.getByName("android") as com.android.build.gradle.BaseExtension
            androidExtension.compileSdkVersion(rootProject.extra["compileSdk"] as Int)
        }
    }
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
