var express = require('express');
var bodyParser = require('body-parser');
var session = require('express-session');
var cookieParser = require('cookie-parser');
var hbs = require('hbs');
var mongoose = require('mongoose');
var MongoStore = require('connect-mongo')(session);
var hash = require('./pass').hash;
// var calculateResult = require('./calculate.js').calculateResult;
var longboResult = require('./calculate/longbo/longboCal.js').longboResult;
var yinxingResult = require('./calculate/yinxing/yinxingCal.js').yinxingResult;
var zidingyiResult = require('./calculate/zidingyi/zidingyiCal.js').zidingyiResult;

var spawn = require('child_process').spawn;
var matlabProcess = spawn('/Applications/MATLAB_R2014b.app/bin/matlab',['-nosplash','-nodesktop']);

var app = express();
app.listen(3000);

app.use(bodyParser.urlencoded({extended: false}));
app.use(express.static('public'));
app.set('views', __dirname + '/views');
app.set('view engine', 'html');
app.engine('html', hbs.__express);
app.use(cookieParser());
app.use(session({
	cookie: {maxAge: 1000 * 60 * 60},//an hour
	secret: 'randomBytes',
	store: new MongoStore({db:"myapp"})
}));

mongoose.connect('mongodb://localhost/myapp');
var UserSchema = new mongoose.Schema({
	username: String,
	userpwd: String,
	pwdsalt: String,
	pwdhash: String
});
var userModel = mongoose.model("users", UserSchema);

/*
Help functions
*/
function authenticate (name, pwd, callback) {
	//search user with name, then hash it
	userModel.findOne({
		username: name
	}, 

	function (err, user) {
		if (user) {
			if (err) {throw err;}
			hash(pwd, user.pwdsalt, function (err, hash) {
				if (err) {throw err;}
				if (hash == user.pwdhash) {
					console.log("welcome " + user.username + "!");
					return callback(null, user);
				} else {
					console.log("invalid password!");
					return callback(null);
				}
			});
		} else {
			console.log("cannot find the user!");
			callback(null);
		}
		
	});
};

function userExist (req, res, next) {
	userModel.count({
		username: req.body.username
	},

	function (err, count) {
		if (count === 0) {
			next();
		} else{
			console.log("The username has been registed, please use another name!");
			res.redirect('/register');
		}

	});
};

/* 
Routers
*/
app.get('/longbo', function (req, res) {
	if (req.session.user) {
		res.render('longbo', {dataUser: req.session.user});
	} else {
		res.redirect('/')
	}
});
app.get('/zidingyi', function (req, res) {
	if (req.session.user) {
		res.render('zidingyi', {dataUser: req.session.user});
	} else {
		res.redirect('/')
	}
});
app.get('/yinxing', function (req, res) {
	if (req.session.user) {
		res.render('yinxing', {dataUser: req.session.user});
	} else {
		res.redirect('/')
	}
});
app.get('/', function (req, res) {
	if (req.session.user) {
		res.redirect("/longbo");
	} else{
		res.render('choice');
	}
});
app.get('/index', function (req, res) {
	if (req.session.user) {
		res.render('longbo', {dataUser: req.session.user});
	} else {
		res.redirect('/')
	}
});
app.get('/login', function (req, res) {
	if (req.session.user) {
		res.redirect("/");
	} else{
		res.render('login');
	}
});
app.get('/register', function (req, res) {
	if (req.session.user) {
		res.redirect("/index");
	} else{
		res.render('register');
	}
});
app.get('/logout', function (req, res) {
	// req.clearCookie('connect.sid');
	res.clearCookie('connect.sid', { path: '/' });
	req.session.user = null;
    req.session.destroy(function () {
        res.redirect('/');
    });
});
app.get('/fresh', function (req, res) {
	var userTmp = req.session.user;
	req.session.regenerate(function() {
		req.session.user = userTmp;
		req.session.success = 'Welcome ' + userTmp.username + ' again!';
		console.log(req.session.success);
		res.redirect('/index');
	});
});

