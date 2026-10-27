"""Database engine and bootstrap helpers."""

from sqlalchemy import Engine, make_url, text
from sqlalchemy.exc import SQLAlchemyError
from sqlmodel import create_engine

from app.config import DATABASE_URL

engine = create_engine(DATABASE_URL, pool_pre_ping=True)


def create_database_if_missing(url: str = DATABASE_URL) -> None:
    """Create the target database on the server when it does not exist."""
    target = make_url(url)
    name = target.database
    if not name:
        return
    server: Engine = create_engine(
        target.set(database="master"), isolation_level="AUTOCOMMIT"
    )
    quoted = server.dialect.identifier_preparer.quote_identifier(name)
    try:
        with server.connect() as connection:
            exists = connection.execute(text("SELECT DB_ID(:name)"), {"name": name}).scalar()
            if exists is None:
                connection.execute(text(f"CREATE DATABASE {quoted}"))
    finally:
        server.dispose()


def database_is_reachable() -> bool:
    """Return True when a trivial query succeeds."""
    try:
        with engine.connect() as connection:
            connection.execute(text("SELECT 1"))
    except SQLAlchemyError:
        return False
    return True
