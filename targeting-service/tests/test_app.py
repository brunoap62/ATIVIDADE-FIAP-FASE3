import os
import pytest
from unittest.mock import patch, MagicMock

os.environ["DATABASE_URL"] = "postgres://test:test@localhost:5432/test"
os.environ["AUTH_SERVICE_URL"] = "http://auth-service"

@pytest.fixture(autouse=True)
def mock_db_pool():
    with patch("psycopg2.pool.SimpleConnectionPool") as mock:
        yield mock

def test_health_check(mock_db_pool):
    from app import app
    client = app.test_client()
    response = client.get("/health")
    assert response.status_code == 200
    data = response.get_json()
    assert "status" in data
    assert "ok" in data["status"]

def test_targeting_health_check(mock_db_pool):
    from app import app
    client = app.test_client()
    response = client.get("/targeting/health")
    assert response.status_code == 200
    data = response.get_json()
    assert "status" in data
