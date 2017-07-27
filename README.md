# Carchain

[![Build Status](https://travis-ci.org/blc-psi/carchain.svg?branch=master)](https://travis-ci.org/blc-psi/carchain)
[![Coverage Status](https://img.shields.io/coveralls/blc-psi/carchain.svg)](https://coveralls.io/github/blc-psi/carchain)

### A Rails application for managing car-registration with Ethereum

The app uses the default Rails conventions. For ethereum specific code checkout [smartcontracts](tree/master/smartcontracts) and
[app/controllers/car](tree/master/app/controllers) source files.

## Usage

This is a sub-project of [carchain-env](https://github.com/blc-psi/carchain-env), which provides
[crane](https://github.com/michaelsauter/crane) configuration files for booting all necessary
services using docker:
* the carchain application
* a postgres database for use with carchain
* three Proof of Authority Ethereum nodes using parity

## License

[MIT](https://github.com/blc-psi/carchain/blob/master/LICENSE)

Copyright (c) 2017 Dennis-Florian Herr, Franz Schneider, Matthias Mark
