<?php

	$street = rawurlencode($_GET["street"]);
	$city = rawurlencode($_GET["city"]);
	$state = rawurlencode($_GET["state"]);
	$key = "0000000000000000000000000"; #dummy key
	$darksky_key = "000000000000000000000000"; #dummy key
	$get_latitude=($_GET["current_latitude"]);
	$get_longitude=($_GET["current_longitude"]);
	

	
	if(isset($_GET["time"])){
		$latitude2 = $_GET["latitude"];
		$longitude2 = $_GET["longitude"];
		$time = $_GET["time"];
		$url2 = "https://api.darksky.net/forecast/".$darksky_key."/".$latitude2.",".$longitude2.",".$time."?exclude=minutely";
		$url_contents2 = file_get_contents($url2);
		echo $url_contents2;
		exit();
	}


	if(!isset($_GET["current_latitude"])){
		$context  = stream_context_create(array('http' => array('header' => 'Accept: application/xml')));
		$url_for_get = "https://maps.googleapis.com/maps/api/geocode/xml?address=".$street.$city.$state."&key=".$key;
		$url_contents = file_get_contents($url_for_get);
		$xml = simplexml_load_string($url_contents);
		$get_latitude = (string) $xml->result->geometry->location->lat;
		$get_longitude = (string) $xml->result->geometry->location->lng;
	}

	$forecast_url = "https://api.forecast.io/forecast/".$darksky_key."/".$get_latitude.",".$get_longitude."?exclude=minutely,hourly,alerts,flags";
	$forecast_json_contents = file_get_contents($forecast_url);
	
	if(isset($_GET["state"]) || isset($_GET["current_latitude"])){
		print_r($forecast_json_contents);
		exit();
	}

?>

<html>
<head>
<title>Weather Search</title>
<style>
	.form_style{
		text-align: center;
		height: 210px;
		width: 700px;
		margin-left: auto;
		margin-right: auto;
		background-color: rgb(0, 175, 28);
		border-radius: 20px;
		margin-bottom: 15px;
		color:white;
	}

	.vertical_line{
		border-left: 2.5px solid white;
		border-right: 2.5px solid white;
		border-radius: 20px;
		height:120px;
		position: absolute;
		left:52%;
		margin-left: 15px;
		top:120px;
	}
	.left{
		float:left;
	}

	.clear{
		clear:both;
	}

	form{
		margin-top: 20px;
		text-align: left;
		margin-left: 40px;

	}

	.search_form > label{
		float: left;	
		clear : right;

	}

	label{
		display: inline-block;
		width: 50px;
		text-align: left;

	}

	input{
		margin-bottom: 5px;
		/*margin-top: -10px;*/
	}

	#submit_button
	{
    	margin-left: 210px;
    	margin-top: 7px;
	}

	#Current_location{
		margin-left: 300px;
	}

	
	#errormessage{
		border: 2px solid;
		border-color: rgb(195, 195, 195);
		background-color: rgb(249, 249, 249);
		width: 450px;
		text-align: center;
		margin: auto;
	}


	#second_part table{
		border-collapse: collapse;
		background-color:rgb(149, 202, 242);
		margin-left: auto;
		margin-right: auto;

	}

	#second_part table img{
		width: 100%;
		height: auto;
		display: block;
	}

	#second_part table,td,th{
		border: 1px solid rgb(52, 160, 189);
		text-align: center;
		color:white;
	}

	#first_part_afterClick img{
		width: 55%;
		height :auto;

	}

	div.item {
	    display:inline-block;
  		margin:10px;
  		max-width: 11%;
	    text-align: center;
	    
	}
	.item img {
		margin-top: -25px;
	    width: 60%;
	    height: auto;
	    margin-left: auto;
  		margin-right: auto;
	}

	.caption {
	    display: block;
	}

	.leftDiv, .rightDiv{
		display: inline-block;
	}

	


</style>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

</head>
<body>
<br>
<br>
<div class="form_style">
<div class="form_caption_style">
<h1 style="font-size: 45px; font-weight: normal"><i>Weather Search</i></h1>
</div>

<form  id="search_form" class="search_form" >

<div class="left" style="margin-top: -18px;">
<label><b>Street</b></label><input type="text" name="street" id="street"  style="font-family: 'Times New Roman', Times, serif; font-size: 12px; width:10em" required>
</div>
<div class="left" style="margin-top: -18px;">
<input type="checkbox" name="Current_location" id="Current_location" value="Current_location" onchange="disablefields()"><b>Current Location
</b></div>
<div class="clear"></div>
<label><b>City</b></label><input type="text" name="city" id="city"  style="font-family: 'Times New Roman', Times, serif; font-size: 12px; width:10em" required>
<br>
<label>

