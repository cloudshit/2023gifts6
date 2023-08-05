FROM public.ecr.aws/docker/library/python:3.9-slim

WORKDIR /app

RUN groupadd -r user && useradd -r -m -g user user

RUN chown user /app

USER user

ADD requirements.txt /app

RUN pip3 install -r requirements.txt

ADD * /app/

CMD ["python3", "user.pyc"]
