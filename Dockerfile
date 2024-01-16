# syntax=docker/dockerfile:1

FROM ruby:3.0.6-alpine

RUN apk update && apk upgrade

COPY . /app

WORKDIR /app

RUN gem build toy_robot.gemspec

RUN gem install toy_robot