<b>State</b></label>
<select name="state" id="state"  style="font-family: 'Times New Roman', Times, serif; font-size: 12px; min-width:17em" required>
	<option value="state" selected>State</option>
	<option value="---" disabled>---------------------------------</option>
	<option value="Alabama" >Alabama</option>
	<option value="Alaska" >Alaska</option>
	<option value="Arizona" >Arizona</option>
	<option value="Arkansas" >Arkansas</option>
	<option value="California" >California</option>
	<option value="Colorado" >Colorado</option>
	<option value="Connecticut" >Connecticut</option>
	<option value="Delaware" >Delaware</option>
	<option value="District Of Columbia" >District Of Columbia</option>
	<option value="Florida" >Florida</option>
	<option value="Georgia" >Georgia</option>
	<option value="Hawaii" >Hawaii</option>
	<option value="Idaho" >Idaho</option>
	<option value="Illinois" >Illinois</option>
	<option value="Indiana" >Indiana</option>
	<option value="Iowa" >Iowa</option>
	<option value="Kansas" >Kansas</option>
	<option value="Kentucky" >Kentucky</option>
	<option value="Louisiana" >Louisiana</option>
	<option value="Maine" >Maine</option>
	<option value="Maryland" >Maryland</option>
	<option value="Massachusetts" >Massachusetts</option>
	<option value="Michigan" >Michigan</option>
	<option value="Minnesota" >Minnesota</option>
	<option value="Mississippi" >Mississippi</option>
	<option value="Missouri" >Missouri</option>
	<option value="Montana" >Montana</option>
	<option value="Nebraska" >Nebraska</option>
	<option value="Nevada" >Nevada</option>
	<option value="New Hampshire" >New Hampshire</option>
	<option value="New Jersey" >New Jersey</option>
	<option value="New Mexico" >New Mexico</option>
	<option value="New York" >New York</option>
	<option value="North Carolina" >North Carolina</option>
	<option value="North Dakota" >North Dakota</option>
	<option value="Ohio" >Ohio</option>
	<option value="Oklahoma" >Oklahoma</option>
	<option value="Oregon" >Oregon</option>
	<option value="Pennsylvania" >Pennsylvania</option>
	<option value="Rhode Island" >Rhode Island</option>
	<option value="South Carolina" >South Carolina</option>
	<option value="South Dakota" >South Dakota</option>
	<option value="Tennessee" >Tennessee</option>
	<option value="Texas" >Texas</option>
	<option value="Utah" >Utah</option>
	<option value="Vermont" >Vermont</option>
	<option value="Virginia" >Virginia</option>
	<option value="Washington" >Washington</option>
	<option value="West Virginia" >West Virginia</option>
	<option value="Wisconsin" >Wisconsin</option>
	<option value="Wyoming" >Wyoming</option>
</select>

<div class="vertical_line"></div>
<br>
<br><br>
<input type="button" name="submit" value="search" style="font-family: 'Times New Roman', Times, serif; font-size: 13px;" id="submit_button" onclick="return validateForm()"><!--
--><input type="button" name="clear" style="font-family: 'Times New Roman', Times, serif; font-size: 13px;" value="clear" onclick="clearAllValues()">
<input type="text" name="current_latitude" id="current_latitude" value="" style="display:none">
<input type="text" name="current_longitude" id="current_longitude" value="" style="display:none">
</form>
</div>
<div id="errormessage" style="display: none"></div>

<div id="first_part"></div>
<div id="dailyWeatherDetail" style="display:none; text-align: center;"><h1>Daily Weather Detail</h1></div>
<div id="first_part_afterClick"></div>
<div id="dayshourlyweather" style="display:none; text-align: center"><h1>Day's Hourly Weather</h1></div>
<div id="down_arrow" style="display:none; cursor:pointer;"><img src="https://cdn4.iconfinder.com/data/icons/geosm-e-commerce/18/point-down-512.png" style="width:4%; height:auto; display:block; margin-left: auto; margin-right: auto; margin-top: -15px" onclick="drawGraph()"></div>
<div id="up_arrow" style="display:none; cursor:pointer;"><img src="https://cdn0.iconfinder.com/data/icons/navigation-set-arrows-part-one/32/ExpandLess-512.png" style="width:4%; height:auto; display:block; margin-left: auto; margin-right: auto; margin-top: -15px" onclick="downArrowBack()"/></div>
<div id="second_part"></div>
<div id="chart_div" style="display:none; margin-left: 150px; margin-right: 150px"></div>



