# Install requirements
FROM python:3.9-alpine as base
ENV PYTHONDONTWRITEBYTECODE 1

RUN apk add --update --no-cache --virtual .build-deps \
    build-base \
    python3-dev nodejs yarn

WORKDIR /code
# Copy code
COPY . /code/

# Install pythons reqs
RUN pip install --no-cache-dir -r requirements.txt && \
    find /usr/local \
        \( -type d -a -name test -o -name tests \) \
        -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
        -exec rm -rf '{}' +

# Build frontend
RUN yarn && \
    yarn build


ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONPATH /code:$PYTHONPATH

# collect static files
#RUN python manage.py collectstatic
EXPOSE 8080
ENTRYPOINT ["/code/entrypoint.sh"]
