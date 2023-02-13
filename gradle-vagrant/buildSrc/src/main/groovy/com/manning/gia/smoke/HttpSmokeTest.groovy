package com.manning.gia.smoke

import static groovyx.net.http.ContentType.TEXT
import org.gradle.api.DefaultTask
import org.gradle.api.GradleException
import org.gradle.api.tasks.Input
import org.gradle.api.tasks.TaskAction
import groovyx.net.http.HTTPBuilder


class HttpSmokeTest extends DefaultTask {

    @Input
    String url

    @Input
    String errorMessage

    @TaskAction
    void letThereBeSmoke() {
        boolean success = isUp(url)

        if (!success) {
            throw new GradleException(errorMessage)
        }
    }

    private boolean isUp(String url) {
        def http = new HTTPBuilder(url)
        def responseStatus = http.get(contentType: TEXT) { resp, reader ->
            resp.status
        }

        println "responseStatus:  $responseStatus"

        responseStatus == HttpURLConnection.HTTP_OK
    }
}
