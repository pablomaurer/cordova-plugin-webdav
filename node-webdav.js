let request = require('request');
let parser = require('xml2json');

        request({
            method: 'MKCOL',
            url: 'https://domain.com/dav/newdir',
            auth: auth
        }, function (error, response, body) {
            console.log('error', error);
            // console.log('response', response);
            console.log('body', body);
            let json = parser.toJson(body);
            console.log("to json -> %s", json);
        });

        request({
            method: 'PROPFIND',
            url: 'https://domain.com/dav',
            auth: auth
        }, function (error, response, body) {
            console.log('error', error);
            // console.log('response', response);
            console.log('body', body);
            let json = parser.toJson(body);
            console.log("to json -> %s", json);
        });

        fs.createReadStream(newFilePath).pipe(request({
            method: 'PUT',
            url: 'https://domain.com/dav/newfile.txt',
            auth: auth
        }, function (error, response, body) {
            console.log('error', error);
            // console.log('response', response);
            console.log('body', body);
        }));
