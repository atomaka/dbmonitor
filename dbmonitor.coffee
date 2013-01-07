database = require './config/database.coffee'
application = require './config/application.coffee'

moment = require 'moment'
io = require('socket.io').listen(application.port)

sockets = []
io.set('log level', 1);

db = require('mysql-native').createTCPClient(database.host, database.port)
db.auth database.database, database.username, database.password
db.auto_prepare = true

checkDate = moment().add('minutes', -5)

getDatabaseUpdates = () ->
  query = "SELECT " + application.timestamp_column + "," + application.columns.join(',') + " FROM " + application.table + " WHERE " + application.where + " AND " + application.timestamp_column + " >  '" + checkDate.format('YYYY-MM-DD HH:mm:ss') + "'"
  db.query(query).addListener 'row', (job) ->
    jobDate = moment(job[application.timestamp_column], 'YYYY-MM-DD HH:mm:ss')
    checkDate = jobDate if jobDate > checkDate
    updateClient job

updateClient = (job) ->
  for client in sockets
    client.emit 'update', job

io.sockets.on 'connection', (socket) ->
  sockets.push socket

setInterval () ->
  getDatabaseUpdates()
, 1000 * application.updateTime
