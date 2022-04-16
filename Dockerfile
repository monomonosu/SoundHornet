FROM tiangolo/uwsgi-nginx-flask:python3.8
COPY /app /app
COPY /front /front

RUN apt update
RUN apt install -y nodejs npm
RUN npm install
RUN npm build

RUN pip install sqlalchemy
RUN pip install flask-sqlalchemy
RUN pip install flask-marshmallow 
RUN pip install marshmallow-sqlalchemy
RUN pip install Flask-Migrate

ENV  FLASK_APP models.py
RUN flask db init
RUN flask db migrate
RUN flask db upgrade
RUN python ./seeder.py

# RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
# RUN npm install
# RUN npm run build
