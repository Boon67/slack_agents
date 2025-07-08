--Must be executed in the Snowflake UI or via SnowSQL CLI with a role that can create databases and schemas.
-- This script creates a database and schema for storing environment variables for the Slack agent.
create database if not exists apps;
create schema if not exists apps.config;
CREATE IMAGE REPOSITORY IF NOT EXISTS apps.config.containers;
--Need to upload the image next


