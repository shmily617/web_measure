// var spawn = require('child_process').spawn;
var rcst = [];
// var rcsp = [];

function getRcst (matlabData) {
	var result = matlabData.match(/\d{1,2}\.+\d{4}/g);
	console.log("============"+result);
	return result;
};
function getRcsp (matlabData, callback) {
	var rcsp = matlabData.match(/\d{1,2}\.+\d{4}/g);
	console.log("++++++++++++"+rcsp);
	return callback(rcsp);
};
exports.yinxingResult = function (info, matlabProcess, callback) {
	// var matlabProcess = spawn('/Applications/MATLAB_R2014b.app/bin/matlab',['-nosplash','-nodesktop']);
	console.log(info);
	matlabProcess.stdin.write("yinxing("+info+")"+ "\n");
	console.log("Start calculate----------------");

	matlabProcess.stderr.on('data', function (data) {
		console.log("err is: " + data);
		return callback(data);
	});
	matlabProcess.stdout.on('data', function (data) {
		var matlabData = data.toString();
		console.log("=====", matlabData);
		if (matlabData.indexOf("arcst") >= 0) {
			rcst = getRcst(matlabData);
		}
		if (matlabData.indexOf("arcsp") >= 0) {
			getRcsp(matlabData, function(rcsp) {
				return callback(null, rcst, rcsp);
			});
		};
	});
	matlabProcess.on('exit', function (code) {
		console.log('child_process exited with code: ' + code);
	});
}; 