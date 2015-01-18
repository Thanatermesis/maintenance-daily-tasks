maintenance-daily-tasks
=======================

## Create database

    bundler exec ruby app/bin/db_create.rb
    # bundler exec ruby app/bin/db_create_test.rb  # only for tests

## Fill / Seed the database

    # bundler exec ruby app/bin/db_seeds.rb  # old, wrong
    bundler exec ruby app/bin/db_seeds2.rb

## Launching the application:

    bundler exec ruby app/bin/view_tasks.rb

## Special Notes:
    * ack-grep luxes: this is a workaround for a wrong entry
    * "instalacion" in db_seeds2.rb contains the installation date of the equipment, this must be UPDATED before the real use

## rspec


    sudo su postgres -c psql

    CREATE USER management;
    ALTER ROLE management WITH PASSWORD 'management';
    CREATE DATABASE hospital OWNER management;