<script type="text/javascript">

	var cityValue="";
	
	var xmlhttp;
	if(window.XMLHttpRequest){
		xmlhttp = new XMLHttpRequest();
	}
	xmlhttp.open("GET","http://ip-api.com/json",false);
	xmlhttp.send();

	if(xmlhttp.readyState==4 && xmlhttp.status==200){
		var jsonObj = JSON.parse(xmlhttp.responseText);
		if(jsonObj.lat != undefined){
			document.getElementById("current_latitude").value = jsonObj.lat;
		}
		if(jsonObj.lon != undefined){
			document.getElementById("current_longitude").value = jsonObj.lon;
		}
	}




function generateDailyWeatherDetail(){
	document.getElementById("first_part").style.display="none";
	document.getElementById("dailyWeatherDetail").style.display="block";
	document.getElementById("dayshourlyweather").style.display="block";
	document.getElementById("second_part").style.display="none";
	document.getElementById("down_arrow").style.display="block";
	document.getElementById("up_arrow").style.display="none";
	
	var div = document.getElementById("first_part_afterClick");
	div.setAttribute('style','height: 390px; width: 480px; margin-left: auto; margin-right: auto;background-color: rgb(157, 209, 220);border-radius: 20px;margin-bottom: 15px;color:white;');

	var html_txt ="<br><br>";
	if(responseJson.currently.summary != undefined){
		if(responseJson.currently.summary == "Possible Light Rain" || responseJson.currently.summary.length>13){
			html_txt += "<h1 style='margin-left:20px; font-size:27px;'>"+responseJson.currently.summary;
		}
		else{
			html_txt += "<h1 style='margin-left:20px'>"+responseJson.currently.summary;
		}
	}

	if(responseJson.currently.icon != undefined){
		if(responseJson.currently.icon == "clear-day" || responseJson.currently.icon == "clear-night"){
			html_txt += "<img src ='https://cdn3.iconfinder.com/data/icons/weather-344/142/sun-512.png' align='right' style='margin:-70px 20px 0px 0px; width: 45%; height:auto'></h1>";
		}
		else if(responseJson.currently.icon == "rain"){
			html_txt += "<img src ='https://cdn3.iconfinder.com/data/icons/weather-344/142/rain-512.png' align='right' style='margin:-60px 20px 0px 0px; width: 45%; height:auto'></h1>";
		}
		else if(responseJson.currently.icon == "snow"){
			html_txt += "<img src ='https://cdn3.iconfinder.com/data/icons/weather-344/142/snow-512.png' align='right' style='margin:-60px 20px 0px 0px; width: 45%; height:auto'></h1>";
		}
		else if(responseJson.currently.icon == "sleet"){
			html_txt += "<img src ='https://cdn3.iconfinder.com/data/icons/weather-344/142/lightning-512.png' align='right' style='margin:-60px 20px 0px 0px; width: 45%; height:auto'></h1>";
		}
		else if(responseJson.currently.icon == "wind"){
			html_txt += "<img src ='https://cdn4.iconfinder.com/data/icons/the-weather-is-nice-today/64/weather_10-512.png' align='right' style='margin:-60px 20px 0px 0px; width: 45%; height:auto'></h1>";
		}
		else if(responseJson.currently.icon == "fog"){
			html_txt += "<img src ='https://cdn3.iconfinder.com/data/icons/weather-344/142/cloudy-512.png' align='right' style='margin:-60px 20px 0px 0px; width: 45%; height:auto'></h1>";
		}
		else if(responseJson.currently.icon == "cloudy"){
			html_txt += "<img src ='https://cdn3.iconfinder.com/data/icons/weather-344/142/cloud-512.png' align='right' style='margin:-60px 20px 0px 0px; width: 45%; height:auto'></h1>";
		}
		else if(responseJson.currently.icon == "partly-cloudy-day" || responseJson.currently.icon == "partly-cloudy-night"){
			html_txt += "<img src ='https://cdn3.iconfinder.com/data/icons/weather-344/142/sunny-512.png' align='right' style='margin:-60px 20px 0px 0px; width: 45%; height:auto'></h1>";
		}

	}

	if(responseJson.currently.temperature != undefined){
		html_txt += "<div id='temp' style='margin-left:20px; margin-top:-20px; font-size:110px'><b>"+Math.round(responseJson.currently.temperature)+"<img src ='https://cdn3.iconfinder.com/data/icons/virtual-notebook/16/button_shape_oval-512.png' align='top' style=' margin-top:12px; margin-left:2px; width:3%; height:auto'><span style='font-size:75px'>F</span></b></div>";
	}
	
	html_txt += "<div style='margin-top:-10px; font-weight:bold;'>";
	if(responseJson.currently.precipIntensity != undefined){
		html_txt+="<div class='leftDiv' align='right' style=' min-width: 300px; font-size:18px; margin-top:-25px'>Precipitation:&nbsp;</div>";
		
		if(responseJson.currently.precipIntensity == undefined){
			html_txt+="<div class='rightDiv'><span style='font-size:25px'><b>N/A</b></span></div>";
		}
		else if(responseJson.currently.precipIntensity <= 0.001){
			html_txt+="<div class='rightDiv'><span style='font-size:25px'><b>None</b></span></div>";
		}
		else if(responseJson.currently.precipIntensity <= 0.05 && responseJson.currently.precipIntensity > 0.015){
			html_txt+="<div class='rightDiv'><span style='font-size:25px'><b>Very Light</b></span></div>";
		}
		else if(responseJson.currently.precipIntensity <= 0.015 && responseJson.currently.precipIntensity > 0.001){
			html_txt+="<div class='rightDiv'><span style='font-size:25px'><b>Light</b></span></div>";
		}
		else if(responseJson.currently.precipIntensity <= 0.1 && responseJson.currently.precipIntensity > 0.05){
			html_txt+="<div class='rightDiv'><span style='font-size:25px'><b>Moderate</b></span></div>";
		}
		else if(responseJson.currently.precipIntensity >0.1){
			html_txt+="<div class='rightDiv'><span style='font-size:25px'><b>Heavy</b></span></div>";
		}

	}
	
	if(responseJson.currently.precipProbability != undefined){
		html_txt+="<div class='leftDiv' align='right' style=' min-width: 300px; font-size:18px; margin-top:-25px'>Chance&nbsp;of&nbsp;Rain:&nbsp;</div>";
		if(responseJson.currently.precipProbability == undefined){
			html_txt+="<div class='rightDiv'><span style='font-size:25px'><b>N/A</b></span></div>";
		}
		else{
			html_txt+="<div class='rightDiv' style='font-size:18px;'><span style='font-size:25px'><b>"+Math.floor(responseJson.currently.precipProbability*100)+"</b></span>&#65130;</div>";
		}
	}

	if(responseJson.currently.windSpeed != undefined){
		html_txt+="<div class='leftDiv' align='right' style=' min-width: 300px; font-size:18px; margin-top:-25px'>Wind&nbsp;Speed:&nbsp;</div>";
		if(responseJson.currently.windSpeed == undefined){
			html_txt+="<div class='rightDiv' style='font-size:18px;'><span style='font-size:25px'><b>N/A</b></span></div>";
		}
		else{
			html_txt+="<div class='rightDiv' style='font-size:18px;'><span style='font-size:25px'><b>"+responseJson.currently.windSpeed+"</b>&nbsp;</span>mph</div>";
		}
	}


	if(responseJson.currently.humidity != undefined){
		html_txt+="<div class='leftDiv' align='right' style=' min-width: 300px; font-size:18px; margin-top:-25px'>Humidity:&nbsp;</div>";
		if(responseJson.currently.humidity == undefined){
			html_txt+="<div class='rightDiv'><span style='font-size:25px'><b>N/A</b></span></div>";
		}
		else{
			html_txt+="<div class='rightDiv' style='font-size:18px;'><span style='font-size:25px'><b>"+Math.floor(responseJson.currently.humidity*100)+"</b></span>&#65130;</div>";
		}
	}

	if(responseJson.currently.visibility != undefined){
		html_txt+="<div class='leftDiv' align='right' style=' min-width: 300px; font-size:18px; margin-top:-25px'>Visibility:&nbsp;</div>";
		if(responseJson.currently.visibility == undefined){
			html_txt+="<div class='rightDiv'><span style='font-size:25px'><b>N/A</b></span></div>";
		}
		else{
			html_txt+="<div class='rightDiv'style='font-size:18px;'><span style='font-size:25px'><b>"+responseJson.currently.visibility+"</b>&nbsp;</span>mi</div>";
		}
	}


	
	html_txt+="<div class='leftDiv' align='right' style=' min-width: 300px; font-size:18px; margin-top:-25px'>Sunrise/Sunset:&nbsp;</div>";
	var timezone = responseJson.timezone;
	if(responseJson.daily.data[0].sunriseTime == undefined){
		html_txt+="<div class='rightDiv'><span style='font-size:25px'><b>N/A</b></span>/</div>";
	}
	else{
		var usaTime = new Date(responseJson.daily.data[0].sunriseTime*1000).toLocaleString("en-US", {timeZone: timezone});
		usaTime = new Date(usaTime);
		var timeToDisplay = usaTime.toLocaleString().slice(11);
		timeToDisplay = timeToDisplay.split(":");
		var am_pm = timeToDisplay[2].split(" ");
		html_txt+="<div class='rightDiv' style='font-size:18px;'><span style='font-size:25px'><b>"+timeToDisplay[0]+"</b></span>&nbsp;"+am_pm[1]+"/&nbsp;</div>";
	}
	if(responseJson.daily.data[0].sunsetTime == undefined){
		html_txt+="<div class='rightDiv'><span style='font-size:25px'><b>N/A</b></span></div>";
	}
	else{
		usaTime = new Date(responseJson.daily.data[0].sunsetTime*1000).toLocaleString("en-US", {timeZone: timezone});
		usaTime = new Date(usaTime);
		var timeToDisplay = usaTime.toLocaleString().slice(11);
		timeToDisplay = timeToDisplay.split(":");
		var am_pm = timeToDisplay[2].split(" ");
		html_txt+="<div class='rightDiv' style='font-size:18px;'><span style='font-size:25px'><b>"+timeToDisplay[0]+"</b></span>&nbsp;"+am_pm[1]+"</div>";
	}


	html_txt += "</div>";


	
	div.innerHTML = html_txt;
	
	
}


