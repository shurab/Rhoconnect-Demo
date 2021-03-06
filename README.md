## RhoConnect Demo

### local-without-plugin

Sample applications for RhoConnect presentation:

* rhostore: This is the sample rails application that serves the "backend"

* rhoconnect-server: RhoConnect application with Product model and CUD methods

* store-manager: Rhodes application (fixed schema DB)

How to create 'rhoconnect-server':

```
$ rhoconnect app rhoconnect-server
$ cd rhoconnect-server/
$ rhoconnect help
$ rhoconnect source Product
```

Then implement Product business logic.

### local-with-plugin

Sample applications for RhoConnect presentation:

* rhostore: This is the sample rails application that serves the "backend" with rhoconnectrb plugin

* rhoconnect-vanilla: Vanilla RhoConnect application

* store-manager: Rhodes application (fixed schema DB)

Rhostore is modified the following way:

  - add line "gem 'rhoconnect-rb'" to Gemfile

  - create config/initializers/rhoconnect.rb

  - edit app/models/product.rb

How to create 'rhoconnect-vanilla':

```
$ rhoconnect app rhoconnect-vanilla
```


### How to create store-manager

1) Create app

```
$ rhodes app store-manager
$ cd store-manager/
$ rake -T
$ rake clean:iphone
$ rake run:iphone
$ rake run:rhosimulator
$ rhodes model product brand,name,price,quantity,sku
```

2) Edit build.yml

```
  sdk: iphonesimulator6.1
```

3) Edit rhoconfig.txt

```
start_path = '/app/Product'
...
syncserver = 'http://localhost:9292'
```

4) Edit app/index.erb

```
    <li><a href="Product">Products</a></li>
```

5) Edit app/Product/product.rb

```
  enable :sync
```

6) Run it on simulator

```
$ rake clean:iphone
$ rake run:iphone
```

  or rhosimulator

```
$ rake run:rhosimulator
```

### Remote

#### How to push store-manager app to remote rhomobile repository.

```
cd store-manager/
git init

# Set a new remote
git remote add origin git@git.rhohub.com:shurab/store-manager.git

# Verify new remote
$ git remote -v
origin  git@git.rhohub.com:shurab/store-manager.git (fetch)
origin  git@git.rhohub.com:shurab/store-manager.git (push)

git add .
git commit -m "Init commit of store-manager app"
git push -u origin master
```

#### How to package rhoconnect-server to run on rhomobile.

```
bundle package
bundle install
git add vendor/
git commit ...
```

#### Remote URLs

RhoConnect Console: https://rhohub-shurab-0d5b2ab8.herokuapp.com/console/

Rhostore: http://rhostore.herokuapp.com/products

### Docs
### Video
