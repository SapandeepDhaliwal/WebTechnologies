const express = require('express');
const cors = require('cors');

const app = express();
app.use(cors());

const https = require('https');
var url = require('url');
function secondrequest(url2,res){
    var finalstring = '';
     https.get(url2, (resp) => {
        let data = '';
        resp.on('data', (chunk) => {
          data += chunk;
        });
        
        resp.on('end', () => {
    
          var json = JSON.parse(data);
        
          finalstring = JSON.stringify(json);
          res.send(json);
        });
        
      }).on("error", (err) => {
        
        console.log("Error: " + err.message);
      });
      
      
    }

function initialize(req) {
     var street = req.params.streetId;
     var city = req.params.cityId;
     var state = req.params.stateId;

     var url1= 'https://maps.googleapis.com/maps/api/geocode/json?address='+street+city+state+'&key=0000';//Add Key

    return new Promise(function(resolve, reject) {
    	https.get(url1, (resp) => {
            let data = '';
              
            resp.on('data', (chunk) => {
              data += chunk;
            });
            
            resp.on('end', () => {
              var lat;
              var lng;
              if(JSON.parse(data).results.length == 0){
                lat = 190;
                lng = 190;
              }
              else{
              lat = JSON.parse(data).results[0].geometry.location.lat;
              lng = JSON.parse(data).results[0].geometry.location.lng;
              }
              url2 = "https://api.darksky.net/forecast/00000/"+lat+","+lng;//Add Key
              return resolve(url2);
            });
            
          }).on("error", (err) => {
              
            return reject(err);
          });
    })

}

function main(res,req) {
    var initializePromise = initialize(req);
    return initializePromise.then(function(result) {
        var str =  secondrequest(result,res);
        return str;
    }, function(err) {
    })
}

app.get("/street/:streetId&city/:cityId&state/:stateId",function (req,res){
    main(res,req);
})

app.get("/lat/:latId&long/:longId",function (req,res){
    
    var lat = req.params.latId;
    var lng =req.params.longId;
    var newurl=url2 = "https://api.darksky.net/forecast/0000/"+lat+","+lng; //Add Key
    secondrequest(newurl,res);
})

app.get("/lat/:latId&long/:longId&time/:time",function (req,res){
    
  var lat = req.params.latId;
  var lng =req.params.longId;
  var time = req.params.time;
  var newurl = "https://api.darksky.net/forecast/0000/"+lat+","+lng+","+time; //Add Key
  secondrequest(newurl,res);
})


app.get("/state/:stateId",function (req,res){
  var state =req.params.stateId;
  var newurl = "https://www.googleapis.com/customsearch/v1?q=Photos of " +state+"&cx=010227509778041328616:obfawgaloha&num=8&searchType=image&key=0000" //Add Key
  secondrequest(newurl,res);
})


function thirdrequest(url2,res){
  var finalstring = '';
   https.get(url2, (resp) => {
      let data = '';
        
      resp.on('data', (chunk) => {
        data += chunk;
      });
      
      resp.on('end', () => {
  
        var json = JSON.parse(data);
        
        finalstring = JSON.stringify(json);
        res.json(json);
      });
      
    }).on("error", (err) => {
      
    });
    
    
  }

app.get("/city/:cityId",function (req,res){
  var city =req.params.cityId;
  var newurl = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input="+city+"&types=(cities)&language=en&key=0000"; //Add Key
  thirdrequest(newurl,res);
})



const PORT =  process.env.PORT || 5000;

app.listen(PORT, () => console.log(`Server started on port ${PORT}`));