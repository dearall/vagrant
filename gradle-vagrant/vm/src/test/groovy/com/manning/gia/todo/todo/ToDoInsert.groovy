package com.manning.gia.todo.todo

import geb.Page

class ToDoInsert extends Page {

    static url = 'insert'
    static at = { title == 'To Do application' }
}