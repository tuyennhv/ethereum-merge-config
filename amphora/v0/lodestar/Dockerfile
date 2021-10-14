FROM node:14-alpine as build
WORKDIR /usr/app
RUN apk update && apk add --no-cache g++ make python && rm -rf /var/cache/apk/*

ARG VERSION=0.31.1-dev.59+ea29946f5
ENV VERSION=$VERSION
RUN npm install @chainsafe/lodestar-cli@$VERSION

FROM node:14-alpine
WORKDIR /usr/app
COPY --from=build /usr/app .


COPY ./lodestar/genesis.ssz /genesis.ssz
COPY ./lodestar/config.yaml /config.yaml

# Sanity check
RUN /usr/app/node_modules/.bin/lodestar --help

# NodeJS applications have a default memory limit of 2.5GB.
# This limit is bit tight for a Prater node, it is recommended to raise the limit
# since memory may spike during certain network conditions.
ENV NODE_OPTIONS=--max_old_space_size=6144

ENTRYPOINT ["node", "/usr/app/node_modules/.bin/lodestar"]
