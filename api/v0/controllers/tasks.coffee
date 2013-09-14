TasksController =
	options: {}
	routes:
		getAllTasks: 
			method: "GET"
			path: []

		getTask:
			method: "GET"
			path: ["*identifier"]

		getCategoryTasks:
			method: "GET"
			path: ["category", "*identifier"]

		createTask: 
			method: "POST"
			path: [""]

		updateTask:
			method: "PUT"
			path: ["*identifier"]

		deleteTask:
			method: "DELETE"
			path: ["*identifier"]

		completeTask:
			method: "PUT"
			path: ["*identifier"]

	actions:
		getAllTasks: (req, res, params) ->
			Tasks = mongoose.model "Tasks" 

			Tasks.getAll (err, allTasks) =>
				if err
					console.log err
					@responses.internalError res
				else
					@responses.respond res, allTasks

		getTask: (req, res, params) ->
			Tasks = mongoose.model "Tasks"

			Tasks.getById params.identifier, (err, task) =>
				if err
					console.log err
					@responses.internalError res
				else
					@responses.respond res, task

		getCategoryTasks: (req, res, params) ->
			Tasks = mongoose.model "Tasks"

			Tasks.getAllFromCategory category, (err, catTasks) =>
				if err
					console.log err
					@responses.internalError res
				else
					@responses.respond res, catTasks

		createTask: (req, res, params) ->
			Tasks = mongoose.model "Tasks"

			data = ""

			req.on 'data', (chunk) ->
				data += chunk

			req.on 'end', () =>
				#You should do this in a try/catch, but I'm leaving it simple for the example
				taskInfo = JSON.parse data
				Tasks.create data, (err, task) =>
					if err
						console.log err
						@responses.internalError res
					else
						@responses.respond res, task

		updateTask: (req, res, params) ->
			Tasks = mongoose.model "Tasks"

			data = ""

			req.on 'data', (chunk) ->
				data += chunk

			req.on 'end', () =>
				#You should do this in a try/catch, but I'm leaving it simple for the example
				taskInfo = JSON.parse data
				Tasks.updateById params.identifier, data, (err, task) =>
					if err
						console.log err
						@responses.internalError res
					else
						@responses.respond res, task

		deleteTask: (req, res, params) ->
			Tasks = mongoose.model "Tasks"

			Tasks.deleteById params.identifier, (err) =>
				if err
					console.log err
					@responses.internalError res
				else
					@responses.respond res

		completeTask: (req, res, params) ->
			Tasks = mongoose.model "Tasks"

			Tasks.getById params.identifier, (err, task) =>
				if err
					console.log err
					@responses.internalError res
				else
					if task.completed
						#If the task is already completed, just return a 200 because it's already done
						@responses.respond res
					else
						task.completed = true
						task.save (err) =>
							if err
								@responses.internalError res
							else
								@responses.respond res



	helpers: 
		generateKey: (cb) ->
			crypto.randomBytes 256, (err, buff) ->
				cb? err, buff.toString 'hex'

module.exports = exports = TasksController