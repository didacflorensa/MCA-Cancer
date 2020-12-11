FROM python:3
COPY ./python-scripts/requeriments.txt /tmp/requeriments.txt
RUN  pip install --no-cache-dir -r  /tmp/requeriments.txt

# create a python user
ENV USER python-user

## Copy your working files over
COPY ./results /home/$USER/Results
COPY ./data /home/$USER/Data
COPY ./python-scripts /home/$USER/python-scripts


WORKDIR /home/$USER/python-scripts

CMD [ "python" "./your-daemon-or-script.py"]