google.charts.load('current', {packages: ['corechart', 'line']});

function drawGraph() {
	  document.getElementById("chart_div").style.display="block";
	  document.getElementById("down_arrow").style.display="none";
	  document.getElementById("up_arrow").style.display="block";
      var data = new google.visualization.DataTable();
      data.addColumn('number', 'X');
      data.addColumn('number', 'T');
      
      for(var j=0 ; j< responseJson.hourly.data.length ; j++){
      	data.addRows([
        [j, responseJson.hourly.data[j].temperature]
      ]);

      }

      var options = {
        hAxis: {
          title: 'Time',
          gridlines:{
          	count:5
          }
        },
        vAxis: {
          title: 'Temperature',
          textPosition: 'none',
          gridlines:{
          	count:3
          }
        },
        curveType: 'function',
        backgroundColor: 'white',
        colors: ['rgb(189,213,215)']
      };

      var chart = new google.visualization.LineChart(document.getElementById('chart_div'));
      chart.draw(data, options);
    }


function downArrowBack(){
	if(document.getElementById("down_arrow").style.display === "none"){
		document.getElementById("down_arrow").style.display = "block";
	}
	if(document.getElementById("up_arrow").style.display === "block"){
		document.getElementById("up_arrow").style.display = "none";
	}
	if(document.getElementById("chart_div").style.display === "block"){
		document.getElementById("chart_div").style.display = "none";
	}
}


