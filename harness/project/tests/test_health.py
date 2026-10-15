"""Unit tests for GET /api/health without a live database."""

from http import HTTPStatus

import pytest
from fastapi.testclient import TestClient

from app import main


@pytest.fixture
def client() -> TestClient:
    return TestClient(main.app)


def test_health_reports_ok_when_database_is_reachable(
    client: TestClient, monkeypatch: pytest.MonkeyPatch
) -> None:
    monkeypatch.setattr(main, "database_is_reachable", lambda: True)

    response = client.get("/api/health")

    assert response.status_code == HTTPStatus.OK
    assert response.json() == {"status": "ok", "database": "ok"}


def test_health_reports_503_when_database_is_unreachable(
    client: TestClient, monkeypatch: pytest.MonkeyPatch
) -> None:
    monkeypatch.setattr(main, "database_is_reachable", lambda: False)

    response = client.get("/api/health")

    assert response.status_code == HTTPStatus.SERVICE_UNAVAILABLE
    assert response.json() == {"status": "degraded", "database": "unreachable"}
