database = require './config/database.coffee'
application = require './config/application.coffee'

moment = require 'moment'
fs = require 'fs'

sockets = []

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

http = require('http').createServer((req, res) ->
  if req.url == '/'
    res.writeHead 200, {'Content-Type': 'text/html'}
    res.end fs.readFileSync('public/index.html')
  else if req.url == '/css/style.css'
    res.writeHead 200, {'Content-Type': 'text/css'}
    res.end fs.readFileSync('public/css/style.css')
  else if req.url == '/js/jquery.mustache.js'
    res.writeHead 200, {'Content-Type': 'text/javascript'}
    res.end fs.readFileSync('public/js/jquery.mustache.js')
  else if req.url == '/templates/views.html'
    res.writeHead 200, {'Content-Type': 'text/html'}
    res.end fs.readFileSync('public/templates/views.html')
  else
    res.writeHead 404, {"Content-Type": "text/plain"}
    res.end "404 Not Found\n"
).listen application.port

io = require('socket.io').listen(http)
io.set('log level', 1);
io.sockets.on 'connection', (socket) ->
  sockets.push socket

setInterval () ->
  getDatabaseUpdates()
, 1000 * application.updateTime
