FROM python:3.6

RUN apt-get update -y \
  && apt-get install -y \
  apache2 \
  libapache2-mod-wsgi-py3 \
  build-essential \
  python3-dev \
  vim \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip && pip install virtualenv
WORKDIR /var/www/flask-container
COPY ./ .
RUN virtualenv -p python venv
RUN venv/bin/pip install --upgrade pip && venv/bin/pip install -r requirements.txt

# To server the app using Apache2
RUN cp ./flask-container.apache2.conf /etc/apache2/sites-available/flask-container.apache2.conf \
  && a2dissite 000-default.conf && a2ensite flask-container.apache2.conf
EXPOSE 80
CMD /usr/sbin/apache2ctl -D FOREGROUND

# To serve the app using the flask development server
#RUN export PATH=/var/www/flask-container/venv/bin:$PATH
#RUN echo "export PATH=/var/www/flask-container/venv/bin:$PATH" >> ~/.bashrc
#RUN /bin/bash -c "source ~/.bashrc"
#CMD FLASK_APP=flask_container/main.py venv/bin/flask run -h 0.0.0.0

