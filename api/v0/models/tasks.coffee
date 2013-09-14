tasksSchema = mongoose.Schema
	name: String
	completed:
		type: Boolean
		default: false
	category: String
	created_at:
		type: Date
		default: Date.now
	updated_at:
		type: Date
		default: Date.now

tasksSchema.static "getAll", (cb) ->
	@find {}, cb

tasksSchema.static "getById", (id, cb) ->
	@findOne
		_id: id
	, cb

tasksSchema.static "getAllFromCategory", (category, cb) ->
	@find
		category: category
	, cb

tasksSchema.static "create", (data, cb) ->
	newTask = new Tasks data

	newTask.save cb

tasksSchema.static "updateById", (id, data, cb) ->
	data.updated_at = Date.now()

	@update { _id: id }, data, cb


tasksSchema.static "deleteById", (id, cb) ->
	@remove
		_id: id
	, cb



Tasks = mongoose.model 'Tasks', tasksSchema

module.exports = exports = Tasks