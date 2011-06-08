$ ->
  days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
  data = [[10, 5, 10, 5, 8, 15, 18], [20, 10, 20, 40, 23, 14, 12]]
  
  [pt, pl, pr, pb] = [20, 20, 20, 20]  # padding
  w = $('#chart').width()  - (pl + pr) # width
  h = $('#chart').height() - (pt + pb) # height
  
  max = d3.max(d3.merge(data))

  # Scales
  x  = d3.scale.linear().domain([0, data[0].length - 1]).range [0, w]
  y  = d3.scale.linear().domain([0, max]).range [h, 0]
  xl = d3.scale.ordinal().domain(d3.range(days.length)).rangeRoundBands([0, w], 0)

  # Base vis layer
  vis = d3.select('#chart')
    .append('svg:svg')
      .attr('width', w + (pl + pr))
      .attr('height', h + pt + pb)
      .attr('class', 'viz')
    .append('svg:g')
      .attr('transform', "translate(#{pl},#{pt})")
  
  # Background bar groups
  bars = vis.selectAll('g.bar')
      .data(days)
    .enter().append('svg:g')
      .attr('transform', (d, i) -> "translate(#{xl(i)}, 0)")
      .attr("class", (d, i) -> if i % 2 == 0 then 'even' else 'odd')
  
  # Background bars
  bars.append("svg:rect")
      .attr("width", xl.rangeBand())
      .attr("height", h)
  
  # Background bar labels
  bars.append('svg:text')
    .text((d) -> d)
    .attr('y', h)
    .attr("dy", "1.5em")
    .attr('dx', "15px")
    
  # Layer group for paths and their points
  lines = vis.selectAll('line.group')
      .data(data)
    .enter().append('svg:g')
      .attr('class', (d, i) -> if i == 0 then 'cats' else 'dogs')
  
  # add path layers to their repesctive group
  lines.append("svg:path")
    .attr("class", (d) -> 'apath')
    .attr "d", d3.svg.line()
      .x((d,i) -> x(i))
      .y((d) -> y(d))
      .interpolate('cardinal')
      .tension(.7)
  
  # add point circles to their respective group
  lines.selectAll('.apath')
    .data((d) -> d)
  .enter().append("svg:circle")
    .attr("class", "point")
    .attr("cx", (d, i) -> x(i))
    .attr("cy", (d) -> y(d))
    .attr("r", 4)
  