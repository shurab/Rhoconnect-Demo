var rc = require('rhoconnect_helpers');

var http = require('http');
var host = 'rhostore.herokuapp.com';
// var host = '192.168.1.12:3000';

var Product = function(){

  this.login = function(resp){
    console.log("**************** Login");
    resp.send(true);
  };

  this.query = function(resp){
    var result = {};
    var str = '';

    // Print message with timestamp
    console.log("**** query: " + new Date());
    http.request('http://' + host + '/products.json', function(res){
      res.on('data', function(chunk){
        // Print message with timestamp
        console.log("**** on data: " + new Date());
        //
        str += chunk;
      });
      res.on('end', function(){
        var data = JSON.parse(str);
        for(var i in data){
          var item = data[i];
          result[item.product.id.toString()] = item.product;
        }
        // ************************
        console.log("**** on end: "  + new Date());
        console.log(result);
        // ************************
        resp.send(result);
      });
      res.on('error', function(){
        console.log("**** on error: "  + new Date());
        resp.send(false);
      });
    }).end();
  };

  this.create = function(resp){
    var postData = JSON.stringify({ 'product': resp.params.create_object });
    var str = '';
    var options = {
      host: host,
      path: '/products.json',
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Content-Length': postData.length
      }
    };
    var req = http.request(options, function(res){
      res.on('data', function(chunk){
        str += chunk;
      });
      res.on('end', function(){
        var data = JSON.parse(str);
        resp.send(data.product.id.toString());
      });
    });
    req.write(postData);
    req.end();
  };

  this.update = function(resp){
    var objId = resp.params.update_object.id;
    var putData = JSON.stringify({ "product": resp.params.update_object });
    // Remove the id from the hash, we don't need it.
    delete putData.id;
    var options = {
      host: host,
      path: '/products/' + objId + '.json',
      method: 'PUT',
      headers: {
      'Content-Type': 'application/json',
      'Content-Length': putData.length
      }
    };
    var req = http.request(options, function(res){
        res.on('data', function(){});
        res.on('end', function(){
        resp.send(true);
      });
      res.on('error', function(){
        resp.send(false);
      });
    });
    req.write(putData);
    req.end();
  };

  this.del = function(resp){
    var objId = resp.params.delete_object.id;
    var options = {
      host: host,
      path: '/products/' + objId + '.json',
      method: 'DELETE',
      headers: { 'Content-Type': 'application/json' }
    };
    var req = http.request(options, function(res){
      res.on('data', function(){});
      res.on('end', function(){
        resp.send(true);
      });
      res.on('error', function(){
        resp.send(false);
      });
    });
    req.end();
  };

  this.logoff = function(resp){
    console.log("**************** Logoff");
    resp.send(true);
  };
};

module.exports = new Product();