function dailyWeatherDetail(timeGiven){

	var xhr;
	if(window.XMLHttpRequest){
		xhr = new XMLHttpRequest();
	}
	
	xhr.open("GET","http://csci571hw6sapandeep.appspot.com?latitude="+responseJson2.latitude+"&longitude="+responseJson2.longitude+"&time="+timeGiven,false);
	xhr.send();
	if(xhr.readyState==4 && xhr.status==200){
		var response = xhr.responseText;
		responseJson = JSON.parse(response);
		generateDailyWeatherDetail();
	}
	
		

}




function generate_second_part(){

	var second_div = document.getElementById("second_part");
	

	var html_txt ="";
	html_txt += "<table>";
	html_txt += "<tr><th>Date</th><th>Status</th><th>Summary</th><th>TemperatureHigh</th><th>TemperatureLow</th><th>Wind Speed</th></tr>";
	if(responseJson2.daily.data != undefined){
		for(var i=0; i<responseJson2.daily.data.length; i++){
		html_txt += "<tr><td>"+(new Date(responseJson2.daily.data[i].time*1000)).toISOString().slice(0,10)+"</td>";

		if(responseJson2.daily.data[i].icon == "partly-cloudy-day" || responseJson2.daily.data[i].icon == "partly-cloudy-night"){
			html_txt += "<td style='width:20px;'><img src ='https://cdn2.iconfinder.com/data/icons/weather-74/24/weather-02-512.png'></td>";
		}

		else if(responseJson2.daily.data[i].icon == "clear-day" || responseJson2.daily.data[i].icon == "clear-night"){
			html_txt += "<td style='width:20px;'><img src ='https://cdn2.iconfinder.com/data/icons/weather-74/24/weather-12-512.png'></td>";
		}

		else if(responseJson2.daily.data[i].icon == "rain"){
			html_txt += "<td style='width:20px;'><img src ='https://cdn2.iconfinder.com/data/icons/weather-74/24/weather-04-512.png'></td>";
		}

		else if(responseJson2.daily.data[i].icon == "snow"){
			html_txt += "<td style='width:20px;'><img src ='https://cdn2.iconfinder.com/data/icons/weather-74/24/weather-19-512.png'></td>";
		}

		else if(responseJson2.daily.data[i].icon == "sleet"){
			html_txt += "<td style='width:20px;'><img src ='https://cdn2.iconfinder.com/data/icons/weather-74/24/weather-07-512.png'></td>";
		}

		else if(responseJson2.daily.data[i].icon == "fog"){
			html_txt += "<td style='width:20px;'><img src ='https://cdn2.iconfinder.com/data/icons/weather-74/24/weather-28-512.png'></td>";
		}

		else if(responseJson2.daily.data[i].icon == "cloudy"){
			html_txt += "<td style='width:20px;'><img src ='https://cdn2.iconfinder.com/data/icons/weather-74/24/weather-01-512.png'></td>";
		}

		

		html_txt +="<td style='cursor:pointer' onclick= dailyWeatherDetail("+responseJson2.daily.data[i].time+")>"+responseJson2.daily.data[i].summary+"</td><td>"+responseJson2.daily.data[i].temperatureHigh+"</td><td>"+responseJson2.daily.data[i].temperatureLow+"</td><td>"+responseJson2.daily.data[i].windSpeed+"</td></tr>";
		}
	}
	html_txt += "</table>";
	document.getElementById("second_part").innerHTML = html_txt;
}


