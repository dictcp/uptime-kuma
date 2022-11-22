const WhoisLight = require("whois-light");
const { getDaysRemaining } = require("./server/util-server")
const split2 = require("split2");
const moment = require("moment");
const { debug } = require("./src/util");


process.stdin.pipe(require('split')()).on('data', processLine)

async function processLine(line) {

  const domain = line.trim();
  if (domain.length > 0) {
    try {
      const whois = await WhoisLight.lookup({ format: true }, domain);
      // console.debug(whois);

      const expiryDates = Object.entries(whois).filter(([key, value]) => key.match(/Expiry Date$/i)).map(([key, value]) => value);

      if (expiryDates != null) {
        //console.log(`${domain}: ${expiryDates}`)
        var expiry;
        if (domain.endsWith("hk")) {
          expiry = moment(expiryDates[0], "DD-MM-YYYY").toDate();
        } else {
          expiry = Date.parse(expiryDates[0]);
        }
        console.info(`${domain} will expired in ${moment(expiry).fromNow('days')}`);

      }
    } catch { console.error("error"); return; }

  }

}



