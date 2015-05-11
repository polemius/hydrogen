uuid = require 'uuid'
fs = require 'fs'
path = require 'path'

portfinder = require './find-port'

module.exports = ConfigManager =
    fileStoragePath: __dirname

    writeConfigFile: (onCompleted) ->
        filename = 'kernel-' + uuid.v4() + '.json'
        portfinder.findMany 5, (ports) =>
            config = @buildConfiguration ports
            configString = JSON.stringify config
            filepath = path.join(@fileStoragePath, filename)
            fs.writeFileSync filepath, configString
            onCompleted filepath, config

    buildConfiguration: (ports) ->
        config =
            key: ""
            transport: "tcp"
            ip: "127.0.0.1"
            hb_port: ports[0]
            control_port: ports[1]
            shell_port: ports[2]
            stdin_port: ports[3]
            iopub_port: ports[4]

        @startingPort = @startingPort + 5
        return config
