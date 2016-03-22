exports.header = null
exports.footer = null


header: {
  height: "1cm",
  contents: phantom.callback(function(pageNum, numPages) {
    return "<h1>Header <span style='float:right'>" + pageNum + " / " + numPages + "</span></h1>";
  })
},
footer: {
  height: "1cm",
  contents: phantom.callback(function(pageNum, numPages) {
    return "<h1>Footer <span style='float:right'>" + pageNum + " / " + numPages + "</span></h1>";
  })
}
