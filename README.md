maintenance-daily-tasks
=======================

    ruby app/bin/view_tasks.rb

## Crear bd

    ruby app/bin/db_create.rb
    ruby app/bin/db_create_test.rb

## Seed db

    ruby app/bin/db_seeds.rb

## rspec


    sudo su postgres -c psql

    CREATE USER management;
    ALTER ROLE management WITH PASSWORD 'management';
    CREATE DATABASE hospital OWNER management;
