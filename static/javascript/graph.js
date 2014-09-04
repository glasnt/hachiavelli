
var context = cubism.context()
	.serverDelay(0)
	.clientDelay(0)
	.step(1*1000) //1e3)
	.size(600)
	.stop();

datum = [];

machiavelli = context.machiavelli("http://localhost:3000");
datum.push(machiavelli.metric("BENHUR~20xeHun0lP6","SineWave"));
										   
d3.select("#horizon_graph").call(function(div) {                                   
	div.append("div")                                                          
		.attr("class", "axis")                                             
		.call(context.axis().orient("top"));                               

	div.selectAll(".horizon")
		.data(datum)
		.enter().append("div")
		.attr("class", "horizon")
		.call(
			context.horizon()
			.height(50)
		); 

	div.append("div")
		.attr("class", "rule")
		.call(context.rule());
});


// On mousemove, reposition the chart values to match the rule.
context.on("focus", function(i) {
	d3.selectAll(".value").style("right", i == null ? null : context.size() - i + "px");
});

