FROM python:3.9

# Update and install system packages
RUN apt-get update -y && \
    apt-get install --no-install-recommends -y -q -f \
    git \
    libpq-dev \
    unixodbc-dev \
    python-dev-is-python3 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# install ODBC Driver 18 for SQL Server
RUN  apt-get update \
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y msodbcsql18

# Install dbt
COPY ./requirements.txt /dbt/requirements.txt
RUN pip install -U pip -r /dbt/requirements.txt

ENV DBT_DIR /dbt
ENV DBT_PROFILES_DIR=/dbt/

COPY dbt/ /dbt/
WORKDIR /dbt/
RUN dbt deps

