// var spawn = require('child_process').spawn;

function getResult (matlabData, callback) {
	// var dataObj = matlabData.split(/[^\d\.]+/);
	var result = matlabData.match(/\d{1}\.+\d{4}/g);

	console.log("============"+result);
	// var result = [];
	// var k = 0;
	// for (var i = 0; i < dataObj.length; i++) {
	// 	if (i == 0 || i == 1 || i == 2 || i == 10 || i == 11 || i == 17) {
	// 		continue;
	// 	} else {
	// 		result[k] = dataObj[i];
	// 		k ++;
	// 	}
	// }
	// console.log("result:"+result);
	return callback(result);
};

exports.longboResult = function (info, matlabProcess, callback) {
	console.log(info);
	matlabProcess.stdin.write("longbo("+info+")"+ "\n");
	console.log("Start calculate----------------");

	matlabProcess.stderr.on('data', function (data) {
		console.log("err is: " + data);
		return callback(data);
	});
	matlabProcess.stdout.on('data', function (data) {
		var matlabData = data.toString();
		console.log(matlabData);
		if (matlabData.indexOf("result") >= 0) {
			getResult(matlabData, function (result) {
				// matlabProcess.kill();
				console.log("clear all and exports the result: ");
				callback(null, result);
			});
		}
		// if (matlabData.indexOf("result") >= 0) {
		// 	matlabProcess.kill();
		// 	console.log("clear all and exports the result: ");
		// 	// console.log(matlabData.match(/\d{1}\.+\d{4}/g));
		// 	var result = matlabData.match(/\d{1}\.+\d{4}/g);
		// 	callback(null, result);
		// 	return callback(result);
		// };
		
	});
	matlabProcess.on('exit', function (code) {
		console.log('child_process exited with code: ' + code);
	});
}; 