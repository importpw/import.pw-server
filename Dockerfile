FROM mhart/alpine-node:10 as base
WORKDIR /usr/src
COPY . .
RUN yarn install --production && \
    yarn run build && \
    rm -rf ~/.npm* ~/.yarn*

FROM mhart/alpine-node:base-10
WORKDIR /usr/src
ENV NODE_ENV="production"
COPY --from=base /usr/src .
USER nobody
EXPOSE 3000
CMD ["node", "./node_modules/.bin/micro", "server.js"]
