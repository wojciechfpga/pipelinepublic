from dagster import (
    define_asset_job,
    AssetSelection,
    Definitions,
    ResourceDefinition,
)
from dagster_airbyte import AirbyteResource, build_airbyte_assets
from dagster_dbt import DbtCliResource, load_assets_from_dbt_project

# Airbyte configuration
airbyte_instance = AirbyteResource(
    host="airbyte-server",
    port="8000",
    username="airbyte",
    password="password",
)

# Define Airbyte assets
airbyte_assets = build_airbyte_assets(
    connection_id="your-airbyte-connection-id",  # Replace with actual Airbyte connection ID
    destination_tables=["raw_sales"],
)

# dbt configuration
DBT_PROJECT_DIR = "/usr/app/dbt"
DBT_PROFILES_DIR = "/usr/app/dbt"

dbt_assets = load_assets_from_dbt_project(
    project_dir=DBT_PROJECT_DIR,
    profiles_dir=DBT_PROFILES_DIR,
    dbt_resource=DbtCliResource(
        project_dir=DBT_PROJECT_DIR,
        profiles_dir=DBT_PROFILES_DIR,
        target="dev",
    ),
)

# Combine assets
all_assets = [
    *airbyte_assets,
    *dbt_assets,
]

# Define job
sync_job = define_asset_job(
    name="data_pipeline",
    selection=AssetSelection.all(),
)

# Definitions with resources
defs = Definitions(
    assets=all_assets,
    jobs=[sync_job],
    resources={
        "airbyte": airbyte_instance,
    },
)