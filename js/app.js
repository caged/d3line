(function() {
  $(function() {
    var bars, data, days, h, lines, max, pb, pl, pr, pt, vis, w, x, xl, y, _ref;
    days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
    data = [[10, 5, 10, 5, 8, 15, 18], [20, 10, 20, 40, 23, 14, 12]];
    _ref = [20, 20, 20, 20], pt = _ref[0], pl = _ref[1], pr = _ref[2], pb = _ref[3];
    w = $('#chart').width() - (pl + pr);
    h = $('#chart').height() - (pt + pb);
    max = d3.max(d3.merge(data));
    x = d3.scale.linear().domain([0, data[0].length - 1]).range([0, w]);
    y = d3.scale.linear().domain([0, max]).range([h, 0]);
    xl = d3.scale.ordinal().domain(d3.range(days.length)).rangeRoundBands([0, w], 0);
    vis = d3.select('#chart').append('svg:svg').attr('width', w + (pl + pr)).attr('height', h + pt + pb).attr('class', 'viz').append('svg:g').attr('transform', "translate(" + pl + "," + pt + ")");
    bars = vis.selectAll('g.bar').data(days).enter().append('svg:g').attr('transform', function(d, i) {
      return "translate(" + (xl(i)) + ", 0)";
    }).attr("class", function(d, i) {
      if (i % 2 === 0) {
        return 'even';
      } else {
        return 'odd';
      }
    });
    bars.append("svg:rect").attr("width", xl.rangeBand()).attr("height", h);
    bars.append('svg:text').text(function(d) {
      return d;
    }).attr('y', h).attr("dy", "1.5em").attr('dx', "15px");
    lines = vis.selectAll('line.group').data(data).enter().append('svg:g').attr('class', function(d, i) {
      if (i === 0) {
        return 'cats';
      } else {
        return 'dogs';
      }
    });
    lines.append("svg:path").attr("class", function(d) {
      return 'apath';
    }).attr("d", d3.svg.line().x(function(d, i) {
      return x(i);
    }).y(function(d) {
      return y(d);
    }).interpolate('cardinal').tension(.7));
    return lines.selectAll('.apath').data(function(d) {
      return d;
    }).enter().append("svg:circle").attr("class", "point").attr("cx", function(d, i) {
      return x(i);
    }).attr("cy", function(d) {
      return y(d);
    }).attr("r", 4);
  });
}).call(this);