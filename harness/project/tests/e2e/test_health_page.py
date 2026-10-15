"""Scenario: the health page shows the API and database status.

Given the backend and the Vite dev server are running
When the user opens the home page
Then the page shows "ok" for the API and for the database
"""

from playwright.sync_api import Page, expect


def test_health_page_shows_database_status(page: Page) -> None:
    page.goto("/")

    expect(page.get_by_text("Radar health")).to_be_visible()
    expect(page.get_by_test_id("api-status")).to_have_text("ok")
    expect(page.get_by_test_id("db-status")).to_have_text("ok")