app.post('/login', function (req, res) {
	authenticate(req.body.username, req.body.password, function (err, user) {
		if (err) {throw err;}
		if (user) {
			req.session.regenerate(function() {
				req.session.user = user;
				req.session.success = 'Authenticated as ' + user.username + '. And welcome!';
				console.log(req.session.success);
				res.redirect('/index');
			});
		} else{
			req.session.error = 'Authentication failed, please check your username and password.';
			console.log(req.session.error);
			res.redirect('/login');
		}
	});
});

app.post('/register', userExist, function (req, res) {
	var userName = req.body.username;
	var userPwd = req.body.password;
	console.log(userName);
	console.log(userPwd + '/n');

	hash(userPwd, function (err, salt, hash) {
		var user = new userModel({
			username: userName,
			userpwd: userPwd,
			pwdsalt: salt,
			pwdhash: hash
		});
		user.save(function (err, newUser) {
			if (err) {throw err;}
			authenticate(newUser.username, newUser.userpwd, function (err, user) {
				if (user) {
					req.session.regenerate(function(){
                        req.session.user = user;
                        req.session.success = 'Authenticated as ' + user.username + '. And welcome!';
                        console.log(req.session.success);
                        res.redirect('/index');
                    });
				}
			});
		});
	});
});

app.post('/longbo', function(req, res) {
	var longbo = req.body.longboLayerNum;
		// console.log("======="+longbo);
	// console.log(longbo.longboLayerNum);
	if (longbo) {
		longboResult(longbo, matlabProcess, function (err ,result){
			if (err) {
				throw err;
			} else{
				var position = "pic/longbo.png";
				// var dataOut = result;
				console.log("app: ", result);
				console.log("type: ", typeof(result));
				res.render('longboResult',{
					dataOut: result,
					position: position
				});
				console.log("\n" + "*******************finish calculate!" + "\n");
			};
		});
	} else {
 		res.redirect('/logout');
 	}
});
var adsa = function(yinxing, r1, ε1, r2, ε2, res) {
	if (yinxing) {
		console.log("====", yinxing);
		yinxingResult(yinxing, matlabProcess, function (err, rcst, rcsp){
			if (err) {
				throw err;
			} else{
				//TODO:
				console.log('rcst: ', rcst);
				console.log('rcsp: ', rcsp);
				res.render('yinxingResult', {
					rcst: rcst,
					rcsp: rcsp,
					r1: r1,
					ε1: ε1,
					r2: r2,
					ε2: ε2,
					position: "pic/yinxing.png"
				});
			}
		});
	} else{
		res.redirect('/logout');
	}
};

app.post('/yinxingOne', function(req, res) {
	var r1 = 'r1:'+ ' ' +'3.0000';
	var ε1 = 'ε1:'+ ' ' +'0+0j';
	var r2 = 'r2:'+ ' ' +'3.0005';
	var ε2 = 'ε2:'+ ' ' +'27+12.3j';
	adsa(1, r1, ε1, r2, ε2, res);
});
app.post('/yinxingTwo', function(req, res) {
	var r1 = 'r1:'+ ' ' +'3.0000';
	var ε1 = 'ε1:'+ ' ' +'0+0j';
	var r2 = 'r2:'+ ' ' +'3.000000001';
	var ε2 = 'ε2:'+ ' ' +'1.21206+3.46553j';	
	adsa(2, r1, ε1, r2, ε2, res);

});

app.post('/zidingyi', function(req, res) {
	var info = req.body;
	if (info) {
		zidingyiResult(info, matlabProcess, function (err ,rcst, rcsp){
			if (err) {
				throw err;
			} else{
				console.log('rcst: ', rcst);
				console.log('rcsp: ', rcsp);
				res.render('zidingyiResult', {
					dataIn: info,
					rcst: rcst,
					rcsp: rcsp,
					position: "pic/zidingyi.png"
				});
				console.log("\n" + "*******************finish calculate!" + "\n");
			};
		});
	} else {
 		res.redirect('/logout');
 	}
});

process.on('uncaughtException', function (err) {
	console.log(err);
});
