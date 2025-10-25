allprojects {
    repositories {
        google()
        mavenCentral()
        // [required] background_fetch
        maven(url = project(":background_fetch").projectDir.resolve("libs").toURI())
        }
    tasks.withType<JavaCompile> {
        options.compilerArgs.add("-Xlint:deprecation")
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.set(newBuildDir)

extra["compileSdkVersion"] = 36     // or higher / as desired    
extra["targetSdkVersion"] = 36      // or higher / as desired


rootProject.buildDir = file("../build")

subprojects {
    buildDir = file("${rootProject.buildDir}/${name}")
}

subprojects {
    evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.buildDir)
}
