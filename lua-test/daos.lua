local SCHEMA = {
	primary_key = {"id"},
	table = "last_request",
	fields = {
		id = {type="id", dao_insert_value=true},
		created_at = {type="timestamp", immutable=true, dao_insert_value=true},
		custom_id = {type="text", required=true, foreign="consumers:id"},
		link ={type="text", required=true, unique=false}
	}
}

return {last_request = SCHEMA}