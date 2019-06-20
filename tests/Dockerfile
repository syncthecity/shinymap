FROM python:alpine
RUN pip install requests
ADD test.py /
ENTRYPOINT [ "python", "test.py", "--host", "http://web:3838" ]
