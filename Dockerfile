FROM python:3.13-slim

COPY --from=ghcr.io/astral-sh/uv:0.7.8 /uv /uvx /bin/

ENV WORKSPACE_ROOT=/app \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    UV_LINK_MODE=copy

# 작업 디렉터리 설정
WORKDIR ${WORKSPACE_ROOT}

# pyproject.toml, uv.lock 복사
COPY pyproject.toml uv.lock ./

# Install dependencies
RUN --mount=type=cache,target=/root/.cache/uv \
    --mount=type=bind,source=uv.lock,target=uv.lock \
    --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    uv sync --locked --no-install-project

# 코드 복사
COPY . ${WORKSPACE_ROOT}

# FastAPI 실행
CMD [".venv/bin/fastapi", "dev", "main.py", "--host", "0.0.0.0", "--port", "8000"]