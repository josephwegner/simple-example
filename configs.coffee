# If no env, set to local
if not process.env?.application_env
	process.env.application_env = "local"

configs = {
	name: "SimpleToDo"
}


switch process.env.application_env
	when "local"
		configs.mongoURL = "mongodb://localhost/simpledb"
		configs.host = "localhost"
		configs.port = "3333"
		configs.url = "http://localhost:3333"

module.exports = exports = configs
