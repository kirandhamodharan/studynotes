'use strict'
const cidr = require('./cidr');

exports.handler = function (event, context, callback) {
  var response = {
    statusCode: 200,
    headers: {
      'Content-Type': 'application/json; charset=utf-8',
      "Access-Control-Allow-Headers" : "Content-Type",
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "OPTIONS,POST,GET"
    },
    body: {}
  }
  var returnVal;

  switch(event.httpMethod) {
    case 'GET':
      returnVal = getRandomCIDR(event);
      break;
    case 'POST':
      returnVal = splitVPC(event);
      if (returnVal.valid && returnVal.valid == "N") {
        response.statusCode = 400;
      }
      break;
    default:
  }
  response.body = JSON.stringify(returnVal);
  callback(null, response);
}

function getRandomCIDR(event) {
  var netMask = 16;
  if (event.queryStringParameters && event.queryStringParameters.netMask) {
    let requestedNetMask = event.queryStringParameters.netMask;
    if (requestedNetMask >= 16 && requestedNetMask <= 28)
    netMask = requestedNetMask;
  }
  return cidr.getRandomCIDR(netMask);
}

function splitVPC(event) {
  let event_body = JSON.parse(event.body);
  var validCheck = cidr.preCheckCIDR(event_body);
  if (validCheck.valid != "Y") {
    return validCheck;
  }

  const vpc_cidr = new cidr(event_body);

  validCheck = vpc_cidr.checkCIDR();
  if (validCheck.valid != "Y") {
    return validCheck;
  }
  return vpc_cidr.splitVPCIntoSubnets(event_body.splitBy);
}

//Compress-Archive -Path .\lambda_src\* -DestinationPath .\lambda_src -CompressionLevel Optimal -Force
//zip -vr lambda_src.zip ./lambda_src/ -x "*.DS_Store"