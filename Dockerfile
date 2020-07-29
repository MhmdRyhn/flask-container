FROM python:3.6

WORKDIR /opt/flask-container
COPY ./ .
RUN pip install --upgrade pip && pip install virtualenv
RUN virtualenv -p python venv
RUN venv/bin/pip install -r requirements.txt
RUN export PATH=/opt/flask-container/venv/bin:$PATH
RUN echo "export PATH=/opt/flask-container/venv/bin:$PATH" >> ~/.bashrc
RUN /bin/bash -c "source ~/.bashrc"
CMD FLASK_APP=flask_container/main.py /opt/flask-container/venv/bin/flask run
