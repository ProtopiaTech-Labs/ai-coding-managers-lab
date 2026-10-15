"""FastAPI entry point: API routes and the built frontend."""

from collections.abc import AsyncGenerator
from contextlib import asynccontextmanager
from pathlib import Path

from fastapi import FastAPI, status
from fastapi.responses import JSONResponse
from fastapi.staticfiles import StaticFiles

from app.db import create_database_if_missing, database_is_reachable

WEB_DIST = Path(__file__).resolve().parent.parent / "web" / "dist"


@asynccontextmanager
async def lifespan(_app: FastAPI) -> AsyncGenerator[None]:
    create_database_if_missing()
    yield


app = FastAPI(title="Radar", lifespan=lifespan)


@app.get("/api/health")
def health() -> JSONResponse:
    if database_is_reachable():
        return JSONResponse({"status": "ok", "database": "ok"})
    return JSONResponse(
        {"status": "degraded", "database": "unreachable"},
        status_code=status.HTTP_503_SERVICE_UNAVAILABLE,
    )


if WEB_DIST.is_dir():
    app.mount("/", StaticFiles(directory=WEB_DIST, html=True), name="web")