function generate_first_part(){

	var c = "";
	var c2 ="";
	c = document.getElementById("city").value;
	if(jsonObj.city != undefined){
		c2 = jsonObj.city;
	}

	var div = document.getElementById("first_part");
	div.setAttribute('style','height: 270px; width: 400px; margin-left: auto; margin-right: auto;background-color: rgb(38, 198, 248);border-radius: 20px;margin-bottom: 15px;color:white;');
	

	var html_txt ="<br>";
	if(c==""){
		html_txt += "<h1 style='margin-left:20px; margin-top:0px'>"+c2+"</h1>";
	}
	else{
		html_txt += "<h1 style='margin-left:20px; margin-top:0px'>"+c+"</h1>";
	}
	var jsonTimezone = "";
	if(responseJson2.timezone != undefined){
		jsonTimezone = responseJson2.timezone;
	}
	html_txt += "<p style='margin-left:20px; margin-top: -25px'>"+jsonTimezone+"</p>";
	var jsonTemperature = "";
	if(responseJson2.currently.temperature != undefined){
		jsonTemperature = responseJson2.currently.temperature;
	}
	html_txt += "<p style='margin-left:20px; margin-top: -10px; font-size:95px'><b>"+Math.round(jsonTemperature)+"</b><img src ='https://cdn3.iconfinder.com/data/icons/virtual-notebook/16/button_shape_oval-512.png' align='top' style=' margin-top:5px; margin-left:2px; width:3%; height:auto'><span style='font-size:45px'><b>F</b></span></p>";
	var jsonSummary = "";
	if(responseJson2.currently.summary != undefined){
		jsonSummary = responseJson2.currently.summary
	}
	html_txt += "<h1 style='margin-left:20px; margin-top: -100px' >"+jsonSummary+"</h1>";
	var marginValue = 50;

	if(responseJson2.currently.cloudCover == 0 || responseJson2.currently.cloudCover == undefined){

		if(responseJson2.currently.humidity != 0 && responseJson2.currently.humidity != undefined){
			html_txt += "<div class='item' style='margin-left:15px;'><img src='https://cdn2.iconfinder.com/data/icons/weather-74/24/weather-16-512.png' title='Humidity'/><span class='caption'>"+responseJson2.currently.humidity+"</span></div>";
		}
		
		if(responseJson2.currently.pressure != 0 && responseJson2.currently.pressure != undefined){
		html_txt += "<div class='item' style='margin-left:24px;'><img src='https://cdn2.iconfinder.com/data/icons/weather-74/24/weather-25-512.png' title='Pressure'/><span class='caption'>"+responseJson2.currently.pressure+"</span></div>";
		}

		if(responseJson2.currently.windSpeed != 0 && responseJson2.currently.windSpeed != undefined){
			html_txt += "<div class='item' style='margin-left:24px;'><img src='https://cdn2.iconfinder.com/data/icons/weather-74/24/weather-27-512.png' title='WindSpeed'/><span class='caption'>"+responseJson2.currently.windSpeed+"</span></div>";
		}
		if(responseJson2.currently.visibility != 0 && responseJson2.currently.visibility != undefined){
			html_txt += "<div class='item' style='margin-left:24px;'><img src='https://cdn2.iconfinder.com/data/icons/weather-74/24/weather-30-512.png' title='Visibility'/><span class='caption'>"+responseJson2.currently.visibility+"</span></div>";
		}
		

		if(responseJson2.currently.ozone != 0 && responseJson2.currently.ozone != undefined){
			html_txt += "<div class='item' style='margin-left:24px;'><img src='https://cdn2.iconfinder.com/data/icons/weather-74/24/weather-24-512.png' title='Ozone'/><span class='caption'>"+responseJson2.currently.ozone+"</span></div>";
		}

	}



	else{


		if(responseJson2.currently.humidity != 0 && responseJson2.currently.humidity != undefined){
			html_txt += "<div class='item' style='margin-left:15px;'><img src='https://cdn2.iconfinder.com/data/icons/weather-74/24/weather-16-512.png' title='Humidity'/><span class='caption'>"+responseJson2.currently.humidity+"</span></div>";
		}
		
		if(responseJson2.currently.pressure != 0 && responseJson2.currently.pressure != undefined){
		html_txt += "<div class='item' style='margin-left:15px;'><img src='https://cdn2.iconfinder.com/data/icons/weather-74/24/weather-25-512.png' title='Pressure'/><span class='caption'>"+responseJson2.currently.pressure+"</span></div>";
		}

		if(responseJson2.currently.windSpeed != 0 && responseJson2.currently.windSpeed != undefined){
			html_txt += "<div class='item'><img src='https://cdn2.iconfinder.com/data/icons/weather-74/24/weather-27-512.png' title='WindSpeed'/><span class='caption'>"+responseJson2.currently.windSpeed+"</span></div>";
		}
		if(responseJson2.currently.visibility != 0 && responseJson2.currently.visibility != undefined){
			html_txt += "<div class='item'><img src='https://cdn2.iconfinder.com/data/icons/weather-74/24/weather-30-512.png' title='Visibility'/><span class='caption'>"+responseJson2.currently.visibility+"</span></div>";
		}
		
		if(responseJson2.currently.cloudCover != 0 && responseJson2.currently.cloudCover != undefined){
			html_txt += "<div class='item'><img src='https://cdn2.iconfinder.com/data/icons/weather-74/24/weather-28-512.png' title='CloudCover'/><span class='caption'>"+responseJson2.currently.cloudCover+"</span></div>";
		}

		if(responseJson2.currently.ozone != 0 && responseJson2.currently.ozone != undefined){
			html_txt += "<div class='item'><img src='https://cdn2.iconfinder.com/data/icons/weather-74/24/weather-24-512.png' title='Ozone'/><span class='caption'>"+responseJson2.currently.ozone+"</span></div>";
		}
}

	document.getElementById("first_part").innerHTML = html_txt;
	
	document.getElementById("first_part").style.display = "block";
	document.getElementById("second_part").style.display = "block";
	document.getElementById("first_part_afterClick").style.display = "none";
	document.getElementById("chart_div").style.display = "none";
	document.getElementById("dailyWeatherDetail").style.display = "none";
	document.getElementById("dayshourlyweather").style.display = "none";
	document.getElementById("up_arrow").style.display="none";
	document.getElementById("down_arrow").style.display="none";
	generate_second_part();
}


