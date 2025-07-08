USE ROLE DEV_ADMIN;
USE SCHEMA apps.config;
/* Create network rule for slack domains */
DROP NETWORK RULE IF EXISTS slack_network_rule;
DROP INTEGRATION IF EXISTS slack_integration;
DROP SERVICE IF EXISTS SLACK_SERVICE;
/* Create network rule for Slack */
CREATE
OR REPLACE NETWORK RULE slack_network_rule MODE = EGRESS TYPE = HOST_PORT VALUE_LIST = ('0.0.0.0');
/* Create external access integration using the network rule */
CREATE
OR REPLACE EXTERNAL ACCESS INTEGRATION slack_integration ALLOWED_NETWORK_RULES = (slack_network_rule) ENABLED = TRUE;
CREATE COMPUTE POOL IF NOT EXISTS slack_compute_pool MIN_NODES = 1 MAX_NODES = 1 INSTANCE_FAMILY = CPU_X64_XS;
/* Grant usage privileges to dev_admin role */
CREATE SERVICE SLACK_SERVICE
  IN COMPUTE POOL SLACK_COMPUTE_POOL
  EXTERNAL_ACCESS_INTEGRATIONS = (slack_integration) --Network Rule for integration
  FROM SPECIFICATION $$
  spec:
    containers:
      - name: slackbot
        image: /apps/config/containers/slack_bot_agent:latest
        env:
            SLACK_BOT_TOKEN: <xoxb-TOKEN>
            SLACK_APP_TOKEN: <xapp-TOKEN>
            SNOWFLAKE_USER: <SNOWFLAKE_USER>
            SNOWFLAKE_ACCOUNT_NAME: <SNOWFLAKE_ACCOUNT>
            SNOWFLAKE_PRIVATE_KEY_PATH: rsa_private_key.pem
            SNOWFLAKE_PAT: <PAT_TOKEN>
            SF_DATABASE: <DB_NAME>
            SF_SCHEMA: <SCHEMA_NAME>
            SF_ROLE: <ROLE_NAME>
            SF_WAREHOUSE: <WAREHOUSE_NAME>
            SF_STAGE: <SYMANTIC_MODEL_STAGE_NAME>
            SF_MODEL_FILE: <SYMANTIC_MODEL_FILENAME>
   $$;

SHOW SERVICES;
/* check service status */
--CALL SYSTEM$GET_SERVICE_STATUS('SLACK_SERVICE');
/* check service logs */
--CALL SYSTEM$GET_SERVICE_LOGS('SLACK_SERVICE', '0', 'slackbot',1000);

