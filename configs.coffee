# If no env, set to local
if not process.env?.application_env
	process.env.application_env = "local"

configs = {
	name: "Cydoemus"
}


switch process.env.application_env
	when "local"
		configs.mongoURL = "mongodb://localhost/cydoemus"
		configs.host = "localhost"
		configs.port = "3333"
		configs.url = "http://localhost:3333"
		configs.cache = false
		configs.clef =
			app_id: '775da2c4142900d03bf3fca4cb13f93e'
			app_secret: '7d577bf2fdb7b9d92283def6fd3e11fb'

	when "production"
		configs.cache = true
		configs.mongoURL = process.env.MONGOLAB_URI
		configs.port = process.env.PORT or 3333
		configs.url = "http://www.cydoemus.com"
		configs.host = null
		configs.clef =
			app_id: '775da2c4142900d03bf3fca4cb13f93e'
			app_secret: '7d577bf2fdb7b9d92283def6fd3e11fb'

module.exports = exports = configs