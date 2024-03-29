package com.manning.gia.todo.todo

import geb.junit4.GebReportingTest
import org.junit.Test

import org.junit.runner.RunWith
import org.junit.runners.JUnit4
import org.openqa.selenium.Keys

@RunWith(JUnit4)
class ToDoTest extends GebReportingTest {

    @Test
    void theToDoHomepage() {
        to ToDoHomepage

        $('form').name << 'Write functional tests'
        $('form').name << Keys.ENTER

        waitFor { at ToDoInsert }
    }
}