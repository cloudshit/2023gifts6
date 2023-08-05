FROM public.ecr.aws/docker/library/node:lts-alpine

WORKDIR /app

RUN addgroup -S user && adduser -S user -G user

RUN chown user /app

USER user

ADD package.json /app

RUN npm i

RUN * /app/

CMD ["node", "main.js"]
