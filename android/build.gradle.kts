allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Change the buildDir for the root project
buildDir = file("../../build")

subprojects {
    // Set buildDir for each subproject
    buildDir = file("${rootProject.buildDir}/${project.name}")
}

// Clean task
tasks.register<Delete>("clean") {
    delete(buildDir)
}
