`use babel`

let char = require("./character"),
    moment = require("moment-timezone");

module.exports = AtomKanColle = {

    config: {
        inJapan: {
            title: 'Use the time in Japan?',
            type: 'boolean',
            "default": true
        },
        character: {
            title: 'Your waifu?',
            type: 'string',
            "default": 'Yamato',
            "enum": ['Yamato']
        }
    },

    activate(state) {
        this.notify();
    },

    deactivate() {},

    notify() {
        let currentHour = moment().hour();
        if (this.getConfig('inJapan') === true) {
            currentHour += 1;
        }
        this.message = this.getHourNotification(currentHour);
        atom.notifications.addSuccess(this.message);
        return this.playSound(currentHour);
    },

    remains(nextHour = moment().minute()) {
        let remaining_time = 60 - nextHour;

        if (nextHour === 0) {
            this.notify();
            return 0;
        } else {
            setTimeout(this.notify(), remaining_time * 60 * 1000);
            return remaining_time;
        }
    },

    getTime(time) {
        if (time.length > 2) {
            return time;
        }

        if (time < 10) {
            time = "0" + time;
        }
        return time + "00";
    },

    playSound(time) {
        let src = this.getSoundSrc(time);

        new Audio(src).play();
        return src;
    },

    getSoundSrc(hour) {
        let character = this.getConfig('character');
        hour = this.getTime(hour);
        return char[character]["notification"]["hour"]["voice"][hour];
    },

    getHourNotification(hour) {
        let time = this.getTime(hour),
            name = this.getConfig('character');
        return char[name]["notification"]["hour"]["japanese"][time];
    },

    getConfig(config) {
        return atom.config.get(`atom-kancolle.${config}`);
    }
};
