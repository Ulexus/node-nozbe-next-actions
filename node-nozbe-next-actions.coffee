rc = require 'node-restclient'
_ = require('underscore')._

username = 'youremail@nowhere.com'
password = 'supersecretpassword'

class Nozbe
  login: (cb)->
    rc.get "https://webapp.nozbe.com/api/login/email-#{username}/password-#{password}",(res)->
      try
        ret = JSON.parse res
      catch err
        return cb? "Failed login: #{err}\n"
      if ret.key
        @key = ret.key
        return cb? null,ret.key
      else
        return cb? "Failed login\n"

  getNextActions: (key,cb)->
    url = "https://webapp.nozbe.com/api/actions/what-next/key-#{key}"
    rc.get "https://webapp.nozbe.com/api/actions/what-next/key-#{key}",(res)->
      try
        ret = JSON.parse res
      catch err
        return cb? "Failed to get next actions: #{err}\n"
      return cb? null,ret
        
n = new Nozbe
n.login (err,key)->
  if err?
    return console.log err
  n.getNextActions key,(err,actions)->
    if err?
      return console.log err
    _.each actions,(a)->
      if not a.done
        console.log a.name
    return

