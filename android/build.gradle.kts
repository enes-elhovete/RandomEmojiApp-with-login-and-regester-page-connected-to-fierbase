buildscript {
    repositories {
        google()
        mavenCentral()
    }

    dependencies {
        classpath("com.google.gms:google-services:4.4.2")
        // يمكنك إضافة Classpaths إضافية هنا
    }
}

// إعداد مجلد البناء إلى موقع مخصص
val newBuildDir = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.set(newBuildDir)

subprojects {
    val newSubprojectBuildDir = newBuildDir.dir(project.name)
    project.layout.buildDirectory.set(newSubprojectBuildDir)
    project.evaluationDependsOn(":app")
}

// مهمة حذف مجلد البناء
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
