# Snowflake DataAgent Slack Bot

A Slack bot for natural language interaction with your Snowflake data warehouse, supporting two powerful modes:

- **Snowflake Intelligence Mode** (`slackapp.py`): Uses Snowflake Cortex Analyst and semantic models to answer questions, generate SQL, and provide data insights directly in Slack.
- **Snowflake Agents Mode** (`slackapp_agent.py`): Leverages Snowflake Agents and Cortex Search for retrieval-augmented generation (RAG), SQL generation, and advanced context-aware responses.

---

## Features

- **Natural Language Q&A:** Ask business questions in plain English and receive answers, summaries, and SQL queries.
- **Slack Integration:** Interact via `/askcortex` slash command or direct messages.
- **Contextual Search (Agents Mode):** Uses semantic search to retrieve relevant data chunks for more accurate answers.
- **Interactive SQL Reveal:** Optionally view the SQL generated and executed by the bot.

---

## Getting Started

### Prerequisites

- Python 3.9+
- Snowflake CLI Installed: https://docs.snowflake.com/en/developer-guide/snowflake-cli/index
- Docker Installed: https://docs.docker.com/desktop/
- Access to a Snowflake account with Cortex and/or Agents enabled
- Slack workspace and permissions to add a bot
- Required environment variables (see `.env.example`)



### Create & Configure Slack App
- Go to https://api.slack.com/apps and select Create New App
- Select From a manifest option
- Select your newly created Slack workspace
- Replace the json with this app_manifest.json code, select Next
- Select Create
- On the Basic Information tab, scroll down to App-Level Tokens and select Generate Tokens and Scopes
- Provide the Token name “app”. Select “connections:write” for the scope. Select Generate.
- Copy the app token and save it in a place you can easily find later
- Navigate to OAuth & Permissions tab, scroll down to OAuth Tokens and select Install to Snowflake DataAgent
- Select Allow
- Copy the Bot User OAuth Token and save it in a place you can easily find
- Navigate to App Home and check "Allow users to send Slash commands and messages from the messages tab".

Note: You can use the datagent.env to run the application locally for testing. `python slackapp.py`


### Setup DB Repository and Images
 - Define your semantic model as a YAML file in a stage.
 - Setup user login with PAT and private key.
    https://docs.snowflake.com/en/user-guide/key-pair-auth
    https://docs.snowflake.com/en/sql-reference/sql/alter-user-add-programmatic-access-token
 - Configure docker to connect to your reposistory and test connectivity with `snow spcs image-registry login`
 - Configure spcs_setup.sql with parameters for connecting to Snowflake & Slack
 - Use setup.sh as a template to configure your database, build the docker image and to deploy to an SPCS container.



