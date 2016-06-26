var r = [];
var z = [];
var j = [];
var rcst = [];

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

function getRZJ(info) {
	var count = 1;
	var rzj = [];
	for (key in info) {
		if (key === 'layer') {
			continue;
		};
		rzj.push(+info[key]);
	}
	for (var i = 0; i < info.layer * 3; i++) {
		if (count === 1) {
			r.push(rzj[i]);
		} else if (count === 2) {
			z.push(rzj[i]);
		} else if (count === 3) {
			j.push(rzj[i]);
			count = 1;
			continue;
		}
		count++;
	}
};

function clearRZJ() {
	r = [];
	z = [];
	j = [];
};

exports.zidingyiResult = function(info, matlabProcess, callback) {
	console.log(info);
	getRZJ(info);

	console.log("zidingyi("+info.layer+",["+r.join(',')+"],["+z.join(',')+"],["+j.join(',')+"])");
	matlabProcess.stdin.write("zidingyi("+info.layer+",["+r.join(',')+"],["+z.join(',')+"],["+j.join(',')+"])"+ "\n");
	// console.log("Start calculate----------------");
	// matlabProcess.stdin.write("zidingyi(2,[1,4],[2,5],[3,6])"+ "\n");


	matlabProcess.stderr.on('data', function (data) {
		console.log("err is: " + data);
		return callback(data);
	});
	matlabProcess.stdout.on('data', function (data) {
		var matlabData = data.toString();
		console.log(matlabData);
		if (matlabData.indexOf("arcst") >= 0) {
			rcst = getRcst(matlabData);
		}
		if (matlabData.indexOf("arcsp") >= 0) {
			getRcsp(matlabData, function(rcsp) {
				clearRZJ();
				return callback(null, rcst, rcsp);
			});
		};
	});
	matlabProcess.on('exit', function(code) {
		console.log('child_process exited with code: ' + code);
	});
};