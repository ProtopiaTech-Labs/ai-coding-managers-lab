"""Runtime settings read from the environment."""

import os
from urllib.parse import quote_plus


def _default_database_url() -> str:
    host = os.environ.get("MSSQL_HOST", "mssql")
    password = quote_plus(os.environ.get("MSSQL_SA_PASSWORD", ""))
    return (
        f"mssql+mssqlpython://sa:{password}@{host}:1433/radar"
        "?Encrypt=yes&TrustServerCertificate=yes"
    )


DATABASE_URL = os.environ.get("DATABASE_URL") or _default_database_url()
