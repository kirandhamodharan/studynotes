const zeroes =    ["",
                 "0",
                 "00",
                 "000",
                 "0000",
                 "00000",
                 "000000",
                 "0000000",
                 "00000000",
                 "000000000",
                 "0000000000",
                 "00000000000",
                 "000000000000",
                 "0000000000000",
                 "00000000000000",
                 "000000000000000",
                 "0000000000000000",
                 "00000000000000000",
                 "000000000000000000",
                 "0000000000000000000",
                 "00000000000000000000",
                 "000000000000000000000",
                 "0000000000000000000000",
                 "00000000000000000000000",
                 "000000000000000000000000"
                ];

const block1Options = [10, 172, 192];

const prefixZeroes = (strBinary, len) => zeroes[len - strBinary.length] + strBinary;

const appendZeroes = (strBinary, len) => strBinary + zeroes[len - strBinary.length];

const applyMask = (strBinary, netMask) => strBinary.substring(0,netMask) + zeroes[32 - netMask];

const powerOfTwo = (num) => {
    var temp = 1, i = 0;
    while (temp < num) {
        temp *= 2; i++;
    }
    return i;
}

const getRandomNumber = (maxValue) => Math.floor(Math.random() * maxValue);

module.exports = { zeroes: zeroes, prefixZeroes: prefixZeroes, applyMask: applyMask, powerOfTwo:powerOfTwo,
     appendZeroes:appendZeroes, getRandomNumber:getRandomNumber, block1Options:block1Options};