function validateForm(){
	var error = "";
	var streetValue = document.getElementById('street').value;
	cityValue = document.getElementById('city').value;
	var index = document.getElementById('state').selectedIndex;
	if((streetValue=="" || cityValue=="" || index == 0) && !document.getElementById('Current_location').checked){
		document.getElementById("errormessage").innerHTML = "Please check the input address.";
		document.getElementById("errormessage").style.display="block";
		document.getElementById("first_part").style.display = "none";
		document.getElementById("second_part").style.display = "none";
		document.getElementById("first_part_afterClick").style.display = "none";
		document.getElementById("chart_div").style.display = "none";
		document.getElementById("dailyWeatherDetail").style.display = "none";
		document.getElementById("dayshourlyweather").style.display = "none";
		document.getElementById("down_arrow").style.display = "none";
		document.getElementById("up_arrow").style.display="none";
		return false;
	}
	else if(document.getElementById('Current_location').checked){
		document.getElementById("errormessage").style.display="none";
		var xmlhttp;
		if(window.XMLHttpRequest){
			xmlhttp = new XMLHttpRequest();
		}
		xmlhttp.open("GET","http://ip-api.com/json",false);
		xmlhttp.send();

		if(xmlhttp.readyState==4 && xmlhttp.status==200){
			var jsonObj = JSON.parse(xmlhttp.responseText);
			if(jsonObj.lat != undefined){
				document.getElementById("current_latitude").value = jsonObj.lat;
			}
			if(jsonObj.lon != undefined){
				document.getElementById("current_longitude").value = jsonObj.lon;
			}
		}
		
	

		var xhr2;
		if(window.XMLHttpRequest){
			xhr2 = new XMLHttpRequest();
		}
		
		xhr2.open("GET","http://csci571hw6sapandeep.appspot.com?current_latitude="+document.getElementById('current_latitude').value+"&current_longitude="+document.getElementById('current_longitude').value,false);
		xhr2.send();
		if(xhr2.readyState==4 && xhr2.status==200){
			var response2 = xhr2.responseText;
			responseJson2 = JSON.parse(response2);
			
		}
	}
	else{
		document.getElementById("errormessage").style.display="none";
		document.getElementById("up_arrow").style.display="none";
	
	
		var xhr2;
		if(window.XMLHttpRequest){
			xhr2 = new XMLHttpRequest();
		}
		
		xhr2.open("GET","http://csci571hw6sapandeep.appspot.com?street="+streetValue+"&city="+cityValue+"&state="+document.getElementById('state').options[index].value,false);
		xhr2.send();
		if(xhr2.readyState==4 && xhr2.status==200){
			var response2 = xhr2.responseText;
			responseJson2 = JSON.parse(response2);
	}
}
	if(responseJson2.latitude == undefined){
		document.getElementById("errormessage").innerHTML = "Please check the input address.";
		document.getElementById("errormessage").style.display="block";
		document.getElementById("first_part").style.display = "none";
		document.getElementById("second_part").style.display = "none";
		document.getElementById("first_part_afterClick").style.display = "none";
		document.getElementById("chart_div").style.display = "none";
		document.getElementById("dailyWeatherDetail").style.display = "none";
		document.getElementById("dayshourlyweather").style.display = "none";
		document.getElementById("down_arrow").style.display = "none";
		document.getElementById("up_arrow").style.display="none";
		return false;
	}
	generate_first_part();

}


