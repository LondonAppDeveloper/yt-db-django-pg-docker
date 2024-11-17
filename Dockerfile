FROM python:3.13.0-alpine3.20

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
COPY ./backend /backend
WORKDIR /backend

ENV PATH="/py/bin:$PATH"
RUN python -m venv /py && \
    pip install --upgrade pip && \
    apk add --update --upgrade --no-cache postgresql-client && \
    apk add --update --upgrade --no-cache --virtual .tmp \
        build-base postgresql-dev

RUN pip install -r /requirements.txt && apk del .tmp

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
