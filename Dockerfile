FROM python:3.12-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

RUN groupadd --system app \
    && useradd --system --gid app --no-create-home app

COPY --chown=app:app app.py .

USER app

EXPOSE 8003

CMD ["gunicorn", "--bind", "0.0.0.0:8003", "app:app"]