function disablefields(){
	if(document.getElementById('Current_location').checked){
		document.getElementById('street').value = document.getElementById('street').defaultValue;
		document.getElementById('city').value = document.getElementById('city').defaultValue;
		document.getElementById('state').selectedIndex = 0;
		document.getElementById('street').disabled = true;
		document.getElementById('city').disabled = true;
		document.getElementById('state').disabled = true;
	}
	else{

		document.getElementById('street').disabled = false;
		document.getElementById('city').disabled = false;
		document.getElementById('state').disabled = false;
	}
}

function clearAllValues(){
	document.getElementById('search_form').reset();
	document.getElementById('state').selectedIndex = 0;
	if(document.getElementById('street').disabled == true){
		document.getElementById('street').disabled = false;
	}
	if(document.getElementById('city').disabled == true){
		document.getElementById('city').disabled = false;
	}
	if(document.getElementById('state').disabled == true){
		document.getElementById('state').disabled = false;
	}

	document.getElementById("first_part").style.display = "none";
	document.getElementById("second_part").style.display = "none";
	document.getElementById("first_part_afterClick").style.display = "none";
	document.getElementById("chart_div").style.display = "none";
	document.getElementById("dailyWeatherDetail").style.display = "none";
	document.getElementById("dayshourlyweather").style.display = "none";
	document.getElementById("down_arrow").style.display = "none";
	document.getElementById("up_arrow").style.display="none";
	document.getElementById("errormessage").style.display="none";
}



</script>
</body>
</html>