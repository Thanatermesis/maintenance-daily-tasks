maintenance-daily-tasks
=======================

This application is meant to have a very simple and unique purpose:
    * to show everyday's tasks for the maintenance of machinery on an hospital

It consists in showing a window with a list of tasks, when you click in the "task done" button the counter of this task is restarted to be shown the next time that is needed to be run

It can also have the option to show a PDF of the detailed instructions when you click to the task itself

The database of tasks is filled from a .csv file which is the standard protocol of the humans without programming knowledge so that they can easly fill up, and so converted to a real database seen in the next commands:


## Create database

#### create the database in postgres first

    sudo su postgres -c psql

    CREATE USER management;
    ALTER ROLE management WITH PASSWORD 'management';
    CREATE DATABASE hospital OWNER management;

#### create tables schema

    bundler exec ruby app/bin/db_create.rb
    bundler exec ruby app/bin/db_create_test.rb  # for tests of rspec


## Fill / Seed the database

    # bundler exec ruby app/bin/db_seeds.rb  # old, wrong
    bundler exec ruby app/bin/db_seeds2.rb

## Launching the application:

    bundler exec ruby app/bin/view_tasks.rb

## Special Notes:
    * ack-grep luxes: this is a workaround for a wrong entry
    * "instalacion" in db_seeds2.rb contains the installation date of the equipment, this must be UPDATED before the real use

## rspec

#### run tests

    bundler exec rspec -fd
