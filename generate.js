var fs = require('fs');

function getAllFiles(root) {
  var result = [], files = fs.readdirSync(root);
    files.forEach(function(file) {
    var pathname = root+ "/" + file
        , stat = fs.lstatSync(pathname)
    if (stat === undefined) return
 
    if (!stat.isDirectory()) {
    	if(file.match("ViewController.h")){
    		var index = file.indexOf('.');
      		result.push(file.substr(0, index));

    	}
    } else {
        result = result.concat(getAllFiles(pathname))
    }
  });
  return result
}

var files = getAllFiles("../MXNavigationController");
fs.open("Header/PageConfig.h","w",0666,function(e,fd){
	if (e) {throw e};
	files.forEach(function(file){
        var reg = new RegExp('ViewController','g');
        var str = file.replace(reg, '_page');

		var temp = ' k_' + str.toLocaleUpperCase() + '     @"' + file + '"\n';
		var def = "#define"
		var result = def + temp;
		fs.write(fd,result,function(e){
			if (e) {throw e};

		})
	})
});
