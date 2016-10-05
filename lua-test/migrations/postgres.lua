return {
	{
		name = "2016-10-05_store_last_request",
		up = [[
			CREATE TABLE IF NOT EXISTS last_request(
				id uuid,
				custom_id text,
				link text,
				created_at timestamp without time zone default (CURRENT_TIMESTAMP(0) at time zone 'utc')
			);
		]],
		down = [[
			DROP TABLE last_request;
		]]
	}
}