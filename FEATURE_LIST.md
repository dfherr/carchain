# Feature-list

## In-app

### Core

* register car to ethereum blockchain
* unregister car to the blockchain
* offical accepts registration and provides licenseTag
* search for registration data as insurance via evb number
* search for owner data as police via licenseTag

### Additions

* Responive bootstrap design
* awesome landing page
* User registration and authentication
* User management (email confirmation, change user data)
* Role and rights management
* In-app admin role management
* localization (technology implemented, translated menu)
* Imprint
* EU Cookie-consent
* favicons :) also on mobile

## In-code

### production

* Automatic setup using [carchain-env](https://github.com/blc-psi/carchain-env)
* 3-node parity Proof of Authority setup
* ethereum communication via ethereum.rb/parity json-rpc
* ruby on rails application
* postgres database for non-blockchain data
* bootstrap frontend, sandstone theme
* turbolinks for faster loading
* gettext / fastgettext for translations
* devise / cancancan / rolify for authentication and authorization
* deployed to internet via amazon aws
* mailing with amazon ses

### testing

* specs using rails-spec
* acceptance tests using capybara
* continuous integration using travis-ci
* test-coverage report using simplecov/coveralls
