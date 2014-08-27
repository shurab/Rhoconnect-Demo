## RhoConnect Demo

Sample applications for RhoConnect presentation:

* rhostore: This is the sample rails application that serves the "backend"

* rhoconnect-basic: Vanilla RhoConnect application

* rhoconnect-server: RhoConnect application with Product model

* store-manager: Rhodes application (fixed schema DB)

## Plugin

Sample applications for RhoConnect presentation how to use rhoconnectrb plugin:

* rhostore-with-plugin: This is the sample rails application that serves the "backend"

  - add line "gem 'rhoconnect-rb'" to Gemfile

  - create config/initializers/rhoconnect.rb

  - edit app/models/product.rb


## Sample of rhoconnect application 'rhoconnect-basic'
It's created by running these commands:

```
$ rhoconnect app rhoconnect-basic
$ cd rhoconnect-basic/
$ rhoconnect help
$ rhoconnect source Product
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

6) Run it

```
$ rake clean:iphone
$ rake run:iphone
```

  or

```  
$ rake run:rhosimulator
```

### RhoMobile

```
cd store-manager/
git init
git remote add origin git@git.rhohub.com:shurab/store-manager.git
git add .
git commit -m "Init commit of store-manager app"
git push -u origin master
```

#### vendor/cache

```
bundle package
bundle install
git add vendor/
git commit ...
```

### Docs
### Video
