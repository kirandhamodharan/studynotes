const utils = require('./utils');

class cidr {
    constructor(cidrObj) {
        this.block1 = Number.isInteger(cidrObj.block1)? cidrObj.block1 : parseInt(cidrObj.block1.trim());
        this.block2 = Number.isInteger(cidrObj.block2)? cidrObj.block2 : parseInt(cidrObj.block2.trim());
        this.block3 = Number.isInteger(cidrObj.block3)? cidrObj.block3 : parseInt(cidrObj.block3.trim());
        this.block4 = Number.isInteger(cidrObj.block4)? cidrObj.block4 : parseInt(cidrObj.block4.trim());
        this.netMask = Number.isInteger(cidrObj.netMask)? cidrObj.netMask : parseInt(cidrObj.netMask.trim());
        this.fullBinary = this.get32BitBinary();
        this.recalculateBlocksFromBinary();
    }
    
    get32BitBinary() {
        var returnVal = (utils.prefixZeroes(this.block1.toString(2), 8) + 
        utils.prefixZeroes(this.block2.toString(2), 8) +
        utils.prefixZeroes(this.block3.toString(2), 8) +
        utils.prefixZeroes(this.block4.toString(2), 8));
        returnVal = utils.applyMask(returnVal, this.netMask);
        return returnVal;
    }

    recalculateBlocksFromBinary() {
        var fullBinary = this.fullBinary;
        this.block1 = parseInt(fullBinary.substring(0, 8), 2);
        this.block2 = parseInt(fullBinary.substring(8, 16), 2);
        this.block3 = parseInt(fullBinary.substring(16, 24), 2);
        this.block4 = parseInt(fullBinary.substring(24, 32), 2);
    }

    getSize() {
        var returnVal = 1;
        var i = 0;
        for (i = 0; i < (32 - this.netMask); ++i) {
            returnVal *= 2;
        }
        return returnVal;
    }

    splitVPCIntoSubnets(splitBy) {
        let returnVal = {};
        returnVal.vpc = {"block1": this.block1, "block2": this.block2, "block3": this.block3, 
        "block4": this.block4, "netMask": this.netMask};
        var maskFields = this.fullBinary.substring(0, this.netMask);
        var maxDigits = utils.powerOfTwo(splitBy);
        var i = 0;
        var subnetCidrs = [];
        for (i = 0; i < splitBy; ++i) {
            var strBinIndex = i.toString(2);
            strBinIndex = utils.prefixZeroes(strBinIndex, maxDigits);
            var subnetCidr = cidr.getCIDRFromBinary(utils.appendZeroes(maskFields + strBinIndex, 32), this.netMask + maxDigits);
            subnetCidrs.push({"block1": subnetCidr.block1, "block2": subnetCidr.block2, "block3": subnetCidr.block3, 
            "block4": subnetCidr.block4, "netMask": subnetCidr.netMask});
        }
        returnVal.subnets = subnetCidrs;
        return returnVal;
    }

    checkCIDR() {
        var returnVal = {valid: "Y", errorField:""}

        if (!utils.block1Options.includes(this.block1)) {
            returnVal.valid = "N"; returnVal.errorField = "block1";
            return returnVal;
        }
        if ((this.block1 == 192 && this.block2 != 168) ||
            ((this.block1 == 172) && !(this.block2 >= 16 && this.block2 < 32))) 
        {return {valid: "N", errorField:"block2"}}
        return returnVal;
    }

    static preCheckCIDR(cidrObj) {
        let block1 = Number.isInteger(cidrObj.block1)? cidrObj.block1 : parseInt(cidrObj.block1.trim());
        if (!(block1 >= 0 && block1 < 256)) {return {valid: "N", errorField:"block1"}};

        let block2 = Number.isInteger(cidrObj.block2)? cidrObj.block2 : parseInt(cidrObj.block2.trim());
        if (!(block2 >= 0 && block2 < 256)) {return {valid: "N", errorField:"block2"}};

        let block3 = Number.isInteger(cidrObj.block3)? cidrObj.block3 : parseInt(cidrObj.block3.trim());
        if (!(block3 >= 0 && block3 < 256)) {return {valid: "N", errorField:"block3"}};

        let block4 = Number.isInteger(cidrObj.block4)? cidrObj.block4 : parseInt(cidrObj.block4.trim());
        if (!(block4 >= 0 && block4 < 256)) {return {valid: "N", errorField:"block4"}};

        let netMask = Number.isInteger(cidrObj.netMask)? cidrObj.netMask : parseInt(cidrObj.netMask.trim());
        if (!(netMask >= 16 && netMask <= 28)) {return {valid: "N", errorField:"netMask"}};

        return {valid: "Y", errorField:""};
    }

    static getCIDRFromBinary(fullBinary, netMask) {
        let returnVal = new cidr({'block1': 0, 'block2': 0, 'block3': 0, 'block4': 0, 'netMask':0});
        returnVal.fullBinary = utils.applyMask(fullBinary, netMask);
        returnVal.netMask = netMask;
        returnVal.recalculateBlocksFromBinary();
        return returnVal;
    }

    static getRandomCIDR = (netMask) => {
        
        let block1 = utils.block1Options[utils.getRandomNumber(3)];

        var block2, block3, block4;
        if (block1 == 10) {
            block2 = utils.getRandomNumber(256);
        }
        else if (block1 == 172) {
            block2 = 16 + utils.getRandomNumber(16);
        }
        else {
            block2 = 168;
        }
        block3 = utils.getRandomNumber(256);
        block4 = utils.getRandomNumber(256);
    
        let vpc_cidr = new cidr({'block1': block1, 'block2': block2, 'block3': block3, 'block4': block4, 'netMask':netMask});
    
        return {"block1": vpc_cidr.block1, "block2": vpc_cidr.block2, "block3": vpc_cidr.block3, 
        "block4": vpc_cidr.block4, "netMask": vpc_cidr.netMask};
    }

    toString() {
        return this.block1 + "." + this.block2 + "." +
            this.block3 + "." + this.block4 + "/" + this.netMask + " (" + this.getSize() + ")";
    }

    /*
    static getCIDRFromCidrBlock(cidr_block) {
        cidr_block = cidr_block.trim();
        var split1 = cidr_block.split("/");
        var split2 = split1[0].split(".")
        let block1 = parseInt(split2[0]);
        let block2 = parseInt(split2[1]);
        let block3 = parseInt(split2[2]);
        let block4 = parseInt(split2[3]);
        let netMask = parseInt(split1[1]);

        let cidrObj = {'block1': block1, 'block2': block2, 'block3': block3, 'block4': block4, 'netMask':netMask};
        let returnVal = new Cidr(cidrObj);

        return returnVal;
    }

    printDetails() {
        return `*****
block1: ${this.block1}
block2: ${this.block2}
block3: ${this.block3}
block4: ${this.block4}
Net Mask: ${this.netMask}
Full Binary: ${this.fullBinary}
*****`;
    }
*/
}

module.exports = cidr;