# Pong game
[![Build Status](https://travis-ci.org/jbmeerkat/pong.svg?branch=master)](https://travis-ci.org/jbmeerkat/pong)
[![Maintainability](https://api.codeclimate.com/v1/badges/ffbbfd5be6a58ddda818/maintainability)](https://codeclimate.com/github/jbmeerkat/pong/maintainability)
[![Codebeat](https://codebeat.co/badges/8c86445d-2532-4554-bf8f-8e6a6238ae84)](https://codebeat.co/projects/github-com-jbmeerkat-ruby_games-master)
[![Test Coverage](https://api.codeclimate.com/v1/badges/ffbbfd5be6a58ddda818/test_coverage)](https://codeclimate.com/github/jbmeerkat/pong/test_coverage)

Incredibly over-engineered naive implementation of [pong game](https://en.wikipedia.org/wiki/Pong) with [ECS](https://en.wikipedia.org/wiki/Entity%E2%80%93component%E2%80%93system)

![Menu](https://i.imgur.com/xYqXY8S.png)

## Installation

Clone repo and run

`$ make install`

## Playing

### Controls

Right player: `up` and `down`

Left player: `w` and `s`

### Start the game

`$ make`

## Documentation

There is documentation for ECS framework which can be built with

`$ make documentation`

And browsed with

`$ open doc/index.html`

## Testing

Run linters and tests:

`$ make build`

Run test only:

`$ make test`

Run linters only:

`$ make lint`

